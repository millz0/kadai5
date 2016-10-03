# coding: utf-8
require 'dxruby'

require_relative 'player'
require_relative 'enemy'
require_relative 'wall'
require_relative 'block'

Window.width  = 800
Window.height = 600
Window.caption = '善と悪'
font= Font.new(30)
sp = Image.load('sp.png')  # sp.pngを読み込む
walls = [Wall.new(  0, 0, Image.new( 10, 600,color=[150,50,150]),1),
          Wall.new(  0, 0, Image.new(800,  40, color=[150,50,150]),2),
          Wall.new(790, 0, Image.new( 10, 600, color=[150,50,150]),3),
          ]
image = Image.new(58, 18, color=[100,100,100] )#省略すると透明・[赤R, 緑G, 青B]・[透明度α, 赤R, 緑G, 青B]
 blocks = []
 5.times do |y|
   12.times do |x|
     blocks << Bl.new(21 + 60 * x , 21 + 20 * y+480, image)
   end
 end
player_c = Image.new(40, 40).circle_fill(20, 20, 20,  color=[200,255,255,50])
enemy_c =Image.new(40, 40).circle_fill(20, 20, 20, color=[255,200,10,10])

player = Player.new(400, 400, player_c)


en_count=10

enemies = []
en_count.times do
  enemies << Enemy.new(rand(800), rand(300), enemy_c)
end

point=0
enen=0
sen=0
########################################################
Window.loop do
  break if Input.keyPush?(K_ESCAPE)
if sen===0
	image = Image.new(58, 18, color=[100,100,100] )#省略すると透明・[赤R, 緑G, 青B]・[透明度α, 赤R, 緑G, 青B]
	blocks = []
	5.times do |y|
		12.times do |x|
			blocks << Bl.new(21 + 60 * x , 21 + 20 * y+480, image)
		end
	end
	player_c = Image.new(40, 40).circle_fill(20, 20, 20,  color=[200,255,255,50])
	enemy_c =Image.new(40, 40).circle_fill(20, 20, 20, color=[255,200,10,10])
	player = Player.new(400, 400, player_c)
	en_count=10

	enemies = []
	en_count.times do
		enemies << Enemy.new(rand(700)+5, rand(300)+100, enemy_c)
	end

	enen=0
	point=0
	Window.draw_font(250, 250, "スペースを押してください",font)
	if Input.key_push?( K_SPACE )
		sen=1
	end
#######################################################
elsif sen===1  
 Window.draw(0, 0, sp)  # sky.pngを描画する
	
  Sprite.update(walls)
  Sprite.draw(walls)
  Window.draw_font(15, 5, "point:#{point}",font)
  enen+=1
  Sprite.update(blocks)
  Sprite.draw(blocks)
  Sprite.clean(blocks)

  Sprite.update(enemies)
  Sprite.clean(enemies)
  if enemies.length<en_count
	point+=(en_count-enemies.length)*10
  end
  en_count=enemies.length
  if enen%30 === 0
	enemies<<Enemy.new(rand(700)+5, rand(300)+100, enemy_c)
  end
  Sprite.draw(enemies)

  player.update
  player.draw


  # 当たり判定
  Sprite.check(player, enemies)
  walls.each {|i|
  	Sprite.check(i , enemies)
  }
blocks.each {|i|
  	Sprite.check(i,enemies)
  }
blocks.each {|i|
  	Sprite.check(i,player)
  }
	if point>=500
		sen=3
	end
	Window.draw_font(550, 5, "残りブロック：#{blocks.length}",font)
	if blocks.length<=0
		sen=4
	end
#####################################################
elsif sen===3
	Window.draw_font(300, 200, "Game Clear",font)
	Window.draw_font(250, 250, "スペースを押してください",font)
	if Input.key_push?( K_SPACE )
		sen=0
	end
#################################################	
else 
	Window.draw_font(300, 200, "Game Over",font)
	Window.draw_font(250, 250, "スペースを押してください",font)
	if Input.key_push?( K_SPACE )
		sen=0
	end
end
end