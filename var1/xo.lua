-- 1 - это крест
-- 2 - это ноль
-- -1 - это пустое поле
local gameboard = { -5,-5,-5,-5,-5,-5,-5,-5,-5 }

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

local function standoff(gameboard)
  -- определение пустых полей и если нет ничья
  for i=1,9 do
    if gameboard[i] == -5 then
      return false      
    end
  end
  return true
end

local function print_geameboard(gameboard)
  -- функция печати игровой доски
  
  local function switch(i)
    -- определяет что на доске
    if i == 1 then return "X" end
    if i == 2 then return "O" end
    if i == -5 then return "." end 
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

local function pvp_or_ai()
  print("1 - PvP")
  print("2 - AI")
  local who = io.read()
  if who == "1" then 
    return true
  else
    return false
  end
end

local function ai_game(gameboard, player)

  if player == 1 then
    io.write("X> ") 
    return io.read()
  elseif player == 0 then    

    local best_score = -2
    local score = -2
    local best_position = 1
    local position = 1
    local winner    

    for i=1,9,3 do
      for j=0,2 do

        position = i+j        

        if gameboard[i+j] == -5 then        

          local cp_gameboard_1 = {}
          local cp_gameboard_2 = {}        
          for k,v in pairs(gameboard) do
            cp_gameboard_1[k] = v
            cp_gameboard_2[k] = v
          end

          cp_gameboard_2[position] = 2
          if is_winner(cp_gameboard_2, 2) then  
            print("if position = ", position)                          
            return position
          end
          
          cp_gameboard_1[position] = 1
          if is_winner(cp_gameboard_1, 1) == true then            
            return position
          elseif best_position <= position then            
            best_position = position
          end

        end

      end
    end

    print("best_position = ", best_position)
    return best_position

  end
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

local function free_sector(gb, i)
  if gb[i] == -5 or i < 9 then 
    return true
  else
    return false
  end
end

local function tic_tac_toe(who)
  -- основной цикл игры  
  
  local count = 1
  local game_i = true

  local function who_win()
    -- кто выиграл
    if is_winner(gameboard, 1) == true then
      print("Player X WINNNERS! :)")
      return false
    elseif is_winner(gameboard, 2) == true then
      print("Player O WINNNERS! :)")
      return false
    elseif standoff(gameboard) then
      print("standoff :(")
      return false
    end
    return true
  end
  
  while game_i do  

    game_i = who_win()
    if game_i == false then return end

    print_geameboard(gameboard)    
    
    local player = count % 2
    local position = 0
    local go_current = true

    -- нужно для проверки поля и не выходит ли за границы массива
    while go_current do

      if who == true then
        position = tonumber(pvp_game(gameboard, player))    
        if free_sector(gameboard, position) == true then
          go_current = false
        end
      else
        position = tonumber(ai_game(gameboard, player))    
        go_current = false
      end

    end

    if player == 0 then
      gameboard[position] = 2
    else
      gameboard[position] = 1
    end
    
    count = count + 1 
  end
end

tic_tac_toe(pvp_or_ai())
print_geameboard(gameboard)
