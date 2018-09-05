$dependencies = @(
    "https://raw.githubusercontent.com/Snozzberries/BSC/master/New-SelectionPrompt.psm1"
)

foreach($dependency in $dependencies)
{
    $content = Invoke-WebRequest $dependency
    $path = "$env:TEMP\$(Get-Random -Maximum 999 -Minimum 100)-importModule.psm1"
    Out-File -FilePath $path -InputObject $content
    
    if(-not (Import-Module $path))
    {
        Write-Error "Failed to import module:`n $dependency"
    }

    Remove-Item $path
}