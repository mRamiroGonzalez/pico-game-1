
function anim(a, i)
  a.f += i
  if a.f > a.sz then
    a.f = a.st
  end
end

function update_anim_torch(torch, size)

  if (counter % 30 == 0) then 
    anim(torch.base_anim, size)
  end
end

function print_score(score, score_max)
  local offset_x = (current_level.map_offset.x)*128
  print(score..'/'..score_max, 1 + offset_x, 122, 11)
end

function draw_life(p)
  local nb_full = p.life / 2
  local nb_half = p.life % 2
  local nb_empty = (10 - p.life) / 2
  local heart_offset = 0
  local offset_x = (current_level.map_offset.x)*128

  for j=0, nb_full-1, 1 do
    if(p.shield > 0) then
      spr(6, 80 + offset_x + 8*heart_offset, 0)
    else
      spr(22, 80 + offset_x + 8*heart_offset, 0)
    end
    heart_offset += 1
  end
  for j=0, nb_half-1, 1 do
    if(p.shield > 0) then
      spr(7, 80 + offset_x + 8*heart_offset, 0)
    else
      spr(23, 80 + offset_x + 8*heart_offset, 0)
    end
    heart_offset += 1
  end
  for j=0, nb_empty-1, 1 do
    spr(24, 80 + offset_x + 8*heart_offset, 0)
    heart_offset += 1
  end
end