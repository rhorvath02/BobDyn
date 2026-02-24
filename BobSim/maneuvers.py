# maneuvers.py

def build_maneuver(cfg):

    maneuver_type = cfg["type"]

    if maneuver_type == "ramp_steer":
        return build_ramp_steer(cfg)

    raise ValueError(f"Unknown maneuver type: {maneuver_type}")


def build_ramp_steer(cfg):

    target_speed = cfg["speed"]["target"]
    Kp = cfg["speed"]["Kp"]
    Ki = cfg["speed"]["Ki"]

    steer_start = cfg["steering"]["start"]
    steer_rate = cfg["steering"]["rate"]
    steer_max = cfg["steering"]["max"]

    integral = 0

    def input_function(t, state, dt):

        nonlocal integral

        vx = state["telem.kin_sigs.vx"]

        error = target_speed - vx

        integral += error * dt

        torque = Kp*error + Ki*integral

        if t < steer_start:
            steer = 0
        else:
            steer = min(
                steer_rate*(t-steer_start),
                steer_max
            )

        return {
            "torque_command": torque,
            "handwheel_angle": steer
        }

    return input_function