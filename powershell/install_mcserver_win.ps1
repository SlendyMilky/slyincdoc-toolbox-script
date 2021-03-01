# Script d'installation automatisé d'un serveur mc vanilla
# Slendy_Milky 
# 02.03.2021
# V1.1
# Attention ce script doit être lancé uniquement sur une machine fraichement installée.

$webclient = New-Object System.Net.WebClient
$minecraftServerPath = $env:USERPROFILE + "\Desktop\minecraft_server\"

# Install Chocolatey
(iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')))>$null 2>&1


# Install Java with chocolatey
choco install -y -force javaruntime

# reload PATH
$env:PATH = [System.Environment]::GetEnvironmentVariable("PATH","Machine")
$javaCommand = get-command java.exe
$javaPath = $javaCommand.Name
$jarPath = $minecraftServerPath + $minecraftJar

# download Minecraft server
md $minecraftServerPath
$url = "https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar"
$webclient.DownloadFile($url,$jarPath)

# launch Minecraft server for first time
cd $minecraftServerPath

md logs
echo $null > server.properties
out-file -filepath .\banned-ips.json -encoding ascii -inputobject "[]`n"
out-file -filepath .\banned-players.json -encoding ascii -inputobject "[]`n"
out-file -filepath .\ops.json -encoding ascii -inputobject "[]`n"
out-file -filepath .\usercache.json -encoding ascii -inputobject "[]`n"
out-file -filepath .\whitelist.json -encoding ascii -inputobject "[]`n"
out-file -filepath .\eula.txt -encoding ascii -inputobject "eula=true`n"
iex "$javaPath -Xmx2048M -jar $jarPath nogui"