serpent = dofile("./File_Libs/serpent.lua")
https = require("ssl.https")
http = require("socket.http")
JSON = dofile("./File_Libs/JSON.lua")
local database = dofile("./File_Libs/redis.lua").connect("127.0.0.1", 6379)
Server_Friends = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local AutoFiles_Friends = function() 
local Create_Info = function(Token,Sudo,UserName)  
local Friends_Info_Sudo = io.open("sudo.lua", 'w')
Friends_Info_Sudo:write([[
token = "]]..Token..[["
Sudo = ]]..Sudo..[[  
]])
Friends_Info_Sudo:close()
end  
if not database:get(Server_Friends.."Token_Friends") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m')
database:set(Server_Friends.."Token_Friends",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
if not database:get(Server_Friends.."Id_Friends") then
print("\27[1;34m\n»» Send Your id Sudo : \27[m")
local UserName = io.read():gsub('@','')
if UserName ~= '' then
io.write('\n\27[1;31m»» The id Is Saved\n\27[0;39;49m')
database:set(Server_Friends.."Id_Friends",UserName)
else
io.write('\n\27[1;31mThe id was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
local function Files_Friends_Info()
Create_Info(database:get(Server_Friends.."Token_Friends"),database:get(Server_Friends.."Id_Friends"),database:get(Server_Friends.."UserName_Friends"))   
local RunFriends = io.open("Friends", 'w')
RunFriends:write([[
#!/usr/bin/env bash
cd $HOME/Friends
token="]]..database:get(Server_Friends.."Token_Friends")..[["
rm -fr Friends.lua
wget "https://raw.githubusercontent.com/teamFriends/Friends/master/Friends.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./Friends.lua -p PROFILE --bot=$token
done
]])
RunFriends:close()
local RunTs = io.open("tk", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/Friends
while(true) do
rm -fr ../.telegram-cli
screen -S Friends -X kill
screen -S Friends ./Friends
done
]])
RunTs:close()
end
Files_Friends_Info()
database:del(Server_Friends.."Token_Friends");database:del(Server_Friends.."Id_Friends");database:del(Server_Friends.."UserName_Friends")
sudos = dofile('sudo.lua')
os.execute('./ins.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_Friends()  
var = true
else   
f:close()  
database:del(Server_Friends.."Token_Friends");database:del(Server_Friends.."Id_Friends");database:del(Server_Friends.."UserName_Friends")
sudos = dofile('sudo.lua')
os.execute('./ins.sh ins')
var = false
end  
return var
end
Load_File()