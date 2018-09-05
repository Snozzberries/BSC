if(-not(Get-Module -Name "AWSPowerShell")){if(-not(Import-Module AWSPowerShell)){"Install AWS PowerShell";exit;}}

$profiles = Get-AWSCredential -ListProfileDetail
if($profiles.ProfileName.Count -gt 1)
{
    $i = 0
    $profiles|%{
        "$($i): $($_.ProfileName)"
        $i++
    }
    $temp = Read-Host "Press the number for the corresponding profile"
    $i = [Convert]::ToInt32($temp,10)
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

$regions = Get-AWSRegion
if($regions.IsShellDefault)
{
    $region = $regions|?{$_.IsShellDefault}
    $temp = Read-Host "Use default region ($region)? (y/n)"
    if($temp -notin @("y","n"))
    {
        "Input not y or n"
    }
    elseif($temp -eq "y")
    {
        $region = $regions|?{$_.IsShellDefault}
    }
    else
    {
        $i = 0
        $regions|%{
            "$($i): $($_.Region) - $($_.Name)"
            $i++
        }
        $temp = Read-Host "Press the number for the corresponding region"
        $i = [Convert]::ToInt32($temp,10)
        if($i -is [int])
        {
            $region = $regions.Region[$i]
        }
        else
        {
            "Input was not numeric"
        }
    }
}
else
{
    $i = 0
    $regions|%{
        "$($i): $($_.Region) - $($_.Name)"
        $i++
    }
    $temp = Read-Host "Press the number for the corresponding region"
    $i = [Convert]::ToInt32($temp,10)
    if($i -is [int])
    {
        $region = $regions.Region[$i]
    }
    else
    {
        "Input was not numeric"
    }
}