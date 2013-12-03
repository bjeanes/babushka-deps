dep 'dot files cloned' do
  met? { '~/.config/.git'.p.exists? }
  meet { git 'https://github.com/bjeanes/dot-files.git', to: '~/.config' }
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
