# metrics.py

import numpy as np


def compute_metrics(df, metric_cfg):

    results = {}

    for spec in metric_cfg:

        name = spec["name"]

        if name == "Ay_max":

            signal = spec["signal"]

            results[name] = float(df[signal].max())

        elif name == "understeer_gradient":

            Ay = df["telem.dyn_sigs.ay"]
            steer = df["telem.input_sigs.handwheel_angle"]

            mask = abs(Ay) > 0.5

            K = np.polyfit(Ay[mask], steer[mask], 1)[0]

            results[name] = float(K)

    return results