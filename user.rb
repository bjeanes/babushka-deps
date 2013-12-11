# FIXME: this shouldn't be a task since we can check
dep 'shell', template: 'task' do
  requires dep('zsh.bin')

  run {
    log 'TODO'
  }
end


dep 'dot files cloned' do
  met? { '~/.config/.git'.p.exists? }
  meet {
    shell \
      'git', 'clone', '--recursive',
      'https://github.com/bjeanes/dot-files.git',
      '~/.config'.p.expand
  }
end

dep 'dot files linked' do
  met? { false }
  meet {
    Dir.chdir '~/.config'.p.expand do
      shell 'yes a | rake install'
    end

    met? { true }
  }
end

dep 'dot files' do
  requires 'dot files cloned', 'dot files linked'
end

dep 'user bins' do
  requires 'user bin dir'

  # TODO
  # * selecta
end

dep 'user bin dir', template: 'task' do
  run { '~/bin'.p.mkdir }
end
