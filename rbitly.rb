#VERSION 0.1

require 'green_shoes'

require 'bitly'

Shoes.app :title => 'Get Bit.ly URL', :height => 100, :width => 480 do

#extend HH::Markup

background rgb(93,173,245)

s = flow do

#validate_base_url = /^http:\/\/www\.[a-zA-Z0-9]*\.\w{1,3}\D\$/
#valdate_url = /^http:\/\/www\.[a-zA-Z0-9]*\.\w{1,3}\D\/\S*/

image 'img/logo.png', :top => 0

@urlbox = edit_line :width => 256, :left => 50, :top => 40
@send = button 'Go!', :width => 20
@copy = button  'Copy', :width => 20
@reset = button 'Reset', :width => 20


@msg = "#{strong('Get shortened URL!')}"
@result = tagline @msg,
:top => 60,
:left => 120,
:width => 60


@access = {:user=>'explosiveamber', :apikey=>'R_06f68b8a3502904b9a26ca8fc471b819'}

@send.click do 
@get_url.call()
end

@copy.click do
self.clipboard = @result.text()
end

@reset.click do
@urlbox.text = ''
@result.replace @msg
end

@get_url = Proc.new do |url|
	url=@urlbox.text
	#if ((self.validate_base_url =~ url) || (self.validate_url =~ url )) then 
	
	instance = Bitly.new(@access[:user], @access[:apikey])
	short_url = instance.shorten(url)
        short_url = short_url.shorten
	
	@result.text=strong(short_url)
	end
	#end
end
end


