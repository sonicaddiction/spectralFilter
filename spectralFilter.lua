-- Spectral Filter
--
-- A set of 16 bandpassfilters
--
-- by: @sonicaddiction
--
-- Map a0-a15 to midi
-- ENC1 filter Q-value
-- ENC2 Volume
-- KEY2 encoder mode
-- KEY3 randomize filters

local viewport = { width = 128, height = 64, frame = 0 }

engine.name = "SpectralFilter"

-- Id's of individual filters
local filterIds = {'a0', 'a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9', 'a10', 'a11', 'a12', 'a13', 'a14', 'a15'}

-- Currently selected filter
local selected = 1

local filterChangingMode = false

function getRandom()
  return math.random(100)/100
end

function randomizeFilters()
  for x = 1, #filterIds do
    params:set(filterIds[x], getRandom())
  end
end

-- initialization
function init()
  print(filterIds[1])
  -- Main volume
  params:add_control("amp", "amp", controlspec.new(0.0, 1.0, 'lin', 0, 1.0, ''))
  params:set_action("amp", function(x) engine.amp(x); redraw(); end)
  -- Q-value of all filters, low value equals more resonance
  params:add_control("rq", "rq", controlspec.new(0.005, 1, 'lin', 0, 0.1, ''))
  params:set_action("rq", function(x) engine.rq(x); redraw(); end)
  -- Level of all individual filter
  params:add_control("a0", "a0", controlspec.new(0, 1, 'lin', 0, 1, ''))
  params:set_action("a0", function(x) engine.a0(x); redraw(); end)
  params:add_control("a1", "a1", controlspec.new(0, 1, 'lin', 0, 1, ''))
  params:set_action("a1", function(x) engine.a1(x); redraw(); end)
  params:add_control("a2", "a2", controlspec.new(0, 1, 'lin', 0, 1, ''))
  params:set_action("a2", function(x) engine.a2(x); redraw(); end)
  params:add_control("a3", "a3", controlspec.new(0, 1, 'lin', 0, 1, ''))
  params:set_action("a3", function(x) engine.a3(x); redraw(); end)
  params:add_control("a4", "a4", controlspec.new(0, 1, 'lin', 0, 1, ''))
  params:set_action("a4", function(x) engine.a4(x); redraw(); end)
  params:add_control("a5", "a5", controlspec.new(0, 1, 'lin', 0, 1, ''))
  params:set_action("a5", function(x) engine.a5(x); redraw(); end)
  params:add_control("a6", "a6", controlspec.new(0, 1, 'lin', 0, 1, ''))
  params:set_action("a6", function(x) engine.a6(x); redraw(); end)
  params:add_control("a7", "a7", controlspec.new(0, 1, 'lin', 0, 1, ''))
  params:set_action("a7", function(x) engine.a7(x); redraw(); end)
  params:add_control("a8", "a8", controlspec.new(0, 1, 'lin', 0, 1, ''))
  params:set_action("a8", function(x) engine.a8(x); redraw(); end)
  params:add_control("a9", "a9", controlspec.new(0, 1, 'lin', 0, 1, ''))
  params:set_action("a9", function(x) engine.a9(x); redraw(); end)
  params:add_control("a10", "a10", controlspec.new(0, 1, 'lin', 0, 1, ''))
  params:set_action("a10", function(x) engine.a10(x); redraw(); end)
  params:add_control("a11", "a11", controlspec.new(0, 1, 'lin', 0, 1, ''))
  params:set_action("a11", function(x) engine.a11(x); redraw(); end)
  params:add_control("a12", "a12", controlspec.new(0, 1, 'lin', 0, 1, ''))
  params:set_action("a12", function(x) engine.a12(x); redraw(); end)
  params:add_control("a13", "a13", controlspec.new(0, 1, 'lin', 0, 1, ''))
  params:set_action("a13", function(x) engine.a13(x); redraw(); end)
  params:add_control("a14", "a14", controlspec.new(0, 1, 'lin', 0, 1, ''))
  params:set_action("a14", function(x) engine.a14(x); redraw(); end)
  params:add_control("a15", "a15", controlspec.new(0, 1, 'lin', 0, 1, ''))
  params:set_action("a15", function(x) engine.a15(x); redraw(); end)
  
  params:bang()
  redraw()
end

function key(n,z)
  if n == 2 and z == 1 then
    filterChangingMode = not filterChangingMode
  end
  
  if n == 3 and z == 1 then
    randomizeFilters()
  end
  
  redraw()
end

-- encoder actions: n = number, d = delta
function enc(n,d)
  if filterChangingMode then
  	if n == 2 then
      selected = util.clamp(selected + d, 1, 16)
  	elseif n == 3 then
  	  params:delta(filterIds[selected], d)
  	end
  else
    if n == 2 then
      params:delta("rq", d)
  	elseif n == 3 then
  	  params:delta("amp", d)
  	end
  end
  redraw()
end

function redraw()
  -- Filter level bars
  local xGap = (viewport.width - 10) / 16
	screen.clear()
	
  for x = 1, #filterIds do
    local amp = params:get(filterIds[x])
    
    if x == selected and filterChangingMode then
      screen.line_width(2)
      screen.level(15)
    else
      screen.line_width(1)
      screen.level(1)
    end
    screen.move((x * xGap), 60)
    screen.line_rel(0, (amp * -30) - 1)
    
    screen.stroke()
	end

	-- Heading
	screen.level(5)
  screen.move(xGap,10)
  screen.text("Spectral Filter")

  if filterChangingMode then
    screen.level(10)
    screen.line_width(1)
    screen.move(xGap, 60)
    screen.line_rel((xGap*15) + 1, 0)
    screen.stroke()
  end

  -- Q and amp values
  if filterChangingMode then
    screen.level(1)
  else
    screen.level(15)
  end
	screen.move(xGap,20)
  screen.text("Q: " .. math.floor(params:get("rq") * 100))
	screen.move(70,20)
  screen.text("Amp: " .. math.floor(params:get("amp") * 100))
	screen.update()
end

-- deinitialization
function cleanup()
end