class Scraping
  def self.movie_urls
    links = []
    agent = Mechanize.new

    next_url = "/now/"

    while true do
    current_page = agent.get("http://eiga.com/now/" + next_url)
    elements = current_page.search('.m_unit h3 a')
    elements.each do |ele|
      links << ele.get_attribute('href')
    end

    next_link = current_page.at('.next_page')
    next_url = next_link.get_attribute('href')
    break unless next_url
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

    product = Product.where(title: title, image_url: image_url).first_or_initialize
    product.save
  end
end