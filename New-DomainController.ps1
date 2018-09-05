if(-not(Get-Module -Name "AWSPowerShell")){if(-not(Import-Module AWSPowerShell)){"Install AWS PowerShell";exit;}}

$profiles = Get-AWSCredential -ListProfileDetail
if($profiles.ProfileName.Count -gt 1)
{
    $i = 0
    $profiles|%{
        "$($i): $($_.ProfileName)"
        $i++
    }
    $input = Read-Host "Press the number for the corresponding profile"
    $i = [Convert]::ToInt32($input,10)
    if($i -is [int])
    {
        $profile = $profiles.ProfileName[$i]
    }
    else
    {
        "Input was not numeric"
    }
}
else
{
    $profile = $profiles.ProfileName
}

