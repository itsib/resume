import { type UserConfig, defineConfig } from 'vite';
import handlebars from 'vite-plugin-handlebars';
import { resolve } from 'node:path'
import nesting from 'postcss-nesting'
import autoprefixer from 'autoprefixer'
import * as data from './data.json' with { type: 'json' }

export default defineConfig(() => {

  return {
    css: {
      postcss: {
        plugins: [
          nesting(),
          autoprefixer()
        ]
      },
    },
    plugins: [
      handlebars({
        partialDirectory: resolve('src', 'templates'),
        context: data,
      })
    ],
  } satisfies UserConfig;
});
