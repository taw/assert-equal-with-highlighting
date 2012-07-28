# escape text to make it useable in a shell script as one “word” (string)
def e_sh(str)
	str.to_s.gsub(/(?=[^a-zA-Z0-9_.\/\-\x7F-\xFF\n])/, '\\').gsub(/\n/, "'\n'").sub(/^$/, "''")
end

# escape text for use in a TextMate snippet
def e_sn(str)
	str.to_s.gsub(/(?=[$`\\])/, '\\')
end

# escape text for use in a TextMate snippet placeholder
def e_snp(str)
	str.to_s.gsub(/(?=[$`\\}])/, '\\')
end

# escape text for use in an AppleScript string
def e_as(str)
	str.to_s.gsub(/(?=["\\])/, '\\')
end

# URL escape a string but preserve slashes (idea being we have a file system path that we want to use with file://)
def e_url(str)
  str.gsub(/([^a-zA-Z0-9\/_.-]+)/n) do
    '%' + $1.unpack('H2' * $1.size).join('%').upcase
  end
end

# Make string suitable for display as HTML, preserve spaces. Set :no_newline_after_br => true
# to cause “\n” to be substituted by “<br>” instead of “<br>\n”
def htmlize(str, opts = {})
  str = str.to_s.gsub("&", "&amp;").gsub("<", "&lt;")
  str = str.gsub(/\t+/, '<span style="white-space:pre;">\0</span>')
  str = str.reverse.gsub(/ (?= |$)/, ';psbn&').reverse
  str = if opts[:no_newline_after_br].nil?
    str.gsub("\n", "<br>\n")
  else
    str.gsub("\n", "<br>")
  end
  colored_htmlize(str)
end

# Converts 'colored' strings to HTML
def colored_htmlize(str)
  open_tags = []
  str = str.dup
  str.gsub!(/\e\[([34][0-7]|[014])m/){
    value = $1.to_i
    if value >= 30
      # colors
      html_color = [
        'black',
        'red',
        'green',
        'yellow',
        'blue',
        'magenta',
        'cyan',
        'white',        
      ][value % 10]
      open_tags << "span"
      if value >= 40
        "<span style='background-color: #{html_color}'>"
      else
        "<span style='color: #{html_color}'>"
      end
    elsif value == 0
      res = open_tags.reverse.map{|tag| "</#{tag}>"}.join
      open_tags = []
      res
    elsif value == 1
      open_tags << "b"
      "<b>"
    elsif value == 4
      open_tags << "u"
      "<u>"
    else
      ""
    end
  }
  str << open_tags.reverse.map{|tag| "</#{tag}>"}.join
  str
end
