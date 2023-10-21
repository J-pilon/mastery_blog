const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  safelist: [
    // 'bg-background',
    // 'bg-red-800',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
        arimo: "Arimo"
      },
      colors: {
        'light': '#FFFAF4',
        'black': '#1A1B1F',
        'primary': '#41729F',
        'secondary': '#C3E0E5',
        'tertiary': '#274472',
        'background': '#5885AF',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
