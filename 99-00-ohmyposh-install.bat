@echo off

echo "Installing oh my posh"

powershell -Command "winget install JanDeDobbeleer.OhMyPosh -s winget;"

echo "Update oh my posh"

powershell -Command "winget upgrade JanDeDobbeleer.OhMyPosh -s winget;"

pause