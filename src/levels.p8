function load_levels()
  local levels_list = {}

  local level_1 = {
    id = 1,
    map_offset = {x = 0, y = 0}, 
    spawns = {7, 8},
    max_score = 10,
    starting_point = {x = 40, y = 60}
  }

  local level_2 = {
    id = 2,
    map_offset = {x = 1, y = 0},
    spawns = {17, 30},
    max_score = 15,
    starting_point = {x = 168, y = 60}
  }

  add(levels_list, level_1)
  add(levels_list, level_2)
  
  return levels_list
end