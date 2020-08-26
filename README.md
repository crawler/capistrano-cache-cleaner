# Set of tasks to clean rails cache

### `cap cache:clean:tmp`

Calls `rake tmp:clear`

### `cap cache:clean:monthly`

Tracks the last cleanup time and repeat it monthly. Bootsnap, assets, webpack, etc cache can grow a bit. But we don't want it to be cleaned on each deploy, or via background job (to avoid side effects)

### `cap cache:clean:pages`

Will clean the static pages cache directory. Can be set via `:chached_pages_dir` relative to the `shared` path and defaults to `public/static_pages`
