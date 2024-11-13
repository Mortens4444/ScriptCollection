#Create EnumLikeObject from enum and decription
$enumName = "SentinelErrorCode"
$lines = Get-Content -Path "values.txt"
#
# File (values.txt) should contain lines likes this
#
# [Description("The function completed successfully.")]
# SpSuccess = 0,
# [Description("The key is not initialized.")]
# SP_INIT_NOT_CALLED = 57,
#

$output = @()

for ($i = 0; $i -lt $lines.Count; $i += 2) {
    # Reading - [Description("")])
    $descriptionLine = $lines[$i]
    # Reading value (ex. SpSuccess = 0,)
    $enumLine = $lines[$i + 1]

    # Get the description
    if ($descriptionLine -match '\[Description\("(.+?)"\)\]') {
        $description = $matches[1]
    } else {
        Write-Host "Unable to get description from this line: $descriptionLine"
        continue
    }

    # Get name and value from every second line (pl. SpSuccess = 0,)
    if ($enumLine -match '(\w+)\s*=\s*(\d+),') {
        $name = $matches[1]
        $value = $matches[2]
    } else {
        Write-Host "Unable to get name and value from this line: $enumLine"
        continue
    }

    $outputLine = "public static readonly $enumName $name = new $enumName($value, `"$description`");"
    $output += $outputLine
}

$output | ForEach-Object { Write-Output $_ }
