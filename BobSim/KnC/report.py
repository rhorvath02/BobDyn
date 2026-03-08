# report.py

from matplotlib.backends.backend_pdf import PdfPages
from matplotlib.lines import Line2D
import matplotlib.pyplot as plt
import numpy as np
import datetime


# ----------------------------------------------------------
# Global Plot Styling (clean + consistent)
# ----------------------------------------------------------
plt.rcParams.update({
    "font.size": 11,
    "axes.titlesize": 12,
    "axes.labelsize": 11,
    "legend.fontsize": 11
})


def generate_pdf(vehicles, cfg, pdf_path):

    plots_cfg = cfg["plots"]

    with PdfPages(pdf_path) as pdf:

        # ======================================================
        # COVER PAGE
        # ======================================================

        fig = plt.figure(figsize=(11, 8.5))
        fig.patch.set_facecolor("white")

        now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M")
        vehicle_names = ", ".join([v.name for v in vehicles])
        case = cfg["case"]

        plt.axis("off")

        plt.text(0.5, 0.82, "BOBSIM",
                 ha="center", fontsize=28, fontweight="bold")

        plt.text(0.5, 0.75,
                 "Kinematics & Compliance Report",
                 ha="center", fontsize=16)

        cover_text = f"""
Vehicles:
{vehicle_names}

Case Parameters:
Jounce Amplitude: {case['jounce_amplitude']} m
Rack Position: {case['rack_position']} m
Force Amplitude: {case['force_amplitude']} N

Generated:
{now}
"""

        plt.text(0.1, 0.65, cover_text,
                 fontsize=12, verticalalignment="top")

        pdf.savefig(fig)
        plt.close(fig)

        # ======================================================
        # HELPER FUNCTION
        # ======================================================

        def get_xy(axle, p_cfg, side=None):

            x_cfg = p_cfg["x"]
            y_cfg = p_cfg["y"]

            x_mult = x_cfg.get("multiplier", 1.0)
            y_mult = y_cfg.get("multiplier", 1.0)

            if side is not None:
                x_mult *= x_cfg.get("side_multiplier", {}).get(side, 1.0)
                y_mult *= y_cfg.get("side_multiplier", {}).get(side, 1.0)

            df = axle.spliced[p_cfg["test"]]

            if p_cfg["type"] == "signal":

                if x_cfg.get("level", "wheel") == "wheel":
                    x = df[axle.get_signal(side, x_cfg["signal"])]
                else:
                    x = df[f"axle_kin_telemetry.{x_cfg['signal']}"]

                if y_cfg.get("level", "wheel") == "wheel":
                    y = df[axle.get_signal(side, y_cfg["signal"])]
                else:
                    y = df[f"axle_kin_telemetry.{y_cfg['signal']}"]

            elif p_cfg["type"] == "metric":

                df_metric = axle.metrics[p_cfg["test"]]
                x = np.array(df_metric[x_cfg["metric"]])
                y = np.array(df_metric[y_cfg["metric"]])

            else:
                raise ValueError(f"Unknown plot type: {p_cfg['type']}")

            x = x * x_cfg["scale"] * x_mult
            y = y * y_cfg["scale"] * y_mult

            return x, y

        # ======================================================
        # PLOT PAGES
        # ======================================================

        for plot_name, p_cfg in plots_cfg.items():

            layout = p_cfg.get("layout", "single")

            dash_style = (0, (6, 4))  # consistent dash style

            # ==================================================
            # QUAD LAYOUT
            # ==================================================

            if layout == "quad":

                fig, axes = plt.subplots(2, 2, figsize=(11, 8.5))
                axes = axes.flatten()

                vehicle_handles = []

                positions = [
                    ("front", "left"),
                    ("front", "right"),
                    ("rear", "left"),
                    ("rear", "right")
                ]

                for ax, (axle_name, side) in zip(axes, positions):

                    for i, vehicle in enumerate(vehicles):

                        axle = vehicle.front if axle_name == "front" else vehicle.rear
                        x, y = get_xy(axle, p_cfg, side)

                        line, = ax.plot(x, y, label=vehicle.name)

                        # Store handles once
                        if axle_name == "front" and side == "left":
                            vehicle_handles.append(line)

                    ax.set_title(f"{axle_name.upper()} {side.upper()}")
                    ax.set_xlabel(p_cfg["x"]["label"])
                    ax.set_ylabel(p_cfg["y"]["label"])
                    ax.grid(True)

                fig.legend(
                    handles=vehicle_handles,
                    labels=[v.name for v in vehicles],
                    loc="upper right",
                    bbox_to_anchor=(0.98, 0.98),
                    frameon=True
                )

                fig.suptitle(p_cfg["title"])
                fig.tight_layout(rect=(0, 0, 0.9, 0.95))

                pdf.savefig(fig)
                plt.close(fig)

            # ==================================================
            # AXLE LAYOUT
            # ==================================================

            elif layout == "axle":

                fig, axes = plt.subplots(1, 2, figsize=(11, 5))
                vehicle_handles = []

                for ax, axle_name in zip(axes, ["front", "rear"]):

                    for i, vehicle in enumerate(vehicles):

                        axle = vehicle.front if axle_name == "front" else vehicle.rear
                        x, y = get_xy(axle, p_cfg, side="left")

                        line, = ax.plot(x, y, label=vehicle.name)

                        if axle_name == "front":
                            vehicle_handles.append(line)

                        # ----------------------------------------------
                        # Longitudinal Reference
                        # ----------------------------------------------
                        if p_cfg["test"] == "long_jack":

                            geom = vehicle.geometry
                            h_cg = geom["CG_height_m"]
                            L = geom["wheelbase_m"]
                            ref_value = h_cg / L

                        # ----------------------------------------------
                        # Lateral Reference
                        # ----------------------------------------------
                        elif p_cfg["test"] == "lat_jack":

                            geom = vehicle.geometry
                            h_cg = geom["CG_height_m"]

                            if axle_name == "front":
                                track = geom["front_track_m"]
                            else:
                                track = geom["rear_track_m"]

                            ref_value = h_cg / track

                        else:
                            ref_value = None


                        if ref_value is not None:

                            for sign in [1, -1]:
                                ax.axhline(
                                    sign * ref_value,
                                    linestyle=dash_style,
                                    linewidth=1.8,
                                    color=line.get_color(),
                                    alpha=0.9
                                )

                    ax.set_title(axle_name.upper())
                    ax.set_xlabel(p_cfg["x"]["label"])
                    ax.set_ylabel(p_cfg["y"]["label"])
                    ax.grid(True)

                legend_handles = vehicle_handles.copy()

                if p_cfg["test"] == "long_jack":
                    ref_label = r"Nominal $h_{cg} / L$"

                elif p_cfg["test"] == "lat_jack":
                    ref_label = r"Nominal $h_{cg} / t$"

                else:
                    ref_label = None

                if ref_label is not None:
                    reference_handle = Line2D(
                        [0], [0],
                        color="black",
                        linestyle=dash_style,
                        linewidth=1.8,
                        label=ref_label
                    )
                    legend_handles.append(reference_handle)

                fig.legend(
                    handles=legend_handles,
                    loc="upper right",
                    bbox_to_anchor=(0.98, 0.98),
                    frameon=True
                )

                fig.suptitle(p_cfg["title"])
                fig.tight_layout(rect=(0, 0, 0.9, 0.95))

                pdf.savefig(fig)
                plt.close(fig)

            # ==================================================
            # SINGLE LAYOUT
            # ==================================================

            else:

                fig, ax = plt.subplots(figsize=(8, 5))
                vehicle_handles = []

                for vehicle in vehicles:

                    axle = vehicle.front
                    x, y = get_xy(axle, p_cfg, side="left")

                    line, = ax.plot(x, y, label=vehicle.name)
                    vehicle_handles.append(line)

                ax.set_xlabel(p_cfg["x"]["label"])
                ax.set_ylabel(p_cfg["y"]["label"])
                ax.set_title(p_cfg["title"])
                ax.grid(True)

                fig.legend(
                    handles=vehicle_handles,
                    labels=[v.name for v in vehicles],
                    loc="upper right",
                    bbox_to_anchor=(0.98, 0.98),
                    frameon=True
                )

                fig.tight_layout(rect=(0, 0, 0.9, 0.95))

                pdf.savefig(fig)
                plt.close(fig)
    
    print("PDF generation ran to completion.")