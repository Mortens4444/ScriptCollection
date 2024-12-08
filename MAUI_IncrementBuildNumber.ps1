param(
    [string]$CsprojPath = ".\GardenerMaster\GardenerMaster.csproj",
    [string]$ManifestPath = ".\GardenerMaster\Platforms\Android\AndroidManifest.xml"
)

$solutionDirectory = "C:\Work\GardenerMaster"
$csprojFullPath = [System.IO.Path]::Combine($solutionDirectory, $CsprojPath)
$manifestFullPath = [System.IO.Path]::Combine($solutionDirectory, $ManifestPath)
$xml = [xml](Get-Content $csprojFullPath)

$fileVersionPropertyGroup = $xml.Project.PropertyGroup | Where-Object { $_.FileVersion }
$appDisplayVersionPropertyGroup = $xml.Project.PropertyGroup | Where-Object { $_.ApplicationDisplayVersion }

if ($fileVersionPropertyGroup -and $appDisplayVersionPropertyGroup)
{
    $buildNumber = $fileVersionPropertyGroup.BuildNumber
    $newBuildNumber = [Convert]::ToInt32($buildNumber) + 1

    # Update version number in csproj
    $fileVersionPropertyGroup.BuildNumber = $newBuildNumber.ToString()
    $xml.Save($csprojFullPath)

    # Update version number in AndroidManifest.xaml
    $manifestXml = [xml](Get-Content $manifestFullPath)
    $manifestXml.manifest.attributes["android:versionCode"].value = $newBuildNumber
    $manifestXml.Save($manifestFullPath)
}
else
{
    Write-Host "Required PropertyGroup elements not found in the XML."
}