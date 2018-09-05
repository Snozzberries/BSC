function New-SelectionPrompt
{
    Param(
        [ValidateScript({$_ -ne "" -and $_ -ne $null})] 
        [Parameter(Mandatory=$True)]
        $Options,
        [Parameter(Mandatory=$False)]
        $Default,
        [Parameter(Mandatory=$False)]
        $DefaultMessage="Use default selection: $default",
        [Parameter(Mandatory=$False)]
        $Message="Please select desired value",
        [Parameter(Mandatory=$False)]
        $Title="Selection Prompt",
        [Parameter(Mandatory=$False)]
        $DefaultTitle="Selection Prompt"
    )

    if($default)
    {
        $defaultChoices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
        $defaultChoices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'))
        $defaultChoices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'))

        if($Host.UI.PromptForChoice($defaultTitle, $defaultMessage, $defaultChoices, 1) -eq 0)
        {
          return $default
        }
    }
       
    $optionChoices = @()
    for ($i=0; $i -lt $options.Count; $i++) {
        $optionChoices += [System.Management.Automation.Host.ChoiceDescription]("&$($i+1): $($options[$i])")
    }
    $selection = $host.UI.PromptForChoice($Title, $Message, $optionChoices, 0)

    return $options[$selection]
}