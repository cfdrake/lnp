-- t>w>o>c>a>n
--
-- ENC1 engine
-- ENC2 timbre
-- ENC3 chaos
--
-- KEY2 prev scale
-- KEY3 next scale

hs = require "awake/lib/halfsecond"

engine.name = "TwoCan"

function init()
  print("twocan")
  
  hs.init()
  
  scales = {80, 20, 133}
  scale_names = {"nor", "lo", "hi"}
  scale = 1
  synth = 0
  max_vol = 0.1
  timbre = 0
  chaos = 0
  
  for i=1,16 do
    engine.amp(i, 0)
    engine.amp_lag(i, 3 + (math.random() * 2))
    engine.chaos(i, chaos)
    engine.freq(i, 100 + (i * 80))
    engine.pan(i, (math.random() * 0.5) - 0.25)
    engine.synth(i, synth)
    engine.timbre(i, timbre)
  end
  
  m = midi.connect()
  m.event = function(data)
    local d = midi.to_msg(data)
    
    if d.type == "note_on" then
      index = d.note % 16
      engine.amp(index + 1, max_vol)
    elseif d.type == "note_off" then
      index = d.note % 16
      engine.amp(index + 1, 0)
    end
  end
end

function enc(n, d)
  if n == 1 then
    if d > 0 then
      synth = util.clamp(synth + 1, 0, 2)
    else
      synth = util.clamp(synth - 1, 0, 2)
    end
    
    for i=1,16 do
      engine.synth(i, synth)
    end
  elseif n == 2 then
    timbre = util.clamp(timbre + (d * 0.01), 0, 4)
    for i=1,16 do
      engine.timbre(i, timbre)
    end
  elseif n == 3 then
    chaos = util.clamp(chaos + d, 0, 500)
    for i=1,16 do
      engine.chaos(i, chaos)
    end
  end
  
  redraw()
end

function key(n, z)
  if n == 2 and z == 1 then
    scale = util.clamp(scale - 1, 1, #scales)
    
    for i=1,16 do
      engine.freq(i, 100 + (i * scales[scale]))
    end
  elseif n == 3 and z == 1 then
    scale = util.clamp(scale + 1, 1, #scales)
    
    for i=1,16 do
      engine.freq(i, 100 + (i * scales[scale]))
    end
  end
  
  redraw()
end

function redraw()
  screen.clear()
  screen.font_size(15)
  screen.font_face(3)
  screen.move(1, 15)
  screen.level(5)
  screen.text("eng: ")
  screen.level(15)
  if synth == 0 then
    screen.text("tri")
  elseif synth == 1 then
    screen.text("pulse")
  elseif synth == 2 then
    screen.text("sinfb")
  end
  screen.move(1, 30)
  screen.level(5)
  screen.text("timbre: ")
  screen.level(15)
  screen.text(timbre)
  screen.move(1, 45)
  screen.level(5)
  screen.text("chaos: ")
  screen.level(15)
  screen.text(chaos)
  screen.update()
  screen.move(1, 60)
  screen.level(5)
  screen.text("scale: ")
  screen.level(15)
  screen.text(scale_names[scale])
  screen.update()
end