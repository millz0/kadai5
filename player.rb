#coding:Shift_JIS 

class Player < Sprite
  def initialize(x,y,im)
    super(x,y,im)
    @font= Font.new(30)
  end
  def update
#    self.x = Input.mouse_x-40
#    self.y = Input.mouse_y-40
     self.x += Input.x*3
     self.y += Input.y*3
  end
  def draw
	Window.draw(self.x, self.y, self.image)	
	Window.draw_font(self.x+5, self.y+5, "善",@font)
  end
  
end