# simulate.py

import pandas as pd
from fmpy import extract, read_model_description
from fmpy.fmi2 import FMU2Slave


def simulate(vehicle, input_function, sim_config):

    fmu_path = vehicle["fmu"]

    unzipdir = extract(fmu_path)

    md = read_model_description(unzipdir)

    fmu = FMU2Slave(
        guid=md.guid,
        unzipDirectory=unzipdir,
        modelIdentifier=md.coSimulation.modelIdentifier,
        instanceName="instance"
    )

    # Build variable reference lookup
    vr_map = {
        var.name: var.valueReference
        for var in md.modelVariables
    }

    input_vrs = {
        k: vr_map[v]
        for k, v in vehicle["inputs"].items()
    }

    output_vrs = {
        name: vr_map[name]
        for name in vehicle["outputs"]
    }

    fmu.instantiate()
    fmu.setupExperiment(startTime=0)
    fmu.enterInitializationMode()
    fmu.exitInitializationMode()

    dt = sim_config["dt"]
    stop_time = sim_config["stop_time"]

    t = 0
    data = []

    while t <= stop_time:

        state = {}

        for name, vr in output_vrs.items():
            state[name] = fmu.getReal([vr])[0]

        inputs = input_function(t, state, dt)

        for name, value in inputs.items():
            fmu.setReal([input_vrs[name]], [value])

        row = {"time": t}
        row.update(state)
        data.append(row)

        fmu.doStep(t, dt)

        t += dt

    fmu.terminate()
    fmu.freeInstance()

    return pd.DataFrame(data)