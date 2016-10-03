# coding: utf-8

class Enemy < Sprite
  def initialize(x,y,im)
    super(x,y,im)
    @font= Font.new(30)
    @dx=1
    @dy=1
  end
  def update
    self.y += @dy
    self.x += @dx
    if self.y >= Window.height - self.image.height
      self.vanish
    end
  end
  def draw

	Window.draw(self.x, self.y, self.image)	
	Window.draw_font(self.x+5, self.y+5, "惡",@font)
  end
  # 他のオブジェクトから衝突された際に呼ばれるメソッド
  def hit(obj)
	if obj.instance_of?Wall
		if obj.gid===2
			@dy*=-1
		else
			@dx*=-1
		end
	elsif obj.instance_of?Player
	   self.vanish
	else 
		@dy*=-1
	end
        
  end
end
