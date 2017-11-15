function load_levels()
  local levels_list = {}

  local level_1 = {
    map_offset = 0, 
    spawns = {7, 8},
    max_score = 50
  }

  local level_2 = {
    map_offset = 1,
    spawns = {3, 11},
    max_score = 100
  }

  add(levels_list, level_1)
  add(levels_list, level_2)
  
  return levels_list
end