<template>
  <div v-if="isVisible" class="scroll-indicator" aria-hidden="true">
    <span class="label">Scroll</span>
    <span class="arrow">&darr;</span>
  </div>
</template>

<script setup lang="ts">
import { computed, onBeforeUnmount, onMounted, ref, watch } from 'vue'
import { useRoute } from 'vitepress'

const route = useRoute()
const hasScrollablePage = ref(false)
const hasScrolled = ref(false)

const isHome = computed(() => route.path === '/' || route.path === '/index')
const isVisible = computed(() => isHome.value && hasScrollablePage.value && !hasScrolled.value)

const updateScrollable = () => {
  hasScrollablePage.value = document.documentElement.scrollHeight > window.innerHeight + 24
}

const handleScroll = () => {
  hasScrolled.value = window.scrollY > 12
}

watch(
  () => route.path,
  () => {
    hasScrolled.value = false
    requestAnimationFrame(() => {
      updateScrollable()
      handleScroll()
    })
  }
)

onMounted(() => {
  updateScrollable()
  handleScroll()
  window.addEventListener('resize', updateScrollable, { passive: true })
  window.addEventListener('scroll', handleScroll, { passive: true })
})

onBeforeUnmount(() => {
  window.removeEventListener('resize', updateScrollable)
  window.removeEventListener('scroll', handleScroll)
})
</script>

<style scoped>
.scroll-indicator {
  position: fixed;
  left: 50%;
  bottom: 1rem;
  transform: translateX(-50%);
  z-index: 35;
  display: flex;
  align-items: center;
  gap: 0.35rem;
  padding: 0.5rem 1rem;
  border: 1px solid var(--vp-c-border);
  border-radius: 999px;
  background-color: var(--vp-c-bg-elv);
  color: var(--vp-c-text-2);
  pointer-events: none;
  user-select: none;
  animation: floatHint 1.4s ease-in-out infinite;
}

.label {
  font-size: 0.76rem;
  letter-spacing: 0.04em;
  text-transform: uppercase;
}

.arrow {
  font-size: 0.95rem;
  line-height: 1;
}

@keyframes floatHint {
  0%,
  100% {
    transform: translateX(-50%) translateY(0);
    opacity: 0.66;
  }
  50% {
    transform: translateX(-50%) translateY(4px);
    opacity: 1;
  }
}

@media (max-width: 768px) {
  .scroll-indicator {
    bottom: 0.8rem;
  }
}
</style>
