function load_entities(entities)
  for xi = 0, 15, 1 do
    for yi = 0, 15, 1 do
      if(mget(xi, yi) == 137) then
        add(entities, init_entity(xi*8, yi*8, 0, 74, 2,'torch','dumb'))
        mset(xi, yi, 80)
      elseif(mget(xi, yi) == 136) then
        add(entities, init_entity(xi*8, yi*8, 0, 124, 1,'torch_small','dumb'))
        mset(xi, yi, 80)
      end
    end
  end
end

function load_ennemies(loaded_map, entities)
  create_random_entities()
  for xi = loaded_map.x1, loaded_map.x2, 1 do
    for yi = loaded_map.y1, loaded_map.y2, 1 do
      if(mget(xi, yi) == 128) then
        -- classic zombie
        add(entities, init_entity(xi*8, yi*8, 1, 48, 4,'bad','endless', 2))
        mset(xi, yi, 80)
      elseif(mget(xi, yi) == 129) then
        -- snake
        add(entities, init_entity(xi*8, yi*8, 2, 32, 4,'bad','endless', 1))
        mset(xi, yi, 80)
      elseif(mget(xi, yi) == 130) then
        -- mimic
        add(entities, init_entity(xi*8, yi*8, 1, 37, 4,'bad','endless', 3))
        mset(xi, yi, 80)
      elseif(mget(xi, yi) == 131) then
        -- small zombie
        add(entities, init_entity(xi*8, yi*8, 2, 53, 4,'bad','endless', 1))
        mset(xi, yi, 80)
      end
    end
  end
end

function create_random_entities()
  if(counter % 100 == 0)then
    ennemy = 128 + rnd(4)
    mset(7,0,ennemy)
    sfx(1)
  end
end

function init_entity(start_x, start_y, speed, start_sprite, length_sprites, t, ai, life)
  return {
    ai = ai,
    entity_type = t,
    x = start_x, 
    y = start_y,
    dx = 0, dy = 0,
    w = 8, h = 8,
    mvt_h = 0,
    mvt_v = 0,
    facing = 1,
    v_speed = 4,
    h_speed = speed,
    jumping = false,
    falling = true,
    jump_initial_speed = -7,
    gravity = 1,
    life = life,
    shield = 0,
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