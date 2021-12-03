const esbuild = require('esbuild')

const { sassPlugin } = require("esbuild-sass-plugin");

const args = process.argv.slice(2)
const watch = args.includes('--watch')
const deploy = args.includes('--deploy')

const loader = {
  '.woff': 'file',
  '.woff2': 'file',
  '.svg': 'file'
}

const plugins = [
  sassPlugin({})
]

let opts = {
  entryPoints: ['js/app.js', 'bitstyles/assets/images/icons.svg'],
  bundle: true,
  target: 'es2016',
  outdir: '../priv/static/assets',
  logLevel: 'info',
  loader,
  assetNames: "assets/[name]",
  plugins
}

if (watch) {
  opts = {
    ...opts,
    watch,
    sourcemap: 'inline'
  }
}

if (deploy) {
  opts = {
    ...opts,
    minify: true
  }
}

const promise = esbuild.build(opts)

if (watch) {
  promise.then(_result => {
    process.stdin.on('close', () => {
      process.exit(0)
    })

    process.stdin.resume()
  })
}
