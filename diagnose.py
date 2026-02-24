import matplotlib.pyplot as plt
import matplotlib
from fmpy import simulate_fmu
import time

import numpy as np

start_time = time.time()

input_arr = np.array([(0.0,12,0.0),
 (1.0,12,0.0),
 (2.0,12,0.0),
 (6.0,12,0.0),
 (10.0,12,-0.75*0.0254),
 (12.0,12,-0.75*0.0254)],
                      dtype=[('time', np.float64),
                             ('speed_cmd', np.float64),
                             ('rack_travel', np.float64),
    ]
)

output_sigs = [
    'time',
    'telem.input_sigs.handwheel_angle',
    'telem.input_sigs.torque_command',
    'telem.aero_sigs.drag',
    'telem.aero_sigs.side_force',
    'telem.aero_sigs.lift',
    'telem.aero_sigs.roll_moment',
    'telem.aero_sigs.pitch_moment',
    'telem.aero_sigs.yaw_moment',
    'telem.kin_sigs.roll',
    'telem.kin_sigs.pitch',
    'telem.kin_sigs.yaw',
    'telem.kin_sigs.p',
    'telem.kin_sigs.q',
    'telem.kin_sigs.r',
    'telem.kin_sigs.vx',
    'telem.kin_sigs.vy',
    'telem.kin_sigs.vz',
    'telem.kin_sigs.speed',
    'telem.kin_sigs.beta',
    'telem.kin_sigs.X',
    'telem.kin_sigs.Y',
    'telem.kin_sigs.Z',
    'telem.dyn_sigs.ax',
    'telem.dyn_sigs.ay',
    'telem.dyn_sigs.az',
    'telem.dyn_sigs.Fx',
    'telem.dyn_sigs.Fy',
    'telem.dyn_sigs.Fz',
    'telem.dyn_sigs.Mx',
    'telem.dyn_sigs.My',
    'telem.dyn_sigs.Mz',
    'telem.powertrain_sigs.wheel_torque[1]',
    'telem.powertrain_sigs.wheel_torque[2]',
    'telem.powertrain_sigs.wheel_torque[3]',
    'telem.powertrain_sigs.wheel_torque[4]',
    'telem.powertrain_sigs.wheel_power[1]',
    'telem.powertrain_sigs.wheel_power[2]',
    'telem.powertrain_sigs.wheel_power[3]',
    'telem.powertrain_sigs.wheel_power[4]',
    'telem.sus_sigs[1].jounce',
    'telem.sus_sigs[1].frame_height',
    'telem.sus_sigs[1].shock_deflection',
    'telem.sus_sigs[1].shock_velocity',
    'telem.sus_sigs[1].stabar_torque',
    'telem.sus_sigs[2].jounce',
    'telem.sus_sigs[2].frame_height',
    'telem.sus_sigs[2].shock_deflection',
    'telem.sus_sigs[2].shock_velocity',
    'telem.sus_sigs[2].stabar_torque',
    'telem.sus_sigs[3].jounce',
    'telem.sus_sigs[3].frame_height',
    'telem.sus_sigs[3].shock_deflection',
    'telem.sus_sigs[3].shock_velocity',
    'telem.sus_sigs[3].stabar_torque',
    'telem.sus_sigs[4].jounce',
    'telem.sus_sigs[4].frame_height',
    'telem.sus_sigs[4].shock_deflection',
    'telem.sus_sigs[4].shock_velocity',
    'telem.sus_sigs[4].stabar_torque',
    'telem.wheel_sigs[1].Fx',
    'telem.wheel_sigs[1].Fy',
    'telem.wheel_sigs[1].Mx',
    'telem.wheel_sigs[1].My',
    'telem.wheel_sigs[1].Mz',
    'telem.wheel_sigs[1].Fz',
    'telem.wheel_sigs[1].alpha',
    'telem.wheel_sigs[1].kappa',
    'telem.wheel_sigs[1].gamma',
    'telem.wheel_sigs[1].omega',
    'telem.wheel_sigs[1].delta',
    'telem.wheel_sigs[2].Fx',
    'telem.wheel_sigs[2].Fy',
    'telem.wheel_sigs[2].Mx',
    'telem.wheel_sigs[2].My',
    'telem.wheel_sigs[2].Mz',
    'telem.wheel_sigs[2].Fz',
    'telem.wheel_sigs[2].alpha',
    'telem.wheel_sigs[2].kappa',
    'telem.wheel_sigs[2].gamma',
    'telem.wheel_sigs[2].omega',
    'telem.wheel_sigs[2].delta',
    'telem.wheel_sigs[3].Fx',
    'telem.wheel_sigs[3].Fy',
    'telem.wheel_sigs[3].Mx',
    'telem.wheel_sigs[3].My',
    'telem.wheel_sigs[3].Mz',
    'telem.wheel_sigs[3].Fz',
    'telem.wheel_sigs[3].alpha',
    'telem.wheel_sigs[3].kappa',
    'telem.wheel_sigs[3].gamma',
    'telem.wheel_sigs[3].omega',
    'telem.wheel_sigs[3].delta',
    'telem.wheel_sigs[4].Fx',
    'telem.wheel_sigs[4].Fy',
    'telem.wheel_sigs[4].Mx',
    'telem.wheel_sigs[4].My',
    'telem.wheel_sigs[4].Mz',
    'telem.wheel_sigs[4].Fz',
    'telem.wheel_sigs[4].alpha',
    'telem.wheel_sigs[4].kappa',
    'telem.wheel_sigs[4].gamma',
    'telem.wheel_sigs[4].omega',
    'telem.wheel_sigs[4].delta',
]

res1 = simulate_fmu(
    './Build/fmu/OrionChassisCV.fmu',
    start_time=0,
    stop_time=20,
    output_interval=None,
    solver='CVode',
    input = input_arr,
    start_values={'chassisBase.sprung_mass_setup.r_cm[3]': 0.21533036},
    output=output_sigs,
    relative_tolerance=1e-5,
    fmi_type='ModelExchange',
)

res2 = simulate_fmu(
    './Build/fmu/OrionChassisCV.fmu',
    start_time=0,
    stop_time=20,
    output_interval=None,
    solver='CVode',
    input = input_arr,
    start_values={'chassisBase.sprung_mass_setup.r_cm[3]': 0.19},
    output=output_sigs,
    relative_tolerance=1e-5,
    fmi_type='ModelExchange',
)

# Save results (compressed, lossless, fast)
np.savez_compressed(
    "./Build/results/cg_sweep_results.npz",
    res1=res1,
    res2=res2
)

print("Saved results to ./Build/results/cg_sweep_results.npz")

end_time = time.time()

print(end_time - start_time)

# matplotlib.use("Agg")

# fig = plt.figure()
# ax = fig.gca()
# ax.plot(res1['time'], res1['telem.dyn_sigs.ax'], label='r_cm = 0.21533036 m')
# ax.plot(res2['time'], res2['telem.dyn_sigs.ax'], label='r_cm = 0.19 m')
# ax.legend()
# ax.grid()
# ax.set_xlabel('Time (s)')
# ax.set_ylabel(r'Longitudinal Acceleration $\left(m/s^2\right)$')
# fig.savefig("./compare_ax.png", dpi=300)

# fig = plt.figure()
# ax = fig.gca()
# ax.plot(res1['telem.kin_sigs.X'], res1['telem.kin_sigs.Y'], label='r_cm = 0.21533036 m')
# ax.plot(res2['telem.kin_sigs.X'], res2['telem.kin_sigs.Y'], label='r_cm = 0.19 m')
# ax.legend()
# ax.grid()
# ax.set_xlabel('X (m)')
# ax.set_ylabel(r'Y (m)')
# fig.savefig("./compare_kin.png", dpi=300)

# fig = plt.figure()
# ax = fig.gca()
# ax.plot(res1['time'], res1['telem.dyn_sigs.ay'], label='r_cm = 0.21533036 m')
# ax.plot(res2['time'], res2['telem.dyn_sigs.ay'], label='r_cm = 0.19 m')
# ax.legend()
# ax.grid()
# ax.set_xlabel('Time (s)')
# ax.set_ylabel(r'Lateral Acceleration $\left(m/s^2\right)$')
# fig.savefig("./compare_ay.png", dpi=300)

# fig = plt.figure()
# ax = fig.gca()
# ax.plot(res1['time'], res1['telem.kin_sigs.vx'], label='r_cm = 0.21533036 m')
# ax.plot(res2['time'], res2['telem.kin_sigs.vx'], label='r_cm = 0.19 m')
# ax.legend()
# ax.grid()
# ax.set_xlabel('Time (s)')
# ax.set_ylabel(r'Velocity in X Direction $\left(m/s\right)$')
# fig.savefig("./compare_vx.png", dpi=300)
