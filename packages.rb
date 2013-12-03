dep 'haskell', template: 'bin' do
  installs 'haskell-platform'
  provides %w[alex cabal happy]
end

dep 'heroku.bin' do
  installs 'heroku-toolbelt'
end

dep 'postgresql.bin' do
  provides %w[psql pg_config createdb createuser dropdb dropuser]
end

dep 'postgresql' do
  requires 'postgresql.bin', dep('postgis.lib')
end

dep 'redis', template: 'bin' do
  provides %w[redis-server redis-cli]
end

dep 'lein.bin' do
  installs 'leiningen'
end

dep 'imagemagick', template: 'bin' do
  provides %w[identify mogrify convert] 
end

dep 'packages' do
  requires(
    dep('tmux.bin'),
    dep('tree.bin'),
    dep('watch.bin'),
    dep('wget.bin'),
    dep('zsh.bin'),
    dep('casperjs.bin'),
    dep('curl.bin'),
    dep('imagemagick'),
    dep('ctags.bin'),
    dep('go.bin') { provides %w[go gofmt] },
    dep('memcached.bin'),
    dep('node.bin') { provides %w[node npm] },
    dep('libxml2.lib'),
    dep('libyaml.lib'),
    dep('openssl.lib'),
    dep('postgresql'),
    'lein.bin',
    'heroku.bin',
    'redis',
    'haskell'
  )

  requires {
    on :osx, dep('reattach-to-user-namespace.bin')
  }
end
