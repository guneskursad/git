@echo off

echo "Installing font"

powershell -Command "oh-my-posh font install;"

echo "Set execution policy... "

powershell -Command "Set-ExecutionPolicy Bypass;"

echo "Installing Profile... "
@set "psCommand=powershell -Command "echo $PROFILE""
@for /f "usebackq delims=" %%p in (`%psCommand%`) do @set profile_file=%%p
echo Installing profile file - %profile_file%

powershell -Command "Add-Content -Path %profile_file% -Value 'oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp-custom.json" | Invoke-Expression';"

echo "Signing the profile..."

powershell -Command "Get-ChildItem Cert:\LocalMachine\My | Where-Object {$_.Subject -eq 'CN=OhMyPoshCodeSigningCert'} | Remove-Item -Force;$cert = New-SelfSignedCertificate -Subject OhMyPoshCodeSigningCert -NotAfter (Get-Date).AddMonths(24) -Type CodeSigningCert;$codeCertificate = Get-ChildItem Cert:\LocalMachine\My | Where-Object {$_.Subject -eq 'CN=OhMyPoshCodeSigningCert'};Set-AuthenticodeSignature -FilePath $PROFILE -Certificate $codeCertificate -TimeStampServer http://timestamp.digicert.com;Set-ExecutionPolicy RemoteSigned;"

pause