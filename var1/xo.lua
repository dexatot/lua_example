local gameboard = { -1, -1, -1,
                    -1, -1, -1,
                    -1, -1, -1 }

local function print_geameboard(gameboard)
  -- функция печати игровой доски
  
  local function switch(i)
    -- определяет что на доске
    if i == 1 then return "X" end
    if i == 2 then return "O" end
    if i == -1 then return "." end 
  end

  for i=1,9,3 do    
    print(switch(gameboard[i]), 
          switch(gameboard[i+1]),
          switch(gameboard[i+2]))
    i = i + 3
  end
end

local function fin(n)
  -- пусть пока будет
  for i=n,9 do    
    if gameboard[i] == "x" then
      print("find x", n)
      return fin(i + 1)
    elseif gameboard[i] == "o" then
      print("find o", n)      
      return fin(i + 1)
    elseif gameboard[i] == "." then
      print("find .", n) 
      return fin(i + 1)
    end
  end  
end

local function ai_low( ... )
  -- body
end

local function ai_high( ... )
  -- body
end

local function ai_game( ... )
  -- body
end

local function pvp_or_ai()
  print("1 - PvP")
  print("2 - AI low")
  print("3 - AI high")
  local who = io.read()
end

local function pvp_game(gameboard, player)
  if player == 1 then
    io.write("X> ") 
    return io.read()
  elseif player == 0 then    
    io.write("O> ")
    return io.read()
  end  
end

local function tic_tac_toe()
  -- основной цикл игры
  -- 1 - это крест
  -- 2 - это ноль
  -- -1 - это пустое поле

  -- TODO fix count and end game
  local count = 1
  local game_i = true

  local function is_winner(gameboard, player)
    -- вычисляет player выиграл или нет
    local win = player * 3
    if gameboard[1] + gameboard[5] + gameboard[9] == win or
       gameboard[3] + gameboard[5] + gameboard[7] == win then 
      return true 
    end
    for i = 1,3 do
      local j = i * 3
      if gameboard[i] + gameboard[i+3] + gameboard[i+6] == win or
         gameboard[j-2] + gameboard[j-1] + gameboard[j] == win then 
        return true 
      end
    end
    return false
  end

  local function who_win()
    -- кто выиграл
    if is_winner(gameboard, 1) == true then
      print("Player X WINNNERS! :)")
      return false
    elseif is_winner(gameboard, 2) == true then
      print("Player O WINNNERS! :)")
      return false
    elseif count == 9 then
      print("standoff :(")
      return false
    end
    return true
  end
  
  while game_i do    
    print_geameboard(gameboard)    
    
    local player = count % 2
    local position = tonumber(pvp_game(gameboard, player))    
    
    if player == 0 then
      gameboard[position] = 2
    else
      gameboard[position] = 1
    end
    
    game_i = who_win()
    count = count + 1 
  end
end


tic_tac_toe()
print_geameboard(gameboard)