function Find-FirstDuplicateCharacter {
<#
    .SYNOPSIS
    Takes the provided string and returns the first duplicate character within that string

    .DESCRIPTION
    Takes the provided string and returns the first duplicate character within that string
    The function handles special characters and 

    .EXAMPLE
    Find-FirstDuplicateCharacter -Foo "abc123abc123"
    Returns the character "a"

    .EXAMPLE
    @("aabbcc", "112233")| Find-FirstDuplicateCharacter
    Returns an array of characters "a" and "1"

    .EXAMPLE
    $Item = [pscustomobject]@{
        Foo = "baseball"
    }
    $Item | Find-FirstDuplicateCharacter
    Returns the character "b"
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
