
. $PsScriptRoot\Find-FirstDuplicateCharacter.ps1
Describe "Find-FirstDuplicateCharacter" {
    Context "Parameter Validation" {
        $Command = Get-Command Find-FirstDuplicateCharacter
        it "Has a String parameter Foo" {
            $Command.Parameters['Foo'].ParameterType | should be 'String'
        }
        it "Has Foo and only Foo as a parameter" {
            ($Command.Parameters.keys | Where-Object {$_ -notin @([System.Management.Automation.PSCmdlet]::CommonParameters)}).count | should be 1
        }
        it "Function output type is 'char'" {
            $Command.OutputType | should be system.char
        }
    }

    Context "Function Execution" {
        <#
        # This test is overkill. I wrote it quickly as a sanity check to confirm hashes can support every character as a key name to confirm no edge cases for possible inputs
        #  I would have left it in just because however it takes 45 seconds to run and I don't want to make you wait.
        it "Works with every possible character" {
            foreach ($i in (1..[char]::MaxValue)){
                $Char = [char]$i
                    $Result = Find-FirstDuplicateCharacter -Foo "$($Char)abc123$($Char)" 
                    $Result | should be $Char
            }
        }
        #>

        it "Returns the expected value" {
            $Result = Find-FirstDuplicateCharacter -Foo "abc123abc123"
            $Result | should be a 
        }
        it "Works with Pipeline input" {
            $Input = @(
                '1234512345'
                '\(0o0)/'
                'abcabc'
                '$$(*%^'
            )
            $Result = $Input | Find-FirstDuplicateCharacter
            $Result[0] | should be '1'
            $Result[1] | should be '0'
            $Result[2] | should be 'a'
            $Result[3] | should be "`$"
        }
        it "Works with pipeline by property name" {
            $Input = [pscustomobject]@{
                Foo = "Barrrrr"
            }
            $Result = $Input | Find-FirstDuplicateCharacter
            $Result | should be "r"
        }
        it "Writes a warning when no duplicate characters are found and returns no data" {
            Mock Write-Warning {}
            $Result = Find-FirstDuplicateCharacter -Foo "abc123"
            $Result | should BeNullOrEmpty
            Assert-MockCalled Write-Warning -Times 1 -Exactly
        }
    }
}