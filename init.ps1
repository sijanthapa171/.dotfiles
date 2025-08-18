Set-ExecutionPolicy Bypass -Scope Process -Force

winget install --id Git.Git
winget install --id GitHub.cli

# Add Git to the system PATH if it's not already there
$gitPath = "C:\Program Files\Git\cmd"
$systemPath = [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine)
if (-not $systemPath.Contains($gitPath)) {
    $newPath = $systemPath + ";" + $gitPath
    [Environment]::SetEnvironmentVariable("Path", $newPath, [EnvironmentVariableTarget]::Machine)
    Write-Host "Added Git to system PATH."
}

# Refresh the current session PATH
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

git clone https://github.com/sijanthapa171/.dotfiles.git "$env:USERPROFILE\.dotfiles"
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.dotfiles\setup.ps1"