class Any2Pdf
  def get_style( stylename, type = "css" )
    rel_path = File.expand_path('../../data', File.dirname(__FILE__))

    if not stylename.nil? and not stylename.empty?
      a =
        get_existing(stylename) ||
        get_existing("#{rel_path}/#{stylename}.#{type}") ||
        get_existing("#{rel_path}/#{stylename}")
      return a if not a.nil?
      Log.warn "couldn't find stylesheet #{stylename}. Trying default.\n"
    end

    # try default, if the user supplied crap...
    a = get_existing("#{rel_path}/default.#{type}")
    return a if not a.nil?
    Log.error "Couldn't find internal stylesheet in #{rel_path}/default.#{type}. Something is seriously wrong! try reinstalling?\n"
    ""
  end

end