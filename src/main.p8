function _init()
  counter = 0
  entities = {}
  level = 0

  p = init_entity(60, 40, 2, 16, 6, 'player', 'stupid', 7)
  load_entities(entities)
end

function _draw()
  cls()
  map(0,0,0,0,16,16)

  for e in all(entities) do
    if (e.entity_type == 'torch') then
      spr(e.base_anim.f, e.x, e.y, 2, 2)
    elseif (e.entity_type == 'torch_small') then
      spr(e.base_anim.f, e.x, e.y, 1, 1)
    elseif e.entity_type == 'bad' then
      spr(e.base_anim.f, e.x, e.y, 1, 1, (e.facing == 0))
    end
  end
  spr(p.base_anim.f, p.x, p.y, 1, 1, (p.facing == 0))
  draw_life(p)

  print_debug()
end

function _update()
  counter += 1
  if (p.shield > 0) p.shield -= 1

  load_ennemies(loaded_map(p, level), entities)

  update_gravity(p)
  update_from_controls(p)
  
  for e in all(entities) do
    if e.entity_type == 'bad' then
      update_gravity(e)
      if e.ai == 'endless' then
        walk_endless(e)
      end
      if is_below_map(e) then
        e.x = 60
        e.y = 0
        if (e.h_speed <= 6) e.h_speed = e.h_speed + 1
        e.mvt_h = 0
      end
      if entity_collision(e, p) and (p.shield == 0) then
        p.life -= 1
        p.shield = 60
      end
    elseif e.entity_type == 'torch' then
      update_anim_torch(e, 2)
    elseif e.entity_type == 'torch_small' then
      update_anim_torch(e, 1)
    end
  end
end
