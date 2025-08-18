# Spicetify setup script
# References: https://spicetify.app/docs/getting-started/

Write-Host "`nConfiguring Spicetify for Spotify..."

# Ensure Spotify is installed (winget Store ID)
$spotifyExe = "$env:LOCALAPPDATA\Microsoft\WindowsApps\Spotify.exe"
if (-not (Test-Path $spotifyExe)) {
    Write-Host "Spotify not found. Installing via winget..."
    try {
        winget install --id Spotify.Spotify -s msstore --accept-package-agreements --accept-source-agreements | Out-Null
    } catch {
        Write-Warning "Failed to install Spotify automatically. Please install it from Microsoft Store and re-run."
        return
    }
}

# Install Spicetify CLI
Write-Host "Installing Spicetify CLI..."
try {
    iwr -useb https://raw.githubusercontent.com/spicetify/cli/main/install.ps1 | iex
} catch {
    Write-Warning "Failed to install Spicetify CLI automatically. Check your network and try again."
    return
}

# Initialize and apply default theme/patches
Write-Host "Initializing and applying Spicetify patches..."
spicetify backup apply enable-devtool

# Install Spicetify Marketplace (optional but recommended)
Write-Host "Installing Spicetify Marketplace... (optional)"
try {
    iwr -useb https://raw.githubusercontent.com/spicetify/marketplace/main/resources/install.ps1 | iex
} catch {
    Write-Warning "Marketplace installation failed; you can install later from: https://github.com/spicetify/marketplace"
}

Write-Host "Spicetify setup complete. If Spotify is running, restart it to see changes."

