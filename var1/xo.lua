local gameboard = { 1, 2, 2,
                    1, 1, 2,
                    1, 2, 1 }

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

local function game_status(board)
  -- оценка доски и кто выиграл 

  


end

local function ai_low( ... )
  -- body
end

local function ai_high( ... )
  -- body
end

local function tic_tac_toe()
  -- основной цикл игры
  -- 1 - это крест
  -- 2 - это ноль
  -- -1 - это пустое поле

  local count = 9

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

  local game_i = true  
  while game_i do

    game_i = who_win()
  end
end

print_geameboard(gameboard)
tic_tac_toe()

