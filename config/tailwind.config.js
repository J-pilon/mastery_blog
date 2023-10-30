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
    container: {
      center: true,
    },
    fontSize: {
      'sm': '.75rem',
      'lg': '1rem',
      'xl': '1.125rem',
      '2xl': '1.5rem',
      '3xl': '2rem',
      '4xl': '2.75rem',
      '5xl': '3rem'
    },
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
        arimo: "Arimo"
      },
      colors: {
        'light': '#FFFAF4',
        'gray': '#C6C6C6',
        'primary': '#005B60',
        'secondary': '#00ADAD',
        'accent': '#ABABAB',
        'background': '#000000',
        // 'background': '#274472',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
