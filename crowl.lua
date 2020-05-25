-- #c#r#o#w#l#
--
-- ENC1 volume
-- ENC2 x
-- ENC3 y
--
-- KEY2 randomize x
-- KEY3 randomize y

engine.name = "Crowl"

function init()
  amp = 1
  x = 60
  y = 0.5
  
  engine.x(x)
  engine.y(y)
  engine.amp(amp)
end

function enc(n, d)
  if n == 1 then
    amp = util.clamp(amp + (d * 0.01), 0, 1)
    engine.amp(amp)
  elseif n == 2 then
    x = util.clamp(x + d, 60, 8000)
    engine.x(x)
    redraw()
  elseif n == 3 then
    y = util.clamp(y + (d * 0.5), 0.5, 200)
    engine.y(y)
    redraw()
  end
end

function key(n, z)
  if n == 2 and z == 1 then
    x = math.random(60, 8000)
    engine.x(x)
  elseif n == 3 and z == 1 then
    y = math.random(1, 200)
    engine.y(y)
  end
  
  redraw()
end

function redraw()
  if math.random() > 0.7 then
    screen.clear()
  end
  screen.level(1)
  screen.move(math.random(1, 40), math.random(1, 50))
  screen.font_size(math.random(10, 20))
  screen.text(x .. ":" .. y)
  screen.level(math.random(1, 15))
  screen.move(math.random(0, 100), math.random(0, 100))
  screen.line(math.random(0, 100), math.random(0, 100), math.random(0, 100), math.random(0, 100))
  screen.stroke()
  screen.line(math.random(0, 100), math.random(0, 100), math.random(0, 100), math.random(0, 100))
  screen.stroke()
  screen.update()
end