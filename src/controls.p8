
function vertical_controls(p)
  if btnp(2) and not p.jumping and not p.falling then
    p.dy = p.jump_initial_speed
    p.jumping = true
    p.mvt_v = -1
    sfx(2)
  end 
  
  v_col = box_collide_v(p)

  if (p.y % 8 != 0) and v_col then
    if(p.mvt_v == -1) p.y -= (p.y % 8)
    if(p.mvt_v == 1) p.y += 8 - (p.y % 8)
  end

  if (not (v_col)) then
    p.y += p.dy
    p.falling = true
  end

  if (is_on_a_solid_block(p)) then
    p.falling = false 
    p.jumping = false
    p.dy = 0
    p.mvt_v = 0
  end
  if (is_below_a_solid_block(p)) then
    p.dy = 1
  end
end

function horizontal_controls(p)
  p.dx = 0

  if(btn(0)) then
    p.dx = -p.h_speed
    p.mvt_h = -1
    p.facing = 0
  end
  if (btn(1)) then
    p.dx = p.h_speed
    p.mvt_h = 1
    p.facing = 1
  end

  h_col = box_collide_h(p)
  
  if (p.x % 8 != 0) and h_col then
    if(p.mvt_h == 1) p.x += 8 - (p.x % 8)
    if(p.mvt_h == -1) p.x -= (p.x % 8)
  end

  if h_col then
    p.base_anim.f = p.base_anim.fix
  else
    if no_horizontal_input() then
      p.base_anim.f = p.base_anim.fix
    else
      p.x += p.dx
      anim(p.base_anim, 0.35)
    end
  end
end

function no_horizontal_input()
  return not (btn(0) or btn(1))
end