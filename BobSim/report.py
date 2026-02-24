# report.py

import os
import matplotlib.pyplot as plt
from matplotlib.backends.backend_pdf import PdfPages


def generate_report(workflow, results):

    output_dir = workflow["output"]["folder"]

    os.makedirs(output_dir, exist_ok=True)

    pdf_path = os.path.join(
        output_dir,
        workflow["output"]["report"]
    )

    with PdfPages(pdf_path) as pdf:

        for result in results:

            maneuver = result["maneuver"]
            df = result["telemetry"]

            for plot in maneuver.get("plots", []):

                fig, ax = plt.subplots()

                x = df[plot["x"]["signal"]]
                y = df[plot["y"]["signal"]]

                ax.plot(x, y)

                ax.set_title(plot["title"])
                ax.set_xlabel(plot["x"]["label"])
                ax.set_ylabel(plot["y"]["label"])

                pdf.savefig(fig)

                plt.close(fig)