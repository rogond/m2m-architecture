Write-Host "🧼 Cleaning up previous ZIP files..."
Remove-Item -Path "Function1.zip", "Function2.zip", "Function3.zip" -ErrorAction Ignore

$functions = @("Function1", "Function2", "Function3")

foreach ($fn in $functions) {
    $projPath = Join-Path $fn "$fn.csproj"
    $publishDir = Join-Path $fn "publish"

    Write-Host "Publishing $fn..."
    dotnet publish $projPath -c Release -o $publishDir

    $zipPath = "$fn.zip"
    Write-Host "Creating $zipPath..."
    if (Test-Path $zipPath) { Remove-Item $zipPath }

    Compress-Archive -Path "$publishDir\*" -DestinationPath $zipPath

    Write-Host "$zipPath created successfully."
}

Write-Host "All Lambda functions have been packaged."
