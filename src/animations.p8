
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

function draw_entities(p, entities)
  spr(p.base_anim.f, p.x, p.y, 1, 1, (p.facing == 0))

  for e in all(entities) do
    if (e.entity_type == 'torch') then
      spr(e.base_anim.f, e.x, e.y, 2, 2)
    elseif (e.entity_type == 'torch_small') then
      spr(e.base_anim.f, e.x, e.y, 1, 1)
    elseif e.entity_type == 'bad' then
      spr(e.base_anim.f, e.x, e.y, 1, 1, (e.facing == 0))
    end
  end
end

function draw_shots(shots)
  for s in all(shots) do
    if s.entity_type == 'shot' then
      spr(s.base_anim.f, s.x, s.y, 1, 1)
    end
  end
end

function draw_life(p)
  local nb_full = p.life / 2
  local nb_half = p.life % 2
  local nb_empty = (10 - p.life) / 2
  local heart_offset = 0
  local offset_x = (current_level.map_offset.x)*128

  for j=0, nb_full-1, 1 do
    if(p.shield > 0) then
      spr(6, 88 + offset_x + 7*heart_offset, 120)
    else
      spr(22, 88 + offset_x + 7*heart_offset, 120)
    end
    heart_offset += 1
  end
  for j=0, nb_half-1, 1 do
    if(p.shield > 0) then
      spr(7, 88 + offset_x + 7*heart_offset, 120)
    else
      spr(23, 88 + offset_x + 7*heart_offset, 120)
    end
    heart_offset += 1
  end
  for j=0, nb_empty-1, 1 do
    spr(24, 88 + offset_x + 7*heart_offset, 120)
    heart_offset += 1
  end
end