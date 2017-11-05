
function check_collision(blocks_to_check, e)
  local collide = true
  local solid = false

  for b in all(blocks_to_check) do
    r1 = sp_to_rect(e)
    r2 = sp_to_rect(b)
    if(r1.x1 > r2.x2) or 
      (r2.x1 > r1.x2) or 
      (r1.y1 > r2.y2) or 
      (r2.y1 > r1.y2) then
      collide = false
    end
  end
  for b in all(blocks_to_check) do
    solid = b.solid
    if (solid) break
  end
  return collide and solid
end

function box_collide_v(e)
  blocks_to_check_v = {}
  local futur_e_v = copy_table(e)
  futur_e_v.y += futur_e_v.dy

  if (futur_e_v.mvt_v == -1) blocks_to_check_v = blocks_top(futur_e_v, blocks_to_check_v)
  if (futur_e_v.mvt_v == 1)  blocks_to_check_v = blocks_below(futur_e_v, blocks_to_check_v)
  return check_collision(blocks_to_check_v, futur_e_v)
end

function box_collide_h(e)
  blocks_to_check_h = {}
  local futur_e_h = copy_table(e)
  futur_e_h.x += futur_e_h.dx

  if (futur_e_h.mvt_h == 1)  blocks_to_check_h = blocks_front(futur_e_h, blocks_to_check_h)
  if (futur_e_h.mvt_h == -1) blocks_to_check_h = blocks_back(futur_e_h, blocks_to_check_h)
  return check_collision(blocks_to_check_h, futur_e_h)
end

-- blocs to check for a collision detection
function block(px, py)
  local sprite = mget(flr((px)/8),flr(py/8))
  return {
    x = flr(px / 8) * 8,
    y = flr(py / 8) * 8,
    w = 8,
    h = 8,
    sp = sprite,
    solid = fget(sprite, 0)
  }
end

function blocks_front(e, blocks_to_check)
  add(blocks_to_check, block(e.x + e.w, e.y))
  if ((e.y % e.h) != 0) add (blocks_to_check, block(e.x + e.w, e.y + e.h))
  return blocks_to_check
end

function blocks_back(e, blocks_to_check)
  add(blocks_to_check, block(e.x, e.y))
  if ((e.y % e.h) != 0) add (blocks_to_check, block(e.x, e.y + e.h))
  return blocks_to_check
end

function blocks_top(e, blocks_to_check)
  add(blocks_to_check, block(e.x, e.y))
  if ((e.x % e.w) != 0) add (blocks_to_check, block(e.x + e.w, e.y))
  return blocks_to_check
end

function blocks_below(e, blocks_to_check)
  add(blocks_to_check, block(e.x, e.y + e.h))
  if ((e.x % e.w) != 0) add (blocks_to_check, block(e.x + e.w, e.y + e.h))
  return blocks_to_check
end