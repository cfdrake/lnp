-- freejazz
--
-- pschhh
--
-- ENC1 x
-- ENC2 y
-- ENC3 z (trig speed)

engine.name = "Freejazz"

function init()
  x = 0.1
  y = 0.5
  z = 0.5
  
  engine.x(x)
  engine.y(y)
  engine.z(z)
  
  print("pschhh")
end

function enc(n, d)
  if n == 1 then
    x = util.clamp(x + (d * 0.1), 0.1, 10)
    engine.x(x)
  elseif n == 2 then
    y = util.clamp(y + (d * 0.01), 0.5, 1)
    engine.y(y)
  else
    z = util.clamp(z + (d * 0.1), 0.5, 30)
    engine.z(z)
  end
  redraw()
end

function redraw()
  screen.clear()
  screen.stroke()
  screen.level(15)
  screen.font_size(math.random(15, 20))
  screen.font_face(5)
  screen.move(math.random(0, 100), math.random(0, 100))
  screen.text("free")
  screen.move(math.random(0, 100), math.random(0, 100))
  screen.text("jazz")
  for i=1,10 do
    screen.level(math.random(1, 5))
    screen.circle(math.random(0, 100), math.random(0, 100), math.random(0, 100))
    screen.stroke()
  end
  screen.update()
end