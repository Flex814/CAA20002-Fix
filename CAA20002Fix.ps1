$teams = Get-Process teams
$settingsfile = Test-Path -path $env:APPDATA\Microsoft\Teams\settings.json
$newfilepath = ".\settings.json"

function Stop-Teams{
    if ($teams) {
        echo "Closing Teams..."
        $teams | Stop-Process-force
        }
    echo "Teams is closed."
}

function Remove-SettingsJSON {
    if($settingsfile){
        echo "Removing old settings.json file..."
        Remove-Item -path $env:APPDATA\Microsoft\Teams\settings.json
        echo "Old settings.json file is removed."
    }else{
        echo "The settings.json file does not exist, skipping removal."
    }
}

function Restore-SettingsJSON {
    echo "Adding new settings.json file."
    Copy-Item -Path $newfilepath -Destination $env:APPDATA\Microsoft\Teams\
    echo "New settings.json file added..."
}

function Start-Teams {
    echo "Starting microsoft Teams..."
    Start-Process -File $env:LOCALAPPDATA\Microsoft\Teams\Update.exe -ArgumentList '--processStart "Teams.exe"'
    Sleep 7
}

echo "Microsoft Teams CAA20002 Error Fix"
Stop-Teams
Sleep 3
Remove-SettingsJSON
Sleep 3
Restore-SettingsJSON
Sleep 3
Start-Teams
Sleep 3
echo "Finished..."
