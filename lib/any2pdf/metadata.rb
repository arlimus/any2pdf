class Any2Pdf

  def fill_in_metadata( path, tmpfile )
    tag = `git describe --tags --abbrev=0`.chomp
    gitlog = `git log -1 --pretty=format:'%h %ct'`
    commit, date = gitlog.split(" ")
    if commit == "" || date == nil
      Log.warn "Can't find git info for latest commit. Ignoring."
      return path
    end
    Log.info "Adding git metadata: #{tag} #{commit} #{date}"

    time = Time.at( date.to_i )
    timestamp = "%04d-%02d-%02d" % [ time.year, time.month, time.day ]

    content = File::read(path)
    info = ["---",
      "git_commit: #{commit}",
      "git_date: #{timestamp}",
      (tag == "" ) ? nil : "git_tag: #{tag}"
      ].compact.join("\n") + "\n"

    if content.start_with?("---\n")
      nu = content.sub("---\n",info)
    else
      nu = info + "---\n" + content
    end

    File::write( tmpfile, nu )
    tmpfile
  end

  private

  def get_existing( f )
    path = File::expand_path(f)
    return path if File::exists?(path)
    return nil
  end

end