function load_levels()
  local levels_list = {}

  local level_1 = {
    id = 1,
    map_offset = {x = 0, y = 0}, 
    spawns = {7, 8},
    max_score = 1,
    starting_point = {x = 40, y = 60}
  }

  local level_2 = {
    id = 2,
    map_offset = {x = 1, y = 0},
    spawns = {18, 29},
    max_score = 15,
    starting_point = {x = 168, y = 60}
  }

  add(levels_list, level_1)
  add(levels_list, level_2)
  
  return levels_list
end

function next_level()
  current_level = levels[current_level.id+1]
  entities = {}
  shots = {}
  p.x = current_level.starting_point.x
  p.y = current_level.starting_point.y
  load_entities(entities, current_level.map_offset)
end
