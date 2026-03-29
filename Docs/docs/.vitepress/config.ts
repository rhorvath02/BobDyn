import {defineConfig} from 'vitepress'

export default defineConfig({
    title: 'BobDyn',
    description: 'First-principles vehicle dynamics analysis for Formula SAE',
    base: '/',
    appearance: 'dark',

<<<<<<< HEAD
    head: [
        ['link', {rel: 'icon', type: 'image/png', href: '/bob.png'}],
    ],

    themeConfig: {
        logo: '/bob.png',
        siteTitle: 'BobDyn',
=======
  head: [
    ['link', { rel: 'icon', type: 'image/png', href: '/bob.png' }],
  ],

  themeConfig: {
    logo: '/bob.png',
    siteTitle: 'BobDyn',

    nav: [
      {text: 'BobLib', link: '/boblib/' },
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
>>>>>>> 1c9aaf626c603f1b8b20bdd48a1a654abf63df1f

        nav: [
            {text: 'BobLib', link: '/boblib/'},
            {text: 'BobSim', link: '/bobsim/'},
            {text: 'Reference', link: '/reference/'},
            // Add new top-nav entries here
        ],

        sidebar: {
            // BobLib pages - only show boblib
            '/boblib/': [
                {
                    text: 'BobLib',
                    collapsed: false,
                    items: [
                        {text: 'Overview', link: '/boblib/'},
                    ]
                }
            ],
            // BobSim pages - only show solver nav
            '/bobsim/': [
                {
                    text: 'BobSim',
                    collapsed: false,
                    items: [
                        {text: 'Overview', link: '/bobsim/'},
                        {text: 'Design of Experiments', link: '/bobsim/doe'},
                    ]
                },
            ],

            // Reference pages - only show reference nav
            '/reference/': [
                {
                    text: 'Reference',
                    collapsed: false,
                    items: [
                        {text: 'Overview', link: '/reference/'},
                    ]
                },
                {
                    text: 'Performance Metrics',
                    collapsed: false,
                    link: '/reference/metrics',
                    items: [
                        {
                            text: 'Steady-State Handling',
                            link: '/reference/metrics#steady-state-handling'
                        },
                        {text: 'Transient Handling', link: '/reference/metrics#transient-handling'},
                        {
                            text: 'Stability & Control',
                            link: '/reference/metrics#stability-and-control'
                        },
                        {
                            text: 'Frequency-Domain',
                            link: '/reference/metrics#frequency-domain-metrics'
                        },
                    ]
                },
                {
                    text: 'Control Theory',
                    collapsed: false,
                    link: '/reference/control-theory',
                    items: [
                        {
                            text: 'Open-Loop vs. Closed-Loop',
                            link: '/reference/control-theory#open-loop-vs-closed-loop'
                        },
                        {
                            text: 'Bang-Bang Control',
                            link: '/reference/control-theory#bang-bang-control'
                        },
                        {text: 'PID Control', link: '/reference/control-theory#pid-control'},
                        {
                            text: 'Feedforward Control',
                            link: '/reference/control-theory#feedforward-control'
                        },
                    ]
                },
            ],
        },

        outline: {level: [2, 3], label: 'On this page'},
        socialLinks: [
            {icon: 'github', link: 'https://github.com/rhorvath02/VehicleDynamics'},
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
