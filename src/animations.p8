
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