# 9Router AI Infrastructure Setup Script
# Installs and configures 9router, CLIProxyAPI, RTK, Caveman, and Ponytail
# Compatible with Windows PowerShell 5.1+ and PowerShell 7+

param(
    [switch]$SkipRTK = $false,
    [switch]$SkipCLIProxy = $false,
    [switch]$SkipCaveman = $false,
    [switch]$SkipPonytail = $false,
    [switch]$Force = $false
)

$ErrorActionPreference = "Stop"
$InstallDir = "$env:USERPROFILE\.ai-infrastructure"
$LogDir = "$InstallDir\logs"
$ConfigFile = "$InstallDir\config.json"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "[$timestamp] [$Level] $Message"
    Write-Host $logEntry
    $logEntry | Out-File -FilePath "$LogDir\setup.log" -Append
}

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Install-Dependencies {
    Write-Log "Checking dependencies..."
    
    if (-not (Get-Command "node" -ErrorAction SilentlyContinue)) {
        Write-Log "Node.js not found. Please install Node.js from https://nodejs.org" "WARN"
    }
    
    if (-not (Get-Command "npm" -ErrorAction SilentlyContinue)) {
        Write-Log "npm not found. Please install Node.js from https://nodejs.org" "WARN"
    }
    
    if (-not (Get-Command "curl" -ErrorAction SilentlyContinue)) {
        Write-Log "curl not found. Please install curl or use Invoke-WebRequest" "WARN"
    }
}

function Install-9Router {
    Write-Log "Installing 9router..."
    
    # Create installation directory
    if (-not (Test-Path $InstallDir)) {
        New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
    }
    if (-not (Test-Path $LogDir)) {
        New-Item -ItemType Directory -Path $LogDir -Force | Out-Null
    }
    
    # Check if 9router is already installed
    if (Test-Path "$InstallDir\9router") {
        Write-Log "9router already installed. Skipping..." "INFO"
        return
    }
    
    try {
        # Install 9router globally
        Write-Log "Installing 9router globally via npm..."
        npm install -g 9router 2>&1 | Tee-Object -Variable npmOutput | Out-Null
        
        # Create local installation for configuration
        Write-Log "Creating local 9router installation..."
        git clone https://github.com/decolua/9router.git "$InstallDir\9router-source" 2>&1 | Out-Null
        
        # Create .env file
        $envFile = "$InstallDir\9router\.env"
        if (-not (Test-Path $envFile)) {
            Copy-Item "$InstallDir\9router-source/.env.example" $envFile
        }
        
        # Update .env with our configuration
        $envContent = Get-Content $envFile
        $envContent = $envContent -replace 'NEXT_PUBLIC_BASE_URL=http://localhost:3000', 'NEXT_PUBLIC_BASE_URL=http://localhost:20128'
        $envContent | Set-Content $envFile
        
        Write-Log "9router installation completed successfully"
    }
    catch {
        Write-Log "Failed to install 9router: $_" "ERROR"
        throw
    }
}

function Configure-9Router {
    Write-Log "Configuring 9router..."
    
    try {
        # Generate API key
        $apiKey = "sk-$(New-Guid)"
        
        # Write to config
        $config = @{
            NINEROUTER_URL = "http://localhost:20128"
            NINEROUTER_KEY = $apiKey
            INSTALL_DATE = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            VERSION = "latest"
        }
        
        $config | ConvertTo-Json | Set-Content $ConfigFile -Force
        
        Write-Log "9router configured with API endpoint: http://localhost:20128"
        Write-Log "Generated API Key: $apiKey"
        Write-Log "Configuration saved to: $ConfigFile"
    }
    catch {
        Write-Log "Failed to configure 9router: $_" "ERROR"
        throw
    }
}

function Install-CLIProxyAPI {
    Write-Log "Installing CLIProxyAPI..."
    
    if ($SkipCLIProxy) {
        Write-Log "Skipping CLIProxyAPI installation (flag set)"
        return
    }
    
    try {
        # Download latest release
        $latestRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/router-for-me/CLIProxyAPI/releases/latest"
        $downloadUrl = $latestRelease.assets | Where-Object { $_.name -like "*.zip" } | Select-Object -First 1 | Select-Object -ExpandProperty browser_download_url
        
        if ($downloadUrl) {
            Write-Log "Downloading CLIProxyAPI from: $downloadUrl"
            $zipPath = "$InstallDir\CLIProxyAPI.zip"
            Invoke-WebRequest -Uri $downloadUrl -OutFile $zipPath
            
            # Extract
            Write-Log "Extracting CLIProxyAPI..."
            Expand-Archive -Path $zipPath -DestinationPath "$InstallDir\CLIProxyAPI" -Force
            
            # Cleanup
            Remove-Item $zipPath -Force
        }
        
        Write-Log "CLIProxyAPI installation completed successfully"
    }
    catch {
        Write-Log "Failed to install CLIProxyAPI: $_" "ERROR"
        # Continue even if CLIProxyAPI fails - it's optional
    }
}

function Install-RTK {
    Write-Log "Installing RTK..."
    
    if ($SkipRTK) {
        Write-Log "Skipping RTK installation (flag set)"
        return
    }
    
    try {
        # Install RTK via Homebrew (if available) or compile from source
        if (Get-Command "brew" -ErrorAction SilentlyContinue) {
            Write-Log "Installing RTK via Homebrew..."
            brew install rtk
        }
        else {
            Write-Log "RTK requires manual installation or Homebrew"
            Write-Log "Visit https://github.com/rtk-ai/rtk for installation options"
        }
        
        # Initialize RTK for Claude Code
        if (Get-Command "rtk" -ErrorAction SilentlyContinue) {
            Write-Log "Initializing RTK for Claude Code..."
            rtk init -g 2>&1 | Out-Null
        }
        
        Write-Log "RTK installation completed successfully"
    }
    catch {
        Write-Log "Failed to install RTK: $_" "ERROR"
        # Continue even if RTK fails
    }
}

function Install-Caveman {
    Write-Log "Installing Caveman..."
    
    if ($SkipCaveman) {
        Write-Log "Skipping Caveman installation (flag set)"
        return
    }
    
    try {
        # Install Caveman skill for opencode
        $cavemanDir = "$env:USERPROFILE\.claude\skills\caveman"
        if (-not (Test-Path $cavemanDir)) {
            New-Item -ItemType Directory -Path $cavemanDir -Force | Out-Null
        }
        
        # Download Caveman skill
        $cavemanUrl = "https://raw.githubusercontent.com/decolua/9router/master/skills/caveman/SKILL.md"
        Invoke-WebRequest -Uri $cavemanUrl -OutFile "$cavemanDir\SKILL.md"
        
        Write-Log "Caveman skill installed to: $cavemanDir"
    }
    catch {
        Write-Log "Failed to install Caveman: $_" "ERROR"
    }
}

function Install-Ponytail {
    Write-Log "Installing Ponytail..."
    
    if ($SkipPonytail) {
        Write-Log "Skipping Ponytail installation (flag set)"
        return
    }
    
    try {
        # Install Ponytail skill for opencode
        $ponytailDir = "$env:USERPROFILE\.claude\skills\ponytail"
        if (-not (Test-Path $ponytailDir)) {
            New-Item -ItemType Directory -Path $ponytailDir -Force | Out-Null
        }
        
        # Download Ponytail skill
        $ponytailUrl = "https://raw.githubusercontent.com/DietrichGebert/ponytail/master/SKILL.md"
        Invoke-WebRequest -Uri $ponytailUrl -OutFile "$ponytailDir\SKILL.md"
        
        Write-Log "Ponytail skill installed to: $ponytailDir"
    }
    catch {
        Write-Log "Failed to install Ponytail: $_" "ERROR"
    }
}

function Update-HermesProfile {
    Write-Log "Updating Hermes profiles..."
    
    try {
        $profileDir = "$InstallDir\hermes\profiles"
        if (-not (Test-Path $profileDir)) {
            New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
        }
        
        # Create default profile
        $defaultProfile = @{
            name = "default-profile"
            environment = "production-ready"
            model_preference = @{
                first_choice = "9router/pro-models"
                fallback_1 = "9router/lite-models"
                fallback_2 = "9router/free-models"
                fallback_3 = "OpenRouter free models"
                fallback_4 = "opencode zen → go integration"
            }
            default_model = "9router/pro-models"
            max_retries = 5
            skills_inclusion = @(
                "full-stack_dev", "dotnet_dev", "nextjs_dev", "vue_dev", "css_design",
                "business_analysis", "mba_analysis", "enterprise_architecture",
                "solution_architecture", "ui_ux_design", "developer_ops",
                "devops_engineering", "cloud_infrastructure", "cybersecurity",
                "research_specialist", "9router-setup", "cli-proxy-setup",
                "rtk-integration", "caveman-mode", "ponytail-mode"
            )
        }
        
        $defaultProfile | ConvertTo-Json -Depth 10 | Set-Content "$profileDir\default-profile.json" -Force
        
        # Create OmniRoute profile
        $omniProfile = @{
            name = "omniroute-profile"
            environment = "production-optimized"
            model_preference = @{
                first_choice = "omniroute-pro-models"
                fallback_1 = "9router/lite-models"
                fallback_2 = "9router/free-models"
                fallback_3 = "OpenRouter free models"
                fallback_4 = "opencode zen → go integration"
            }
            default_model = "omniroute-pro-models"
            max_retries = 5
            skills_inclusion = @(
                "full-stack_dev", "dotnet_dev", "nextjs_dev", "vue_dev", "css_design",
                "business_analysis", "mba_analysis", "enterprise_architecture",
                "solution_architecture", "ui_ux_design", "developer_ops",
                "devops_engineering", "cloud_infrastructure", "cybersecurity",
                "research_specialist", "9router-setup", "cli-proxy-setup",
                "rtk-integration", "caveman-mode", "ponytail-mode"
            )
        }
        
        $omniProfile | ConvertTo-Json -Depth 10 | Set-Content "$profileDir\omniroute-profile.json" -Force
        
        Write-Log "Hermes profiles updated successfully"
    }
    catch {
        Write-Log "Failed to update Hermes profiles: $_" "ERROR"
    }
}

function Update-EnvironmentVariables {
    Write-Log "Updating environment variables..."
    
    try {
        # Add to PowerShell profile
        $profilePath = $PROFILE.CurrentUserAllHosts
        if (-not (Test-Path (Split-Path $profilePath))) {
            New-Item -ItemType Directory -Path (Split-Path $profilePath) -Force | Out-Null
        }
        
        # Create profile if it doesn't exist
        if (-not (Test-Path $profilePath)) {
            New-Item -ItemType File -Path $profilePath -Force | Out-Null
        }
        
        # Read current profile content
        $profileContent = Get-Content $profilePath -ErrorAction SilentlyContinue
        
        # Add 9router environment variables
        $envVars = @"


# 9Router AI Infrastructure
# Added by setup-9router.ps1
$env:NINEROUTER_URL = "http://localhost:20128"
$env:NINEROUTER_KEY = "sk-$(New-Guid)"
"@
        
        if ($profileContent -notmatch "9Router AI Infrastructure") {
            Add-Content -Path $profilePath -Value $envVars
        }
        
        # Set environment variables for current session
        $env:NINEROUTER_URL = "http://localhost:20128"
        $env:NINEROUTER_KEY = "sk-$(New-Guid)"
        
        Write-Log "Environment variables updated"
    }
    catch {
        Write-Log "Failed to update environment variables: $_" "ERROR"
    }
}

function Show-Summary {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "   9Router AI Infrastructure Setup Complete" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Installation Directory: $InstallDir"
    Write-Host "Log File: $LogDir\setup.log"
    Write-Host ""
    Write-Host "Next Steps:" -ForegroundColor Yellow
    Write-Host "1. Start 9router: cd $InstallDir\9router-source && npm run dev"
    Write-Host "2. Open http://localhost:20128 in your browser"
    Write-Host "3. Configure your AI tools to use: http://localhost:20128/v1"
    Write-Host ""
    Write-Host "Environment Variables Set:"
    Write-Host "  NINEROUTER_URL = http://localhost:20128"
    Write-Host "  NINEROUTER_KEY = [API Key]"
    Write-Host ""
    Write-Host "Installed Components:"
    Write-Host "  - 9Router: AI Gateway"
    Write-Host "  - CLIProxyAPI: CLI Proxy (if available)"
    Write-Host "  - RTK: Token Saver (if installed)"
    Write-Host "  - Caveman: Output compression"
    Write-Host "  - Ponytail: Lazy senior dev mode"
    Write-Host ""
}

# Main execution
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   9Router AI Infrastructure Setup    " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Create directories
if (-not (Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
}
if (-not (Test-Path $LogDir)) {
    New-Item -ItemType Directory -Path $LogDir -Force | Out-Null
}

# Initialize log
"Setup started at $(Get-Date)" | Out-File "$LogDir\setup.log"

try {
    # Check for admin rights (optional but recommended)
    if (-not (Test-Admin)) {
        Write-Log "Running without admin rights. Some operations may fail." "WARN"
    }
    
    # Install dependencies
    Install-Dependencies
    
    # Install and configure each component
    Install-9Router
    Configure-9Router
    Install-CLIProxyAPI
    Install-RTK
    Install-Caveman
    Install-Ponytail
    
    # Update profiles and environment
    Update-HermesProfile
    Update-EnvironmentVariables
    
    # Show summary
    Show-Summary
}
catch {
    Write-Log "Setup failed: $_" "ERROR"
    Write-Host "Setup failed. Check $LogDir\setup.log for details." -ForegroundColor Red
    exit 1
}

Write-Host "Setup completed successfully!" -ForegroundColor Green