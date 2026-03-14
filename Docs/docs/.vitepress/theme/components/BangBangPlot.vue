<script setup>
import { ref, onMounted, onUnmounted } from 'vue'

const canvasRef = ref(null)
const isRunning = ref(false)
let chart = null
let animTimer = null
let frame = 0
let responseData = []

const COLORS = {
  brand: '#4ea1ff',
  brandFill: 'rgba(78, 161, 255, 0.08)',
  muted: '#7f8796',
  text: '#c9cdd4',
  grid: '#242a38',
}

function simulate() {
  const dt = 0.04, T = 28, omega_n = 1.0, zeta = 0.05
  const N = Math.floor(T / dt)
  const r = 1.0
  let x = 0, v = 0
  const times = [], positions = []

  for (let i = 0; i < N; i++) {
    const e = r - x
    const u = e > 0 ? 6 : -6
    const a = u - 2 * zeta * omega_n * v - omega_n ** 2 * x
    v += a * dt
    x += v * dt
    times.push(+(i * dt).toFixed(2))
    positions.push(+x.toFixed(4))
  }
  return { times, positions }
}

function play() {
  if (frame >= responseData.length) resetAnim()
  isRunning.value = true
  animTimer = setInterval(tick, 20)
}

function pause() {
  clearInterval(animTimer)
  isRunning.value = false
}

function resetAnim() {
  pause()
  frame = 0
  chart.data.datasets[1].data = []
  chart.update('none')
}

function tick() {
  if (frame >= responseData.length) { pause(); return }
  const end = Math.min(frame + 5, responseData.length)
  for (let i = frame; i < end; i++) {
    chart.data.datasets[1].data.push(responseData[i])
  }
  frame = end
  chart.update('none')
}

onMounted(async () => {
  const { Chart, registerables } = await import('chart.js')
  Chart.register(...registerables)

  const { times, positions } = simulate()
  responseData = positions

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
          data: [],
          borderColor: COLORS.brand,
          backgroundColor: COLORS.brandFill,
          fill: true,
          borderWidth: 2,
          pointRadius: 0,
          tension: 0,
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
          min: -0.5,
          max: 2.0,
        },
      },
    },
  })
})

onUnmounted(() => {
  clearInterval(animTimer)
  chart?.destroy()
})
</script>

<template>
  <div class="plot-container">
    <div class="plot-controls">
      <button v-if="!isRunning" @click="play" class="plot-btn">&#9654; Play</button>
      <button v-else @click="pause" class="plot-btn">&#9646;&#9646; Pause</button>
      <button @click="resetAnim" class="plot-btn plot-btn-muted">&#8635; Reset</button>
    </div>
    <div class="chart-area">
      <canvas ref="canvasRef" />
    </div>
  </div>
</template>

<style scoped>
.plot-container { margin: 1.5rem 0; }
.plot-controls {
  display: flex;
  gap: 0.5rem;
  margin-bottom: 0.75rem;
}
.plot-btn {
  padding: 0.3rem 0.9rem;
  border-radius: 4px;
  border: 1px solid var(--vp-c-brand-1);
  background: transparent;
  color: var(--vp-c-brand-1);
  cursor: pointer;
  font-size: 0.85rem;
  font-family: inherit;
  transition: background 0.15s;
}
.plot-btn:hover { background: var(--vp-c-brand-soft); }
.plot-btn-muted {
  border-color: var(--vp-c-text-3);
  color: var(--vp-c-text-3);
}
.plot-btn-muted:hover { background: var(--vp-c-bg-soft); }
.chart-area {
  position: relative;
  height: 280px;
}
@media (max-width: 640px) {
  .chart-area { height: 200px; }
}
</style>
