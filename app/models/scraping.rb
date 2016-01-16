class Scraping
  def self.movie_urls
    links = []
    agent = Mechanize.new
    current_page = agent.get("http://eiga.com/now/")
    elements = current_page.search('.m_unit h3 a')
    elements.each do |ele|
      links << ele.get_attribute('href')
    end

    links.each do |link|
      get_product('http://eiga.com' + link)
    end
  end

  def self.get_product(link)
    agent = Mechanize.new
    page = agent.get(link)
    title = page.at('.moveInfoBox h1').inner_text
    image_url = page.at('.pictBox img')[:src]

    product = Product.new(title: title, image_url: image_url)
    product.save
  end
end