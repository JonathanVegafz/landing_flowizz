// @ts-check
import { defineConfig } from 'astro/config';
import react from '@astrojs/react';

// https://astro.build/config
export default defineConfig({
	integrations: [react()],
	// site: 'https://XaxavierJS.github.io',
 	// base: 'Flowizz.github.io',
	vite: {
    build: {
      rollupOptions: {
        output: {
          manualChunks: {
            'vendor': ['aos']
          }
        }
      },
      assetsInlineLimit: 4096
    },
    css: {
      devSourcemap: false
    },
    optimizeDeps: {
      include: ['aos']
    }
  },
});
