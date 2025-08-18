Write-Host "`nUpdating PowerShell"
winget install Microsoft.PowerShell -s winget

Write-Host "`nInstaling Firefox"
winget install --id Mozilla.Firefox
winget install --id filips.FirefoxPWA

Write-Host "`nInstaling KeePassXC"
winget install --id KeePassXCTeam.KeePassXC

Write-Host "`nInstaling Spark Email Client"
winget install --id XPFCS9QJBKTHVZ -s msstore --accept-package-agreements

Write-Host "`nInstaling Steam"
winget install --id Valve.Steam

Write-Host "`nInstaling Visual Studio & Code"
winget install --id Microsoft.VisualStudio.2022.Community
winget install --id Microsoft.VisualStudio.2022.BuildTools
winget install --id Microsoft.VisualStudioCode

Write-Host "`nInstaling Docker"
winget install --id Docker.DockerDesktop

Write-Host "`nInstaling Auto Hot key"
winget install --id AutoHotkey.AutoHotkey

Write-Host "`nInstaling NodeJs"
winget install --id OpenJS.NodeJS.LTS -s winget

Write-Host "`nInstaling Rust"
winget install --id Rustlang.Rustup

Write-Host "`nInstaling Deno"
winget install --id DenoLand.Deno

Write-Host "`nInstaling MongoDB Compass"
winget install --id MongoDB.Compass.Community -s winget

Write-Host "`nInstaling Postman"
winget install --id Postman.Postman -s winget

Write-Host "`nInstaling Discord Client"
winget install --id Vencord.Vesktop -s winget
# winget install --id Discord.Discord -s winget

Write-Host "`nInstaling Spotify"
# Prefer official Spotify package (Store version). Spicetify supports it.
winget install --id Spotify.Spotify -s msstore --accept-package-agreements

Write-Host "A dev tool needs manual installation: https://github.com/microsoft/accessibility-insights-windows"

# MSIX Hero
winget install --id MarcinOtorowski.MSIXHero -s winget
winget install --id Microsoft.DotNet.AspNetCore.8 -s winget
winget install --id Microsoft.DotNet.DesktopRuntime.8 -s winget

# MSIX Packaging Tool
winget install --id 9N5LW3JBCXKF -s msstore --accept-package-agreements

~\.dotfiles\installers\apps\scoop.ps1