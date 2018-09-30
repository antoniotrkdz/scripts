input = assert (io.popen("ls"))
pwd = io.popen("pwd"):read("*l")
tbl = {}
output = assert (io.open("background-lua.xml", "a"))

output:write([[
<background>
        <starttime>
                <year>2009</year>
                <month>08</month>
                <day>04</day>
                <hour>00</hour>
                <minute>00</minute>
                <second>00</second>
        </starttime>
]])

for line in input:lines() do
  if (string.sub(line, -3) == "jpg") then
    local part1 = "\t\t<to>"..pwd.."/"..line.."</to>\n"..
      "\t</transition>\n"
    local part2 = "\t<static>\n"..
      "\t\t<duration>595.0</duration>\n"..
      "\t\t<file>"..pwd.."/"..line.."</file>\n"..
      "\t</static>\n"..
      "\t<transition>\n"..
      "\t\t<duration>5.0</duration>\n"..
      "\t\t<from>"..pwd.."/"..line.."</from>\n"

    table.insert(tbl, part1)
    table.insert(tbl, part2)
    end -- if
  end -- for loop

table.insert(tbl, table.remove(tbl, 1))
tbl = table.concat(tbl, "")
output:write(tbl)

output:write("</background>")

input:close()
output:close()
