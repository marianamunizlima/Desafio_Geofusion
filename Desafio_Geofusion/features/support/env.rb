# encoding: utf-8

require 'watir'

browser_create = lambda do |navegador|
  browser =  Watir::Browser.new navegador
  browser.driver.manage.window.maximize
  browser
end


if Gem.win_platform? #Se a automação rodar no windows
  ENV['HTTP_PROXY'] = ENV['http_proxy'] = nil
  chromedriver_path = 'C:/browsers/chromedriver.exe'
  raise "Não foi  possível achar o ChromeDriver em #{chromedriver_path}" if !File.file?(chromedriver_path)
  Selenium::WebDriver::Chrome.driver_path = chromedriver_path
end

navegador = case ENV['NAVEGADOR']

    
 
when /firefox/i
  :firefox
else
  client = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 180 # seconds
    browser = Watir::Browser.new :chrome #, http_client: client
    browser.driver.manage.window.maximize
end


page = lambda {|b, klass| klass.new b }.curry.(browser)

Before do
  @page = page
  #Seta o navegar como variavel de instancia para os cenários utilizarem
  @browser = browser
  @navegador = navegador

  @env = ENV["AMBIENTE"]  
end

at_exit do
  browser.cookies.clear
  browser.close
end