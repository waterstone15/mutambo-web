const DT = require('tailwindcss/defaultTheme')

module.exports = {
  content: {
    files: [
      './app/**/*.{em,emblem,hbs,html,coffee}',
      './app/index.html',
    ]
  },
  theme: {
    extend: {
      gridTemplateColumns: {
        'auto-fill-300': 'repeat(auto-fill, minmax(300px, 1fr))',
      },
      colors: {
        brown: {
          50: '#fdf8f6',
          100: '#f2e8e5',
          200: '#eaddd7',
          300: '#e0cec7',
          400: '#d2bab0',
          500: '#bfa094',
          600: '#a18072',
          700: '#977669',
          800: '#846358',
          900: '#43302b',
        }
      },
      fontFamily: {
        sans: [
          'Roboto',
          ...DT.fontFamily.sans,
        ],
        mono: [
          'Roboto Mono',
          ...DT.fontFamily.mono,
        ],
      },
    }
  },
  plugins: [
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/forms')({ strategy: 'class', }),
    require('@tailwindcss/line-clamp'),
    require('@tailwindcss/typography'),
  ],
}