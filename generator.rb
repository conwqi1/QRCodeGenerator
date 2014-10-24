require 'rqrcode_png'
require 'mini_magick'


class QRGenerator

  def run
    generate_img
    embed_img
    show_code
  end
  
  private

  def generate_img
    url = get_input
    qr = RQRCode::QRCode.new(url, :size => 4, :level => :h )
    png = qr.to_img
    png.resize(300, 300).save("qr.jpg")
  end

  def embed_img
    first_image  = MiniMagick::Image.new("./qr.jpg")
    second_image = MiniMagick::Image.new("img/logo.jpg")
    second_image.resize "100x20"
    result = first_image.composite(second_image) do |c|
      c.compose "Over"    
      c.geometry "+100+140" 
    end
    result.write "output.jpg"
  end
  
  def get_input
    puts "please enter the url:"
    url = gets.chomp
  end
  
  def show_code
    `open output.jpg`
  end
end

qr = QRGenerator.new
qr.run