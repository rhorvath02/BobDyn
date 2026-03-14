---
layout: doc
title: Vehicle Performance Metrics
---

# Vehicle Performance Metrics

This page provides conceptual definitions of commonly used vehicle performance metrics. Each metric
is described in terms of the physical behavior it represents and why it is relevant to vehicle
design and analysis. No assumptions are made regarding relative importance; the relevance of each
metric depends on the intended application of the vehicle.

## Steady-State Handling

<p class="section-intro">
Metrics describing equilibrium behavior once transient effects have decayed.
</p>

### Maximum Lateral Acceleration (Max&nbsp;Ay)

**Description.** The maximum lateral acceleration the vehicle can sustain in a steady-state corner
before tire saturation or loss of stability.

**Physical interpretation.** This metric reflects the combined lateral force-generating capability
of the tires, suspension geometry, load transfer characteristics, and overall vehicle mass
distribution under quasi-static conditions.

**Why it matters.** Maximum lateral acceleration is commonly used as a proxy for absolute
steady-state cornering capability and provides a compact measure of how effectively the vehicle can
generate lateral force.

In simplified form,

$$
a_y = \frac{v^2}{R}
$$

where the achievable value of $a_y$ is limited by the available tire lateral force.

### Linear Understeer Gradient

**Description.** The rate at which required steering input increases with lateral acceleration in
the linear tire operating region.

**Physical interpretation.** The linear understeer gradient characterizes the balance between front
and rear cornering stiffness and is influenced by suspension geometry, roll stiffness distribution,
tire properties, and compliance.

**Why it matters.** This metric defines the fundamental handling balance perceived by the driver
during moderate cornering and strongly influences predictability and steering effort.

$$
K = \frac{\partial \delta}{\partial a_y}
$$

where $\delta$ is steering angle and $a_y$ is lateral acceleration.

### Limit Understeer Behavior

**Description.** The effective understeer or oversteer tendency as the vehicle approaches tire
saturation.

**Physical interpretation.** This behavior arises from nonlinear tire force characteristics, load
transfer effects, and compliance within the suspension and steering systems.

**Why it matters.** Limit understeer behavior governs how the vehicle behaves near the edge of grip,
influencing controllability and driver confidence during aggressive maneuvers.

### Linear Sideslip Gradient

**Description.** The relationship between vehicle sideslip angle and lateral acceleration in the
linear operating region.

**Physical interpretation.** This metric reflects the yaw stiffness of the vehicle and is influenced
by mass distribution, yaw inertia, and tire slip angle characteristics.

**Why it matters.** Linear sideslip behavior affects how stable or "planted" the vehicle feels
during normal cornering.

$$
\beta = f(a_y)
$$

### Limit Sideslip Behavior

**Description.** Vehicle sideslip response as the tires approach or exceed their lateral force
limits.

**Physical interpretation.** Governed by yaw moment balance, tire force saturation and fall-off, and
inertial coupling.

**Why it matters.** Limit sideslip behavior determines whether the vehicle remains controllable at
the edge of grip or transitions abruptly into loss of control.

## Transient Handling

<p class="section-intro">
Metrics describing time-domain response to steering inputs.
</p>

### Yaw Rate Gain

**Description.** The ratio between vehicle yaw rate and steering input under steady or low-frequency
conditions.

$$
G_r = \frac{r}{\delta}
$$

**Why it matters.** Yaw rate gain defines how strongly the vehicle responds rotationally to driver
input and forms the basis for interpreting many other dynamic metrics.

### Yaw Rate Response Delay

**Description.** The time or phase delay between steering input and yaw rate response.

$$
\phi_r(\omega) = \angle \frac{R(\omega)}{\Delta(\omega)}
$$

**Why it matters.** Yaw delay strongly affects perceived responsiveness and driver confidence during
rapid maneuvers.

### Lateral Acceleration Response Delay

**Description.** The time or phase delay between steering input and lateral acceleration response.

**Why it matters.** This metric influences how quickly the vehicle "takes a set" and how connected
it feels during turn-in.

### Yaw Rate Amplification

**Description.** The ratio of peak yaw rate response to steady-state yaw rate response following a
steering input.

$$
A_r = \frac{r_{peak}}{r_{ss}}
$$

**Why it matters.** Yaw amplification indicates whether the vehicle exhibits aggressive transient
overshoot or a controlled, well-damped response.

## Stability and Control

### Stability Margin

**Description.** A measure of the available yaw moment or control authority before the onset of
instability.

**Physical interpretation.** Stability margin reflects tire force reserves, load transfer balance,
yaw inertia, and overall system robustness.

**Why it matters.** This metric provides insight into how much corrective authority exists before
loss of control occurs.

## Frequency-Domain Metrics

### Yaw Rate Frequency Response

**Description.** The frequency-dependent magnitude and phase relationship between steering input and
yaw rate response.

$$
G_r(j\omega) = \frac{R(j\omega)}{\Delta(j\omega)}
$$

**Why it matters.** Frequency-domain metrics provide a compact representation of vehicle dynamics
across a wide range of time scales.

### Lateral Acceleration Frequency Response

**Description.** The frequency-dependent relationship between steering input and lateral
acceleration under representative operating conditions.

**Why it matters.** Evaluating frequency response under realistic loading provides insight into
dynamic behavior not captured by purely linear analysis.

<p class="closing-note">
These metrics collectively describe vehicle capability, response, and stability. Their relevance depends on the intended application, operating environment, and design objectives.
</p>
