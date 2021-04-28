function Find-FirstDuplicateCharacter {
<#
    .SYNOPSIS
    Takes the provided string and returns the first duplicate character within that string

    .DESCRIPTION
    Takes the provided string and returns the first duplicate character within that string
    The function handles special characters and 

    .EXAMPLE
    PS> extension -name "File"
    File.txt
#>
[OutputType([char])]
[cmdletbinding()]
param (
    # 
    [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
    [string]$Foo
)

    process {
        $EncounteredCharacters = @{}
        # considering how light the work is, language foreach is preferrable to foreach-object here. 
        #    The benefits of pipeline do not outweigh the overhead of the cmdlet for such a simple check considering it short-circuits on the first duplicate.
        foreach ($char in [char[]]$foo) {
            if (-not $EncounteredCharacters[$char]){
                $EncounteredCharacters[$char] = $char
            } else {
                return $char
            }
        }
        Write-Warning "No duplicate characters found in the string '$foo'"
    }
}