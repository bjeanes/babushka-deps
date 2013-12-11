dep 'apps' do
  requires {
    on :osx, 'osx apps'
  }
end

# TODO: add appropriate ones to start-up items
dep 'osx apps' do
  requires %w[
    Alfred.app Dropbox.app MacVim.app 1Password.app
    Google\ Chrome.app Adium.app Skype.app iTerm.app
    iStat\ Menus.app Bartender.app HipChat.app
  ]
end

dep 'HipChat.app' do
  source 'https://www.hipchat.com/downloads/latest/mac'
end

dep 'Bartender.app' do
  sparkle 'http://www.macbartender.com/updates/updates.php'
end

dep 'iTerm.app' do
  sparkle 'http://www.iterm2.com/appcasts/testing.xml'
end

dep 'iStat Menus.app' do
  sparkle 'http://bjango.com/istatmenus/appcast/appcast.xml'
end

dep 'Alfred.app' do
  sparkle 'http://media.alfredapp.com/update/appcast.xml'
end

# TODO: Delete '~/Documents' and symlink to '~/Dropbox/Documents'
#       (after dropbox account set up etc)
dep 'Dropbox.app' do
  source 'https://www.dropbox.com/download?plat=mac'
end

dep 'Google Chrome.app' do
  source 'https://dl-ssl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg'
end

dep '1Password.app' do
  source 'https://d13itkw33a7sus.cloudfront.net/dist/1P/mac4/1Password-4.0.9.zip'
end

# TODO: Symlink mvim into ~/bin
dep 'MacVim.app' do
  requires 'user bin dir'
  source 'https://macvim.googlecode.com/files/MacVim-snapshot-70-Mountain-Lion.tbz'
  after {
    shell 'ln -s /Applications/MacVim.app/Contents/MacOS/MacVim ~/bin/mvim'
    shell 'ln -s /Applications/MacVim.app/Contents/MacOS/Vim ~/bin/vim'
  }
end

dep 'Adium.app' do
  sparkle 'https://adium.im/sparkle/appcast-release.xml'
end

dep 'Skype.app' do
  source 'http://www.skype.com/go/getskype-macosx'
end

