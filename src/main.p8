function _init()
  counter = 0
  score = 0

  entities = {}
  shots = {}
  
  levels = load_levels()
  current_level = levels[1]

  p = init_entity(current_level.starting_point.x, current_level.starting_point.y, 2, 16, 5, 'player', 'stupid', 10, 1)
  load_entities(entities, current_level.map_offset)
end

function _draw()
  cls()
  map(0,0,0,0,128,16)

  camera((current_level.map_offset.x)*128,(current_level.map_offset.y)*128)
  
  draw_entities(p, entities)
  draw_shots(shots)

  draw_life(p)
  print_score(score, current_level.max_score)
  print_debug()
end

function _update()
  local map_offset = levels[current_level.id].map_offset.x
  local spawn_tab = levels[current_level.id].spawns
  counter += 1

  if (score >= current_level.max_score) next_level()
  if (p.shield > 0) p.shield -= 1

  load_ennemies(loaded_map(p, map_offset), entities, spawn_tab)

  update_gravity(p)
  update_from_controls(p)

  for e in all(entities) do
    update_entity(e)
  end

  for s in all(shots) do
    if s.ai == 'simple' then
      update_shot_simple(s)
    end
    for e in all(entities) do
      update_collision_shot_entity(s, e)
    end
  end
end
