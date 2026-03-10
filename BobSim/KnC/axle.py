# axle.py

from scipy.interpolate import UnivariateSpline
import subprocess
import pathlib
import pandas as pd
import numpy as np


class AxleKncReport:
    def __init__(self,
             exec_path: str,
             vehicle_name: str,
             axle_name: str,
             jounce_amplitude: float,
             rack_position: float,
             force_amplitude: float,
             solver: str = "dassl",
             tolerance: float = 1e-4,
             extra_params: str = ""):

        self.exec_path = pathlib.Path(exec_path).resolve()
        if not self.exec_path.is_file():
            raise FileNotFoundError(f"Executable not found: {self.exec_path}")
        
        self.vehicle_name = vehicle_name.lower().replace(" ", "_")
        self.axle_name = axle_name.lower()
        self.jounce_amplitude = float(jounce_amplitude)
        self.rack_position = float(rack_position)
        self.force_amplitude = float(force_amplitude)
        self.solver = solver
        self.tolerance = float(tolerance)
        self.extra_params = extra_params

        base_override = (
            f"jounce_amplitude={self.jounce_amplitude},"
            f"rack_position={self.rack_position},"
            f"force_amplitude={self.force_amplitude}"
        )

        if self.extra_params:
            self.override_string = base_override + "," + self.extra_params
        else:
            self.override_string = base_override

        self.output_dir = (pathlib.Path(__file__).resolve().parent / "results")
        self.output_dir.mkdir(exist_ok=True)

        self.result_file = self.output_dir / (
            f"{self.vehicle_name}_"
            f"{self.axle_name}_"
            f"knc_j{self.jounce_amplitude}_"
            f"r{self.rack_position}_"
            f"f{self.force_amplitude}.csv"
        )

        self.data = None
        self.spliced = {}
        self.metrics = {}

    # -------------------------
    # Simulation
    # -------------------------
    def run(self, force=False):
        if self.result_file.is_file() and not force:
            print(f"Skipping simulation: {self.result_file}")
            return

        cmd = [
            str(self.exec_path),
            f"-override={self.override_string}",
            f"-s={self.solver}",
            f"-tolerance={self.tolerance}",
            "-startTime=0",
            "-stopTime=32",
            "-outputFormat=csv",
            "-noEventEmit",
            r"-variableFilter=(left_wheel_kin_telemetry|right_wheel_kin_telemetry)\..*",
            "-lv=LOG_STATS",
            f"-r={self.result_file}",
        ]

        subprocess.run(cmd, check=True, cwd=self.exec_path.parent)

    # -------------------------
    # Data Loading
    # -------------------------
    def load_results(self):
        self.data = (
            pd.read_csv(self.result_file)
            .drop_duplicates(subset="time")
            .sort_values("time")
            .reset_index(drop=True)
        )

    # -------------------------
    # Splicing
    # -------------------------
    def splice_windows(self, windows):
        segments = []
        offset = 0.0

        for a, b in windows:
            df = self.data[self.data["time"].between(a, b)].copy()
            df["time"] -= a
            df["time"] += offset
            segments.append(df)
            offset += (b - a)

        return pd.concat(segments, ignore_index=True)

    def build_spliced_tests(self, tests_dict):
        self.spliced = {
            name: self.splice_windows(windows)
            for name, windows in tests_dict.items()
        }

    def get_signal(self, side, name):
        return f"{side}_wheel_kin_telemetry.{name}"
    
    # -------------------------
    # Metrics (Axle-Level)
    # -------------------------
    def compute_bump_metrics(self):
        df = self.spliced["bump"]
        jounce = df["left_wheel_kin_telemetry.jounce"]
        camber = df["left_wheel_kin_telemetry.gamma"]

        import matplotlib.pyplot as plt
        plt.plot(jounce, camber)
        plt.savefig("./test.png")
        slope = np.polyfit(jounce, camber, 1)[0]

        self.metrics["bump"] = {
            "camber_gain": slope
        }

    def compute_roll_metrics(self):
        df = self.spliced["roll"]
        roll = df["left_wheel_kin_telemetry.roll"]
        camber = df["left_wheel_kin_telemetry.gamma"]

        slope = np.polyfit(roll, camber, 1)[0]

        self.metrics["roll"] = {
            "camber_gain_per_deg": slope
        }

    def compute_long_jack_metrics(self):
        df = self.spliced["long_jack"]

        time = df["time"]
        jounce = df["left_wheel_kin_telemetry.jounce"]

        Fx_per_wheel = df["left_wheel_kin_telemetry.Fx"]
        jack_axle = df["left_wheel_kin_telemetry.jacking"]

        Fx_total = 2.0 * Fx_per_wheel

        target_times = np.array([1, 3, 5, 7, 9])

        results = {
            "time": [],
            "jounce": [],
            "Fx_total": [],
            "jacking_total": [],
            "jacking_delta": [],
            "jacking_per_Fx": []
        }

        for t in target_times:

            # Peak index
            idx_peak = (np.abs(time - t)).idxmin()

            # Corresponding baseline time (previous even second)
            t_baseline = t - 1
            idx_base = (np.abs(time - t_baseline)).idxmin()

            Fx_val = Fx_total.iloc[idx_peak]
            jack_val = jack_axle.iloc[idx_peak]
            jack_base = jack_axle.iloc[idx_base]

            jack_delta = jack_val - jack_base

            ratio = (
                jack_delta / Fx_val
                if abs(Fx_val) > 50.0
                else np.nan
            )

            results["time"].append(time.iloc[idx_peak])
            results["jounce"].append(jounce.iloc[idx_peak])
            results["Fx_total"].append(Fx_val)
            results["jacking_total"].append(jack_val)
            results["jacking_delta"].append(jack_delta)
            results["jacking_per_Fx"].append(ratio)

        self.metrics["long_jack"] = results

    def compute_lat_jack_metrics(self):
        df = self.spliced["lat_jack"]

        time = df["time"]
        roll = df["left_wheel_kin_telemetry.roll"]

        Fy_per_wheel = df["left_wheel_kin_telemetry.Fy"]
        jack_axle = df["left_wheel_kin_telemetry.jacking"]

        Fy_total = 2.0 * Fy_per_wheel

        target_times = np.array([1, 3, 5, 7, 9])

        results = {
            "time": [],
            "roll": [],
            "Fy_total": [],
            "jacking_total": [],
            "jacking_delta": [],
            "jacking_per_Fy": []
        }

        for t in target_times:

            idx_peak = (np.abs(time - t)).idxmin()

            t_baseline = t - 1
            idx_base = (np.abs(time - t_baseline)).idxmin()

            Fy_val = Fy_total.iloc[idx_peak]
            jack_val = jack_axle.iloc[idx_peak]
            jack_base = jack_axle.iloc[idx_base]

            jack_delta = jack_val - jack_base

            ratio = (
                jack_delta / Fy_val
                if abs(Fy_val) > 50.0
                else np.nan
            )

            results["time"].append(time.iloc[idx_peak])
            results["roll"].append(roll.iloc[idx_peak])
            results["Fy_total"].append(Fy_val)
            results["jacking_total"].append(jack_val)
            results["jacking_delta"].append(jack_delta)
            results["jacking_per_Fy"].append(ratio)

        self.metrics["lat_jack"] = results
    
    def compute_motion_ratios(self):
        for side in ["left", "right"]:

            wheel = self.spliced["bump"][f"{side}_wheel_kin_telemetry.jounce"].to_numpy()
            spring = self.spliced["bump"][f"{side}_wheel_kin_telemetry.spring_length"].to_numpy()

            # Sort by wheel (prescribed bump DOF)
            sort_idx = np.argsort(wheel)
            wheel_sorted = wheel[sort_idx]
            spring_sorted = spring[sort_idx]

            # Remove duplicate wheel values
            wheel_unique, idx = np.unique(wheel_sorted, return_index=True)
            spring_unique = spring_sorted[idx]

            # Fit cubic: spring = f(wheel)
            coeffs = np.polyfit(wheel_unique, spring_unique, 3)
            poly = np.poly1d(coeffs)
            dpoly = np.polyder(poly)  # ds/dw

            # Evaluate derivative at original wheel points
            ds_dw = dpoly(wheel)

            # Motion ratio = dw/ds
            eps = 1e-12
            mr = 1.0 / np.where(np.abs(ds_dw) < eps, np.nan, ds_dw)

            # Optional: positive convention
            mr = np.abs(mr)

            self.spliced["bump"][f"{side}_wheel_kin_telemetry.spring_mr"] = mr


        # ======================================================
        # STABAR MOTION RATIO (AXLE-LEVEL)
        # ======================================================

        import matplotlib.pyplot as plt

        wheel = self.spliced["roll"]["left_wheel_kin_telemetry.roll"].to_numpy()
        bar = self.spliced["roll"]["left_wheel_kin_telemetry.stabar_angle"].to_numpy()

        plt.plot(wheel, bar)
        plt.savefig("./test.png")

        # Sort by wheel
        sort_idx = np.argsort(wheel)
        wheel_sorted = wheel[sort_idx]
        bar_sorted = bar[sort_idx]

        # Remove duplicates
        wheel_unique, idx = np.unique(wheel_sorted, return_index=True)
        bar_unique = bar_sorted[idx]

        # Fit cubic: bar = f(wheel)
        coeffs = np.polyfit(wheel_unique, bar_unique, 3)
        poly = np.poly1d(coeffs)
        dpoly = np.polyder(poly)  # d(bar)/dwheel
    
        # Evaluate at original wheel points
        dbar_dw = dpoly(wheel)

        # If you want wheel/bar ratio:
        # MR_bar = dwheel/dbar
        eps = 1e-12
        mr_bar = 1.0 / np.where(np.abs(dbar_dw) < eps, np.nan, dbar_dw)

        mr_bar = np.abs(mr_bar)

        self.spliced["roll"]["axle_kin_telemetry.stabar_mr"] = mr_bar

    def compute_metrics(self):
        self.compute_bump_metrics()
        self.compute_roll_metrics()
        self.compute_long_jack_metrics()
        self.compute_lat_jack_metrics()

        self.compute_motion_ratios()