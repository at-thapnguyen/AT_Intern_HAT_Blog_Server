class UrlStripper
  def self.strip(html)
    html.gsub(/<a .*?>(.*?)<\/a>/, '\1')
  end
end