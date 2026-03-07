import pathlib

from vehicle import VehicleKncReport
from report import generate_pdf

repo_root = pathlib.Path(__file__).resolve().parents[2]
config_path = repo_root / "BobSim" / "KnC" / "config.yml"

vehicles, cfg = VehicleKncReport.from_yaml(config_path)

for vehicle in vehicles:
    vehicle.run()
    vehicle.load_results()
    vehicle.build_spliced_tests(cfg["tests"])
    vehicle.compute_metrics()

pdf_path = pathlib.Path(cfg["output"]["directory"]) / cfg["output"]["pdf_name"]

generate_pdf(vehicles, cfg, pdf_path)