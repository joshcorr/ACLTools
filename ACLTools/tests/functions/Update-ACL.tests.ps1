$CommandName = $MyInvocation.MyCommand.Name.Replace(".Tests.ps1", "")


Describe "$CommandName Unit Tests" -Tag 'UnitTests' {

    Context "Validate parameters" {
        $paramCount = 10
        $defaultParamCount = 13
        [object[]]$params = (Get-ChildItem function:\Update-ACL).Parameters.Keys
        $knownParameters = 'Path', 'Rights', 'InheritanceFlag', 'PropagationFlag', 'Access', 'Principal','UpdateType','SetAdminOwner','Reset','DisableInheritance'

        It "Should contain our specific parameters" {
            ( (Compare-Object -ReferenceObject $knownParameters -DifferenceObject $params -IncludeEqual | Where-Object SideIndicator -eq "==").Count ) | Should Be $paramCount
        }

        It "Should only contain $paramCount parameters" {
            $params.Count - $defaultParamCount | Should Be $paramCount
        }
    }
}