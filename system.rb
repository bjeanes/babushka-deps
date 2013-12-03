dep 'system' do
  requires \
    'ssh key',
    'dot files',
    'packages',
    'rubies'
end

dep 'ssh key', :key do
  key.default! '~/.ssh/id_rsa'.p.expand

  met? { key.p.exists? }  
  meet { shell "ssh-keygen -t rsa -b 4096  -f #{key.to_s.inspect}" }
end
