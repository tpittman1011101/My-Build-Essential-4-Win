# Temporarily bypass execution policy with unsigned script
Set-ExecutionPolicy Bypass -Scope Process -Force

if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Chocolatey is not installed. Installing Chocolatey..."
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}
choco upgrade chocolatey -y

function Install-ChocoPackageIfNotInstalled {
    param (
        [string]$packageName
    )

    if (-not (choco list --local-only | Select-String $packageName)) {
        choco install $packageName -y
    } else {
        Write-Host "$packageName is already installed."
    }
}

Install-ChocoPackageIfNotInstalled "visualstudio2022community"
Install-ChocoPackageIfNotInstalled "docker-desktop"

if (-not (wsl --list --verbose | Select-String "Ubuntu-Preview")) {
    wsl --install -d Ubuntu-Preview
} else {
    Write-Host "Ubuntu Preview is already installed."
}

Install-ChocoPackageIfNotInstalled "vscode"
Install-ChocoPackageIfNotInstalled "signal"
Install-ChocoPackageIfNotInstalled "okular"
Install-ChocoPackageIfNotInstalled "steam"
Install-ChocoPackageIfNotInstalled "epicgameslauncher"
Install-ChocoPackageIfNotInstalled "cmake --installargs 'ADD_CMAKE_TO_PATH=System'"
Install-ChocoPackageIfNotInstalled "xampp"
Install-ChocoPackageIfNotInstalled "localwp"
Install-ChocoPackageIfNotInstalled "git"
Install-ChocoPackageIfNotInstalled "github-desktop"
Install-ChocoPackageIfNotInstalled "freemind"
Install-ChocoPackageIfNotInstalled "eclipse"
Install-ChocoPackageIfNotInstalled "androidstudio"
Install-ChocoPackageIfNotInstalled "virtualbox"
Install-ChocoPackageIfNotInstalled "neovim"
Install-ChocoPackageIfNotInstalled "powertoys"
Install-ChocoPackageIfNotInstalled "paint.net"
Install-ChocoPackageIfNotInstalled "cherrytree"
Install-ChocoPackageIfNotInstalled "greenshot"
Install-ChocoPackageIfNotInstalled "ida-free"

Write-Host "Installation complete. Please restart your computer if necessary."

# Re-enable execution policy
Set-ExecutionPolicy Restricted -Scope Process -Force
