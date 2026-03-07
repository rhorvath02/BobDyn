import pathlib
import yaml

from axle import AxleKncReport


class VehicleKncReport:
    def __init__(self,
             name: str,
             front_exec,
             rear_exec,
             jounce_amp,
             rack_pos,
             force_amp,
             front_solver,
             front_tol,
             front_params,
             rear_solver,
             rear_tol,
             rear_params,
             geometry=None):

        self.name = name
        self.geometry = geometry

        self.front = AxleKncReport(
            exec_path=front_exec,
            vehicle_name=name,
            axle_name="front",
            jounce_amplitude=jounce_amp,
            rack_position=rack_pos,
            force_amplitude=force_amp,
            solver=front_solver,
            tolerance=front_tol,
            extra_params=front_params
        )

        self.rear = AxleKncReport(
            exec_path=rear_exec,
            vehicle_name=name,
            axle_name="rear",
            jounce_amplitude=jounce_amp,
            rack_position=rack_pos,
            force_amplitude=force_amp,
            solver=rear_solver,
            tolerance=rear_tol,
            extra_params=rear_params
        )
        
        self.metrics = {}
        self.tests = {}
        self.output_dir = None
        self.pdf_path = None

    # -------------------------
    # Orchestration
    # -------------------------
    def run(self, force=False):
        self.front.run(force)
        self.rear.run(force)

    def load_results(self):
        self.front.load_results()
        self.rear.load_results()

    def build_spliced_tests(self, tests):
        self.front.build_spliced_tests(tests)
        self.rear.build_spliced_tests(tests)

    def compute_metrics(self):
        self.front.compute_metrics()
        self.rear.compute_metrics()

        self.metrics["front"] = self.front.metrics
        self.metrics["rear"] = self.rear.metrics
    
    @classmethod
    def from_yaml(cls, config_path):

        config_path = pathlib.Path(config_path).resolve()

        with open(config_path, "r") as f:
            cfg = yaml.safe_load(f)

        repo_root = config_path.parents[2]

        vehicles = []  # MUST be inside the function

        case = cfg["case"]

        for v_cfg in cfg["vehicles"]:

            front_exec = repo_root / v_cfg["front"]["executable"]
            rear_exec  = repo_root / v_cfg["rear"]["executable"]

            vehicle = cls(
                name=v_cfg["name"],
                front_exec=front_exec,
                rear_exec=rear_exec,
                jounce_amp=case["jounce_amplitude"],
                rack_pos=case["rack_position"],
                force_amp=case["force_amplitude"],
                front_solver=v_cfg["front"].get("solver", "dassl"),
                front_tol=v_cfg["front"].get("tolerance", 1e-4),
                front_params=v_cfg["front"].get("params", ""),
                rear_solver=v_cfg["rear"].get("solver", "dassl"),
                rear_tol=v_cfg["rear"].get("tolerance", 1e-4),
                rear_params=v_cfg["rear"].get("params", ""),
                geometry=v_cfg.get("geometry", None)
            )

            vehicles.append(vehicle)

        return vehicles, cfg