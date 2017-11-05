
p_x = 20
p_dx = 0
p_y = 30
p_dy = 0

function _draw()
  map(0,0)
  spr(1,p_x,p_y)
  print(is_block_in_front_x(p_fx, p_y, p_dx), 1, 1, 0)
  print(is_block_in_front_y(p_x, p_fy, p_dy), 1, 8, 0)
end

function _update()
  p_dx = 0
  p_dy = 0

  if (btn(0)) p_dx = -2
  if (btn(1)) p_dx = 2
  if (btn(2)) p_dy = -2
  if (btn(3)) p_dy = 2

  p_fx = p_x + p_dx
  p_fy = p_y + p_dy

  if (not is_block_in_front_x(p_fx, p_y, p_dx)) p_x += p_dx
  if (not is_block_in_front_y(p_x, p_fy, p_dy)) p_y += p_dy
end

function is_block_in_front_x(x,y,dx)
  local colx = false
  if (dx < 0) colx = is_block(x, y) or is_block(x, y+7)
  if (dx > 0) colx = is_block(x+6, y) or is_block(x+6, y+7)
  return colx
end

function is_block_in_front_y(x,y,dy)
  local coly = false
  if (dy < 0) coly = is_block(x, y) or is_block(x+7, y)
  if (dy > 0) coly = is_block(x, y+6) or is_block(x+7, y+6)
  return coly
end

function is_block(x,y)
  return fget(mget(flr(x/8),flr(y/8)),0)
end