meta :font do
  accepts_value_for :source

  template do
    def dest
      "~/Library/Fonts/#{File.basename(source)}".p.expand_path
    end

    met? { File.exists?(dest) }
    meet { shell "curl -L #{source} > #{dest}" }
  end
end
