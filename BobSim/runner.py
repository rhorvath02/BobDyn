import yaml
from simulate import simulate
from maneuvers import build_maneuver
from derived import apply_derived_signals
from metrics import compute_metrics
from report import generate_report


def load_yaml(path):
    with open(path, "r") as f:
        return yaml.safe_load(f)


def run(workflow_path):

    workflow = load_yaml(workflow_path)

    vehicle = load_yaml(workflow["vehicle"])

    all_results = []

    for maneuver_cfg in workflow["maneuvers"]:

        input_fn = build_maneuver(maneuver_cfg)

        telemetry = simulate(
            vehicle=vehicle,
            input_function=input_fn,
            sim_config=maneuver_cfg["simulation"]
        )

        telemetry = apply_derived_signals(
            telemetry,
            workflow.get("derived", {})
        )

        metrics = compute_metrics(
            telemetry,
            maneuver_cfg.get("metrics", [])
        )

        all_results.append({
            "maneuver": maneuver_cfg,
            "telemetry": telemetry,
            "metrics": metrics
        })

    generate_report(workflow, all_results)


if __name__ == "__main__":

    import sys
    run(sys.argv[1])