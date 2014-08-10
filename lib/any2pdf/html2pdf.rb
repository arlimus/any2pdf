require 'uri'
require 'nokogiri'
require 'css_parser'
require 'pdfkit'

class Any2Pdf
  def pdfkit_html2pdf( file, outfile, opts )
    styles = []
    styles << opts.stylesheet

    style_opts = get_style_options opts.stylesheet

    # find css files
    dom = Nokogiri::parse( File::open(file).read() )
    dom.css("link").each do |e| 
      styles << e.attr("href")
    end

    # update the html links to make sure that local links (relative) work
    ( dom.css("@src") + dom.css("@href") ).
      find_all{|src| (src.value =~ URI::regexp) == nil }.
      each{|src| src.value = File::expand_path(src.value) }

    options = {
      footer_right:   "[page]/[topage]",
      orientation:    (( opts[:landscape] ) ? "landscape" : "portrait" ),
      page_size:      'A4',
    }.merge(style_opts)
    html = dom.to_s
    kit = PDFKit.new(html, options)

    styles.compact.each do |style| 
      kit.stylesheets << style if File::exists?(style)
    end

    kit.to_file(outfile)
  end

  def xelatex_html2pdf( file, outfile, opts )
    puts outfile
    texfile = "#{outfile}".sub(/[.]pdf$/, '.tex')

    cmd = "pandoc \"#{file}\" --listings -o \"#{texfile}\""
    Log.debug "convert html to tex: #{cmd}"
    `#{cmd}`

    verb_opts = "mathescape,
                 linenos,
                 numbersep=5pt,
                 frame=single,
                 framesep=1mm,
                 bgcolor=colorcode_bg".gsub("\n",'')

    tex = File::read(texfile).
      # all verbatim stuff is in lstlistings like this:
      # \begin{lstlisting}[language=bash]
      # convert it to minted
      gsub(/\\begin{lstlisting}\[language=([^\]]*)\]/){'\begin{minted}['+verb_opts+']{'+$1+'}'}.
      gsub(/\\begin{lstlisting}/, '\begin{minted}['+verb_opts+']{bash}').
      gsub(/\\lstinline(.)(.*?)\1/){ '\colorbox{colorcode_bg}{\lstinline'+$1+$2+$1+'}' }.
      gsub(/\\end{lstlisting}/, '\end{minted}')

    tex_style = get_style( opts[:stylesheet], 'tex' )
    File::write texfile, File::read(tex_style).sub(/CONTENT/, tex)

    cmd = "xelatex -shell-escape \"#{texfile}\""
    Log.debug "convert tex to pdf: #{cmd}"
    `#{cmd}`
  end

  def html2pdf(file, opts)
    Log.debug "running html2pdf on '#{file}'"
    return nil if not file.end_with?(".html")
    pdffile = file.sub(/.html$/,".pdf")
    pdffile = opts.output if not opts.output.nil? and not opts.output.empty?
    Log.debug "output pdf will be '#{pdffile}'"

    case opts[:renderer]
    when 'pdfkit'
      pdfkit_html2pdf file, pdffile, opts
    when 'xelatex'
      xelatex_html2pdf file, pdffile, opts
    else
      Log.abort "Can't find renderer '#{opts[:renderer]}'. Please use a supported renderer!"
    end

    pdffile
  end

private

  def get_style_options style_file
    return {} unless File::file? style_file

    declarations = []

    css = CssParser::Parser.new
    css.load_file! style_file
    css.each_rule_set do |rule|
      if rule.selectors.include? '#pdf'
        rule.each_declaration do |id, params|
          declarations.push [id, params]
        end
      end
    end

    # check all rules
    opts = {}
    declarations.each do |field,value|
      if field == 'margin'
        vals = value.split(' ');
        if vals.length == 4
          opts[:margin_top] = vals[0]
          opts[:margin_right] = vals[1]
          opts[:margin_bottom] = vals[2]
          opts[:margin_left] = vals[3]
        end
        if vals.length == 2
          opts[:margin_top] = vals[0]
          opts[:margin_right] = vals[1]
          opts[:margin_bottom] = vals[0]
          opts[:margin_left] = vals[1]
        end
        if vals.length == 1
          opts[:margin_top] = vals[0]
          opts[:margin_right] = vals[0]
          opts[:margin_bottom] = vals[0]
          opts[:margin_left] = vals[0]
        end
      end

    end

    opts
  end

end