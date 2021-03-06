function update_entity(e)
  if e.entity_type == 'bad' then
    update_gravity(e)
    if e.ai == 'endless' then
      walk_endless(e)
    end
    if is_below_map(e) then
      e.x = get_random_tile_from_table(current_level.spawns) * 8
      e.y = 0
      if (e.h_speed <= 6) e.h_speed = e.h_speed + 1
      e.mvt_h = 0
    end
    if entity_collision(e, p) and (p.shield == 0) and (p.life > 0) then
      p.life -= 1
      p.shield = 30
      sfx(0)
    end
  elseif e.entity_type == 'torch' then
    update_anim_torch(e, 2)
  elseif e.entity_type == 'torch_small' then
    update_anim_torch(e, 1)
  end
end

function update_collision_shot_entity(s, e)
  if e.entity_type == 'bad' then
    if shot_collision(s, e) then
      e.life -= 1
      if(e.life == 0) then
        score += e.h_speed 
        del(entities, e)
      end
      del(shots, s)
    end
  end
end

function load_entities(entities, map_offset)
  local x1 = map_offset.x * 15
  local x2 = (map_offset.x * 15) + 15
  local y1 = map_offset.y * 15
  local y2 = (map_offset.y * 15) + 15

  for xi = x1, x2, 1 do
    for yi = y1, y2, 1 do
      if(mget(xi, yi) == 137) then
        add(entities, init_entity(xi*8, yi*8, 0, 74, 2,'torch','dumb', 0))
        mset(xi, yi, 80)
      elseif(mget(xi, yi) == 136) then
        add(entities, init_entity(xi*8, yi*8, 0, 124, 1,'torch_small','dumb', 0))
        mset(xi, yi, 80)
      end
    end
  end
end

function load_ennemies(loaded_map, entities, spawns)
  local random = rnd(1)
  local facing = 0

  if (random > 0.5) facing = 1
  
  create_random_entities(spawns)
  for xi = loaded_map.x1, loaded_map.x2, 1 do
    for yi = loaded_map.y1, loaded_map.y2, 1 do
      if(mget(xi, yi) == 128) then
        -- classic zombie
        add(entities, init_entity(xi*8, yi*8, 1, 48, 4,'bad','endless', 1, facing))
        mset(xi, yi, 80)
      elseif(mget(xi, yi) == 129) then
        -- snake
        add(entities, init_entity(xi*8, yi*8, 2, 32, 4,'bad','endless', 1, facing))
        mset(xi, yi, 80)
      elseif(mget(xi, yi) == 130) then
        -- mimic
        add(entities, init_entity(xi*8, yi*8, 1, 36, 4,'bad','endless', 1, facing))
        mset(xi, yi, 80)
      elseif(mget(xi, yi) == 131) then
        -- small zombie
        add(entities, init_entity(xi*8, yi*8, 2, 52, 4,'bad','endless', 1, facing))
        mset(xi, yi, 80)
      elseif(mget(xi, yi) == 132) then
        -- yeti
        add(entities, init_entity(xi*8, yi*8, 1, 40, 4,'bad','endless', 1, facing))
        mset(xi, yi, 80)
      end
    end
  end
end

function create_random_entities(spawns)
  local tile = get_random_tile_from_table(spawns)

  if(counter % 100 == 0)then
    ennemy = 128 + flr(rnd(5))
    mset(tile,0,ennemy)
    sfx(1)
  end
end

function get_random_tile_from_table(table)
  return table[flr(rnd(count(table))+1)]
end

function init_entity(start_x, start_y, speed, start_sprite, length_sprites, t, ai, life, facing)
  return {
    ai = ai,
    entity_type = t,
    x = start_x, 
    y = start_y,
    dx = 0, dy = 0,
    w = 8, h = 8,
    mvt_h = 0,
    mvt_v = 0,
    facing = facing,
    v_speed = 4,
    h_speed = speed,
    jumping = false,
    falling = true,
    jump_initial_speed = -7,
    gravity = 1,
    life = life,
    shield = 0,
    shot_timer = 0,
    base_anim={f=start_sprite, st=start_sprite, sz=start_sprite+length_sprites, fix=start_sprite}
  }
end

function update_gravity(e)
  if (e.dy < e.v_speed) then
    e.dy += e.gravity
  else
    e.dy = e.v_speed
  end
  if e.dy < 0 then
    e.mvt_v = -1
  else
    e.mvt_v = 1
  end
end

function update_from_controls(p)
  horizontal_controls(p)
  vertical_controls(p)
  shot_control(p)
end

function is_on_a_solid_block(e)
  return get_block_below(e, 0)
end

function is_below_a_solid_block(e)
  return get_block_on_top(e, 0)
end

function is_in_front_of_a_block(e)
  return get_block_in_front(e, 0)
end

function is_below_map(e)
  return e.y > 128
end