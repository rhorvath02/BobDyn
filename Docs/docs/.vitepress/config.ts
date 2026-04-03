import {defineConfig} from 'vitepress'

export default defineConfig({
    title: 'BobDyn',
    description: 'First-principles vehicle dynamics analysis for Formula SAE',
    lang: 'en-US',
    base: '/',
    appearance: 'dark',
    sitemap: {
      hostname: 'https://bobdyn.com'
    },

  head: [
    ['link', { rel: 'icon', type: 'image/png', href: '/bob.png' }],
    ['meta', { name: 'robots', content: 'index,follow' }],
    ['meta', { property: 'og:site_name', content: 'BobDyn' }],
    ['meta', { property: 'og:type', content: 'website' }],
    ['meta', { property: 'og:title', content: 'BobDyn' }],
    ['meta', { property: 'og:description', content: 'First-principles vehicle dynamics analysis for Formula SAE' }],
    ['meta', { property: 'og:image', content: 'https://bobdyn.com/bob.png' }],
  ],

  transformHead: ({ pageData }) => {
    const normalizedPath = pageData.relativePath
      .replace(/(^|\/)index\.md$/, '$1')
      .replace(/\.md$/, '')

    const canonicalPath = normalizedPath ? `/${normalizedPath}` : '/'
    const canonicalUrl = `https://bobdyn.com${canonicalPath}`

    return [
      ['link', { rel: 'canonical', href: canonicalUrl }],
      ['meta', { property: 'og:url', content: canonicalUrl }],
    ]
  },

  themeConfig: {
    logo: '/bob.png',
    siteTitle: 'BobDyn',

    nav: [
      { text: 'BobLib', link: '/boblib/' },
      { text: 'BobSim', link: '/bobsim/' },
      { text: 'Reference', link: '/reference/' },
      // Add new top-nav entries here
    ],

    sidebar: {
      // BobLib pages - only show boblib
      '/boblib/': [
        {
          text: 'BobLib',
          collapsed: false,
          items: [
            { text: 'Overview', link: '/boblib/' },
          ]
        }
      ],
      // BobSim pages - only show solver nav
      '/bobsim/': [
        {
          text: 'BobSim',
          collapsed: false,
          items: [
            { text: 'Overview', link: '/bobsim/' },
            { text: 'Design of Experiments', link: '/bobsim/doe' },
          ]
        },
      ],

      // Reference pages - only show reference nav
      '/reference/': [
        {
          text: 'Reference',
          collapsed: false,
          items: [
            { text: 'Overview', link: '/reference/' },
          ]
        },
        {
          text: 'Performance Metrics',
          collapsed: false,
          link: '/reference/metrics',
          items: [
            { text: 'Steady-State Handling', link: '/reference/metrics#steady-state-handling' },
            { text: 'Transient Handling', link: '/reference/metrics#transient-handling' },
            { text: 'Stability and Control', link: '/reference/metrics#stability-and-control' },
            { text: 'Frequency-Domain', link: '/reference/metrics#frequency-domain-metrics' },
          ]
        },
        {
          text: 'Control Theory',
          collapsed: false,
          link: '/reference/control-theory',
          items: [
            { text: 'Open-Loop vs. Closed-Loop', link: '/reference/control-theory#open-loop-vs-closed-loop' },
            { text: 'Bang-Bang Control', link: '/reference/control-theory#bang-bang-control' },
            { text: 'PID Control', link: '/reference/control-theory#pid-control' },
            { text: 'Feedforward Control', link: '/reference/control-theory#feedforward-control' },
          ]
        },
      ],
    },

    outline: { level: [2, 3], label: 'On this page' },
    socialLinks: [
      { icon: 'github', link: 'https://github.com/longhornRacingElectric/' },
      { icon: 'instagram', link: 'https://www.instagram.com/longhornracing/' },
    ],

    search: {
      provider: 'local',
    },

    docFooter: {
      prev: 'Previous',
      next: 'Next'
    },
  },

    markdown: {
        math: true,
        theme: 'github-dark'
    },

    cleanUrls: true
})
