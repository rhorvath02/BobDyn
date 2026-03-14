---
layout: doc
title: Control Theory
---

# Control Theory

In vehicle modeling, we don't just care about how a vehicle moves. We care about how to make it move the way we want. Control theory is the mathematical framework used to regulate the behavior of dynamic systems to reach a desired state.

## Open-Loop vs. Closed-Loop

The most fundamental distinction in control is whether or not the system "looks" at its own output to make decisions.

### Open-Loop Control

The controller sends a command based on a preset map or timer without checking the actual result.

- **Pros.** Simple, requires no sensors.
- **Cons.** Cannot account for disturbances or changes in the environment.

```python
# Open-loop drone: fixed motor command, no feedback
motor_throttle = 50  # % - set once and never adjusted

# A gust hits and drops the drone - we never know, never react
```

### Closed-Loop (Feedback) Control

The controller measures the actual output $y$ using a sensor and compares it to the desired setpoint $r$ to compute the **error** $e$.

$$e(t) = r(t) - y(t)$$

The control signal is then a function of this error. Every controller discussed below is a closed-loop controller.

```python
# Closed-loop drone: measure, compare, react
setpoint = 10.0                    # desired altitude (m)
altitude = read_barometer()        # actual altitude (m)
error    = setpoint - altitude     # how far off are we?

motor_throttle = some_controller(error)
```

## Bang-Bang Control

The simplest form of feedback. The controller has only two states: **full on** or **full off**.

$$u(t) = \begin{cases} U_{\max} & \text{if } e(t) > 0 \\ -U_{\max} & \text{if } e(t) < 0 \end{cases}$$

If the error is positive, drive the actuator to max. If negative, drive it to min. The result is constant oscillation around the setpoint, called **chatter**.

```python
MOTOR_MAX =  100  # % throttle
MOTOR_MIN = -100

def bang_bang(setpoint, altitude):
    error = setpoint - altitude
    return MOTOR_MAX if error > 0 else MOTOR_MIN

# The drone will blast to full throttle, overshoot 10 m,
# cut to zero, fall back below 10 m, repeat forever.
```

<ClientOnly>
  <BangBangPlot />
</ClientOnly>

Notice that the system never settles. Bang-bang control is useful when simplicity matters more than precision (thermostats, relays), but it's unsuitable for smooth vehicle control.

## PID Control

The workhorse of engineering. PID computes a smooth control input $u(t)$ using three terms that each address a different aspect of the error.

$$u(t) = K_p\, e(t) + K_i \int_0^t e(\tau)\, d\tau + K_d\, \frac{de(t)}{dt}$$

| Term | Name | Role |
| :--- | :--- | :--- |
| $K_p$ | Proportional | Reacts to the **current** error. Larger $K_p$ = faster response, but too high causes oscillation. |
| $K_i$ | Integral | Accumulates **past** error. Eliminates steady-state offset, but can cause windup and overshoot. |
| $K_d$ | Derivative | Reacts to the **rate of change** of error. Damps oscillation and prevents overshoot. |

```python
class PID:
    def __init__(self, Kp, Ki, Kd, dt):
        self.Kp, self.Ki, self.Kd, self.dt = Kp, Ki, Kd, dt
        self.integral  = 0.0
        self.prev_error = 0.0

    def update(self, setpoint, measurement):
        error            = setpoint - measurement
        self.integral   += error * self.dt
        derivative       = (error - self.prev_error) / self.dt
        self.prev_error  = error
        return self.Kp * error + self.Ki * self.integral + self.Kd * derivative

# Drone altitude hold
pid      = PID(Kp=8, Ki=2, Kd=4, dt=0.02)
throttle = pid.update(setpoint=10.0, measurement=read_barometer())
```

<ClientOnly>
  <PIDPlot />
</ClientOnly>

### Tuning intuition

- **$K_i = 0$:** The system will settle near but not exactly at the setpoint (steady-state error).
- **$K_d = 0$:** The system reaches the setpoint but overshoots and rings.
- **All three tuned:** Fast rise, minimal overshoot, zero steady-state error.

## Feedforward Control

PID reacts to error after it has already occurred. **Feedforward** predicts the required input based on known physics and applies it proactively, before any error builds up.

$$u(t) = u_{\text{ff}}(t) + u_{\text{fb}}(t)$$

Where $u_{\text{ff}}$ is computed from a model of the plant (e.g., gravity compensation for a drone) and $u_{\text{fb}}$ is the PID feedback term.

**The benefit.** The feedback loop only handles disturbances and model error. The feedforward handles the predictable, steady-state load. This reduces the demands on PID gains and allows tighter tuning.

```python
MASS    = 1.2   # kg
GRAVITY = 9.81  # m/s²

def feedforward(mass, gravity):
    # Thrust to exactly cancel gravity - no error needed to compute this
    return mass * gravity

def total_control(setpoint, altitude):
    u_ff = feedforward(MASS, GRAVITY)      # physics-based prediction
    u_fb = pid.update(setpoint, altitude)  # PID handles the rest
    return u_ff + u_fb
```

In vehicle dynamics, feedforward is used for steering angle prediction, throttle mapping, and active suspension load estimation.
