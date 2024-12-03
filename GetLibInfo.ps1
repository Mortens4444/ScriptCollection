# Set paths to tools
$vsPath = "C:\Program Files\Microsoft Visual Studio\2022\Preview\VC\Tools\MSVC\14.43.34604\bin\Hostx64\x64"
$dumpbinPath = "$vsPath\dumpbin.exe"

# Specify the .lib file path
$outputPath = "C:\Work\Mtf.HardwareKey\SuperPro_ClientLibrary_7.1.0.19_Windows_jiraus_SM-178056\Lib(x64)\MD"
$libFilePath = "$outputPath\spromeps.lib"
$outputFile = "$outputPath\spromeps.txt"

# Run dumpbin to extract exports
Write-Output "Running dumpbin on $libFilePath..."
& $dumpbinPath /exports $libFilePath | Out-File $outputFile

Write-Output "Exported functions saved to $outputFile"

Get-Content $outputFile | ForEach-Object { Write-Output $_ }