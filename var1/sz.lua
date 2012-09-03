local root_table = {"1234", a = 1, b = 2, c = 3, d = 4, e = 5, true}
local child_a_table = {ss = 11, dd = 22, ff = 33, 99}
local child_b_table = {"n","v"}
local child_e_table = {11322, jj = nil, 32}

function table.serial(t)
  -- сереализация таблицы в строку   

  local temp_table = {}   -- таблица результата работы функции
  local solve_table = {}  -- таблица для хранения значений отсеянных ipairs 
  
  local function key_to_string(k)   
    return tostring(k)    
  end

  local function value_to_string(v)
    -- рекурсивная функция для обработки данных значений
    if type(v) == "table" then
      return table.serial(v)
    elseif type(v) == "string" then      
      return "\"" .. v .. "\""
    else
      return key_to_string(v)
    end
  end  

  -- выбираем все значения и записываем их в solve_table чтобы не перебирать заново
  for _,k in ipairs(t) do 
    table.insert(temp_table, value_to_string(k))    
    solve_table[k] = true
  end

  -- проходим по всей таблице исключая условием уже пройденные значения
  for k,v in pairs(t) do     
    if solve_table[v] ~= true then
      if type(k) == "table" then
        table.insert(temp_table, value_to_string(k) .. "=" .. value_to_string(v))
      else
        table.insert(temp_table, key_to_string(k) .. "=" .. value_to_string(v))
      end
    end    
  end
  
  return "{" .. table.concat(temp_table, ",") .. "}"

end

root_table["a"] = child_a_table 
root_table["b"] = child_b_table 
root_table["e"] = child_e_table
root_table[{k = 1, 5}] = "sd"
-- root_table["gg"] = root_table -- ссылка на саму себя это что-то типа такого?
 
print(table.serial(root_table))