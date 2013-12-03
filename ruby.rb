dep 'rubies' do
  requires \
    dep('chruby.lib'),
    dep('1.9.ruby'),
    dep('2.0.ruby'),
    'set default ruby'
end

dep 'set default ruby' do
  file = '~/.ruby-version'.p

  met? { file.exists? }
  meet { 
    highest = shell('ls -1 ~/.rubies | grep -E "^ruby-" | sort | tail -n1')
    file.write(highest + "\n")
  }
end

meta :ruby do
  accepts_value_for :engine

  template {
    requires_when_unmet dep('ruby-install.bin')

    met? {
      '~/.rubies'.p.exists? &&
      shell('ls -1 ~/.rubies').
        split(/[\r\n]+/).
        grep(/#{Regexp.quote(basename)}/).
        any?
    }

    meet {
      log "Building Ruby #{basename}"
      shell 'ruby-install', 'ruby', basename
    }
  }
end
