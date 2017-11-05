
function print_debug()
  if ((counter % 5) == 0) then
    cpu = (stat(1) * 100)
    ram = stat(0)
  end
  print('cpu: '..(cpu or 0)..'%', 0, 1, 0)  
  print('ram: '..(ram or 0)..'/1024', 0, 8, 0)
  print(count(entities), 0, 15, 0)
  print(p.falling, 0, 22,0)
end

function sp_to_rect(e)
  local r = {}
    r.x1 = e.x
    r.y1 = e.y
    r.x2 = e.x + e.w - 1
    r.y2 = e.y + e.h - 1
  return r
end

function copy_table(from)
  local copy = {}
  for k,v in pairs(from) do copy[k] = v end
  return copy
end
