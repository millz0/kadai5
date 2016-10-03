#coding:Shift_JIS 
class Wall < Sprite
	def initialize(x,y,im,id)
 		super(x,y,im)
		@id=id
	end
	def gid()
		@id
	end
 
end