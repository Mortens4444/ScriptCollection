# Search for PID, ehich uses port 4200
$port = 4200
$processId = netstat -ano | findstr ":$port" | ForEach-Object { 
    $columns = $_ -split '\s+'
    if ($columns[4] -match '^\d+$') { $columns[4] }
}

if ($processId) {
    Write-Output "PID found: $processId"

    # Check if it not our PID
    if ($processId -ne $PID) {
        # Kill process
        taskkill /PID $processId /F
        Write-Output "Process $processId terminated."
    } else {
        Write-Output "The script's own process PID ($PID) matches the target PID. Not terminating."
    }
} else {
    Write-Output "No process found on port $port."
}
