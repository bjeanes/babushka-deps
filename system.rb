dep 'system' do
  requires \
    'ssh key',
    'set up personal deps',
    'dot files',
    'packages',
    'rubies'
end

dep 'ssh key', :key do
  key.default! '~/.ssh/id_rsa'.p.expand

  met? { key.p.exists? }
  meet { shell "ssh-keygen -t rsa -b 4096  -f #{key.to_s.inspect}" }
end

dep 'set up personal deps' do
  user = ENV['USER']
  source_name = File.basename(File.dirname(__FILE__))
  personal = '~/.babushka/deps'.p

  met? {
    user != source_name || personal.exists?
  }

  meet { shell 'ln', '-s', File.dirname(__FILE__), personal.to_s }
end
