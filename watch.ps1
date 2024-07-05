# Define the path to the directory to watch
$path = "/path/to/app"

# Define the file filter (watch Python files)
$filter = "*.py"

# Create a new FileSystemWatcher object
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $path
$watcher.Filter = $filter
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

# Define the action to take when a change is detected
$action = {
    Write-Host "Change detected. Rebuilding Docker container..."
    docker-compose up --build
}

# Register event handlers for different types of changes
Register-ObjectEvent $watcher "Changed" -Action $action
Register-ObjectEvent $watcher "Created" -Action $action
Register-ObjectEvent $watcher "Deleted" -Action $action
Register-ObjectEvent $watcher "Renamed" -Action $action

# Event loop
while ($true) { Start-Sleep 1 }
