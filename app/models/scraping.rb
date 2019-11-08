class Scraping
  def self.movie_urls
    links = []
    agent = Mechanize.new
    current_page = agent.get("https://www.minkou.jp/hischool/ranking/")
    elements = current_page.search('.mod-listRanking-name a')
    elements.each do |ele|
      links << ele.get_attribute('href')
    end

    links.each do |link|
      get_product('https://www.minkou.jp/hischool/ranking/' + link)
    end
  end

  def self.get_product(link)
    agent = Mechanize.new
    page = agent.get(link)
    title = page.at('.mod-listRanking-name').inner_text
    image_url = page.at('.js-noPhoto img')[:src] if page.at('.js-noPhoto img')

    product = Product.new(title: title, image_url: image_url)
    product.save
  end
end