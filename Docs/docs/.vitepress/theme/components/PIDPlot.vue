<script setup>
import { ref, onMounted, onUnmounted, watch } from 'vue'

const canvasRef = ref(null)
const Kp = ref(8)
const Ki = ref(2)
const Kd = ref(4)
let chart = null

const COLORS = {
  brand: '#4ea1ff',
  brandFill: 'rgba(78, 161, 255, 0.08)',
  muted: '#7f8796',
  text: '#c9cdd4',
  grid: '#242a38',
}


function simulate(kp, ki, kd) {
  const dt = 0.04, T = 20, omega_n = 1.0, zeta = 0.05
  const N = Math.floor(T / dt)
  const r = 1.0
  let x = 0, v = 0, integral = 0, prevE = r  // prevE = r because x=0 at t=0
  const times = [], positions = []

  for (let i = 0; i < N; i++) {
    const e = r - x
    integral += e * dt
    const derivative = (e - prevE) / dt
    const u = Math.max(-25, Math.min(25, kp * e + ki * integral + kd * derivative))
    prevE = e

    const a = u - 2 * zeta * omega_n * v - omega_n ** 2 * x
    v += a * dt
    x += v * dt
    times.push(+(i * dt).toFixed(2))
    positions.push(+x.toFixed(4))
  }
  return { times, positions }
}

function updateChart() {
  if (!chart) return
  const { positions } = simulate(Kp.value, Ki.value, Kd.value)
  chart.data.datasets[1].data = positions
  chart.update('none')
}

onMounted(async () => {
  const { Chart, registerables } = await import('chart.js')
  Chart.register(...registerables)

  const { times, positions } = simulate(Kp.value, Ki.value, Kd.value)

  chart = new Chart(canvasRef.value, {
    type: 'line',
    data: {
      labels: times,
      datasets: [
        {
          label: 'Setpoint',
          data: times.map(() => 1.0),
          borderColor: COLORS.muted,
          borderDash: [6, 4],
          borderWidth: 1.5,
          pointRadius: 0,
          tension: 0,
        },
        {
          label: 'Response',
          data: positions,
          borderColor: COLORS.brand,
          backgroundColor: COLORS.brandFill,
          fill: true,
          borderWidth: 2,
          pointRadius: 0,
          tension: 0.15,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      animation: false,
      plugins: {
        legend: {
          labels: { color: COLORS.text, boxWidth: 28, boxHeight: 2 },
        },
        tooltip: { enabled: false },
      },
      scales: {
        x: {
          ticks: { color: COLORS.muted, maxTicksLimit: 8 },
          grid: { color: COLORS.grid },
          title: { display: true, text: 'Time (s)', color: COLORS.muted },
        },
        y: {
          ticks: { color: COLORS.muted },
          grid: { color: COLORS.grid },
          title: { display: true, text: 'Output', color: COLORS.muted },
          min: -0.2,
          max: 1.8,
        },
      },
    },
  })
})

onUnmounted(() => {
  chart?.destroy()
})

watch([Kp, Ki, Kd], updateChart)
</script>

<template>
  <div class="plot-container">
    <div class="sliders">
      <label>
        <span class="label-text">K<sub>p</sub> = {{ Kp }}</span>
        <input type="range" v-model.number="Kp" min="0" max="25" step="0.5" />
      </label>
      <label>
        <span class="label-text">K<sub>i</sub> = {{ Ki }}</span>
        <input type="range" v-model.number="Ki" min="0" max="10" step="0.25" />
      </label>
      <label>
        <span class="label-text">K<sub>d</sub> = {{ Kd }}</span>
        <input type="range" v-model.number="Kd" min="0" max="10" step="0.25" />
      </label>
    </div>
    <div class="chart-area">
      <canvas ref="canvasRef" />
    </div>
    <p class="hint">Try setting K<sub>i</sub> = 0 to see steady-state error, or K<sub>d</sub> = 0 to see overshoot.</p>
  </div>
</template>

<style scoped>
.plot-container { margin: 1.5rem 0; }
.sliders {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  margin-bottom: 0.75rem;
}
.sliders label {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}
.label-text {
  font-size: 0.85rem;
  color: var(--vp-c-text-2);
  min-width: 72px;
  font-family: var(--vp-font-family-mono, monospace);
}
input[type="range"] {
  flex: 1;
  accent-color: var(--vp-c-brand-1);
  cursor: pointer;
}
.chart-area {
  position: relative;
  height: 280px;
}
.hint {
  font-size: 0.8rem;
  color: var(--vp-c-text-3);
  margin-top: 0.5rem;
}
@media (max-width: 640px) {
  .chart-area { height: 200px; }
  .label-text { min-width: 60px; }
}
</style>
