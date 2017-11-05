
function walk_endless(e)
  walk_x(e)
  move_y(e)
end

function walk_x(e)
  e.dx = 0
  if e.facing == 1 then
    e.dx = e.h_speed
    e.mvt_h = 1
  else
    e.dx = -e.h_speed
    e.mvt_h = -1
  end

  h_col = box_collide_h(e)
  
  if (e.x % 8 != 0) and h_col then
    if(e.mvt_h == 1) e.x += 8 - (e.x % 8)
    if(e.mvt_h == -1) e.x -= (e.x % 8)
  end

  if h_col then
    if(e.facing == 1) then
      e.facing = 0
    elseif(e.facing == 0) then
      e.facing = 1
    end
  else
    e.x += e.dx
    anim(e.base_anim, 0.2)
  end
end

function move_y(e)
  v_col = box_collide_v(e)

  if (e.y % 8 != 0) and v_col then
    if(e.mvt_v == -1) e.y -= (e.y % 8)
    if(e.mvt_v == 1) e.y += 8 - (e.y % 8)
  end

  if (not (v_col)) e.y += e.dy

  if (is_on_a_solid_block(e)) then 
    e.jumping = false
    e.dy = 0
    e.mvt_v = 0
  end
  if (is_below_a_solid_block(e)) then
    e.dy = 1
  end
end

function update_shot_simple(s)
  s.dx = 0
  if s.facing == 1 then
    s.dx = s.h_speed
    s.mvt_h = 1
  else
    s.dx = -s.h_speed
    s.mvt_h = -1
  end

  h_col = box_collide_h(s)
  
  if (s.x % 8 != 0) and h_col then
    if(s.mvt_h == 1) s.x += 8 - (s.x % 8)
    if(s.mvt_h == -1) s.x -= (s.x % 8)
  end

  if h_col then
    del(shots, s)
  else
    s.x += s.dx
  end
end