import DefaultTheme from 'vitepress/theme'
import './style.css'
import BangBangPlot from './components/BangBangPlot.vue'
import PIDPlot from './components/PIDPlot.vue'

export default {
  extends: DefaultTheme,
  enhanceApp({ app }: { app: import('vue').App }) {
    app.component('BangBangPlot', BangBangPlot)
    app.component('PIDPlot', PIDPlot)
  },
}
