import DefaultTheme from 'vitepress/theme'
import { h } from 'vue'
import './style.css'
import BangBangPlot from './components/BangBangPlot.vue'
import PIDPlot from './components/PIDPlot.vue'
import ScrollIndicator from './components/ScrollIndicator.vue'

export default {
    extends: DefaultTheme,
    Layout() {
        return h(DefaultTheme.Layout, null, {
            'layout-bottom': () => h(ScrollIndicator),
        })
    },
    enhanceApp({app}: { app: import('vue').App }) {
        app.component('BangBangPlot', BangBangPlot)
        app.component('PIDPlot', PIDPlot)
    },
}
