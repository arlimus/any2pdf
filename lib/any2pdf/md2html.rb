require 'erb'

class Any2Pdf
  def embed_html( raw, source )
    begin
      require 'websnap'
      w = WebSnap.new( nil, nil )

      # parse raw html contents
      Log.info "embedding html via websnap"
      h = Nokogiri::HTML(raw)

      # embed all parts into the html
      w.spiderHtmlElements( 'file://'+File::expand_path(source), h )

      # return the resulting html as string
      h.to_s
    rescue LoadError
      return raw
    end
  end

  def md2html(file, outfile, opts, stylefile)
    return nil if not file.end_with?(".md")
    outfile_raw = outfile+".raw.html"

    rel_path = File.expand_path('../../data', File.dirname(__FILE__))

    # prep-work for including style and script
    style_e = lambda{|f,o| "<style type=\"text/css\" #{o}>\n#{File::read(f)}\n</style>" }
    style_l = lambda{|f,o| "<link rel=\"stylesheet\" href=\"#{f}\" #{o} />" }
    script_e = lambda{|f,o| "<script #{o}>\n#{File::read(f)}\n</script>" }
    script_l = lambda{|f,o| "<script src=\"#{f}\" #{o} ></script>"}
    style = opts[:embed] ? style_e : style_l
    script = opts[:embed] ? script_e : script_l

    # get all fields in the heading
    raw_heading = [
      # start with stylesheets
      style.( rel_path+"/boilerplate.css", ''),
      style.( File::expand_path(stylefile), '' ),
      style.( rel_path+"/print.css", 'media="print"'),
      script.( rel_path+"/jquery-1.9.0.min.js", '' ),
      ( opts[:toc] ? script.( rel_path+"/toc_generator.js", '' ) : '' )
      ].join("\n\n")

    # create the html
    `pandoc "#{file}" -o "#{outfile_raw}" --template #{rel_path}/pandoc-template.html --toc`
    raw_html = File::read outfile_raw
    File.delete outfile_raw

    # additional options
    toc_level = opts[:toc_level]
    number_headings = (opts[:numbering] == true)

    # actually create the result file
    renderer = ERB.new(File::read(rel_path + "/template.html.erb"))
    html = embed_html( renderer.result(binding), file )
    
    # save the html to file
    File::write outfile, html
    outfile
  end

end