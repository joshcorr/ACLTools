$CommandName = $MyInvocation.MyCommand.Name.Replace(".Tests.ps1", "")

Describe "$CommandName Unit Tests" -Tag 'Unit' {

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
    Context "Validate Code Logic"{
        mock -CommandName New-Object -MockWith {} -Verifiable
        mock -CommandName Get-ACL -MockWith {} -Verifiable
        mock -CommandName Set-ACL -MockWith {} -Verifiable

        It "Should Execute" {
            {Update-ACL -Path C:\temp\file.txt -Principal 'Authenticated Users' -Rights ReadAndExecute,ReadPermissions -InheritanceFlag none -PropagationFlag none -Access Allow -UpdateType Add} | should -not -Throw
        }
        mock -CommandName Update-ACL -MockWith {throw} -Verifiable
        It "Should Not Execute" {
            {Update-ACL -Path C:\temp\file.txt -Principal 'Authenticated Users' -Rights ReadAndExecute,ReadPermissions -InheritanceFlag none -PropagationFlag none -Access Allow -UpdateType Add} | should -Throw
        }
    }
}
Describe "$CommandName Intigration Tests" -Tag "Intigration" {
    context "Syntax 1"{
    $file = 'testdrive:\folder\temp1.txt'
    New-Item -Path testdrive:\ -Name folder -ItemType Directory
    New-Item -Path testdrive:\folder\ -Name temp1.txt -ItemType File
    $update = Update-ACL -Path $file -Principal 'Authenticated Users' -Rights FullControl -InheritanceFlag none -PropagationFlag none -Access Allow -UpdateType Add

        It "Should have executed without Error"{
            $update | should -BeNullOrEmpty
        }
        It "Should have permission set for 'Authenticated Users'"{
            ((Get-Acl -Path $file).access | Where-Object {$_.identityreference -like '*Authenticated Users' -and $_.FileSystemRights -eq 'FullControl'}).Identityreference | should -Be 'NT AUTHORITY\Authenticated Users'
        }
        It "Should have full control for 'Authenticated Users'"{
            ((Get-Acl -Path $file).access | Where-Object {$_.identityreference -like '*Authenticated Users' -and $_.FileSystemRights -eq 'FullControl'}).FileSystemRights | should -Be 'FullControl'
        }
        It "Should have inheritance on $file"{
            ((Get-Acl -Path $file).access | Where-Object {$_.identityreference -eq 'NT AUTHORITY\SYSTEM'}).IsInherited | should -Be $true
        }
    }
    context "Syntax 2"{
    $file = 'testdrive:\folder\temp2.txt'
    New-Item -Path testdrive:\ -Name folder -ItemType Directory
    New-Item -Path testdrive:\folder\ -Name temp2.txt -ItemType File
    $owner = Update-ACL -Path $file -Principal 'Authenticated Users' -SetAdminOwner

            It "Should have executed without Error"{
                $owner | should -BeNullOrEmpty
            }
            It "Should set 'Authenticated Users' as Owner"{
                ((Get-Acl -Path $file).Owner) | should -Be 'NT AUTHORITY\Authenticated Users'
            }

    }
    context "Syntax 3"{
        $file = 'testdrive:\folder\temp3.txt'
        New-Item -Path testdrive:\ -Name folder -ItemType Directory
        New-Item -Path testdrive:\folder\ -Name temp3.txt -ItemType File
        $update = Update-ACL -Path $file -Principal 'Authenticated Users' -Rights FullControl -InheritanceFlag none -PropagationFlag none -Access Allow -UpdateType Add
        $reset = Update-ACL -Path $file -Reset
            It "Should have executed without Error"{
                $reset  | should -BeNullOrEmpty
                $update | should -BeNullOrEmpty
            }
            <#It "Should reset the permissions on $file"{
                (Get-Acl -Path $file).access.Identityreference  | should -BeNullOrEmpty
            }#>
    }
    context "Syntax 4"{
        $file = 'testdrive:\folder\temp4.txt'
        New-Item -Path testdrive:\ -Name folder -ItemType Directory
        New-Item -Path testdrive:\folder\ -Name temp4.txt -ItemType File
        $disableInheritance = Update-ACL -Path $file -DisableInheritance
            It "Should have executed without Error"{
                $disableInheritance  | should -BeNullOrEmpty
            }
            It "Should disable inheritance on $file"{
                ((Get-Acl -Path $file).access | Where-Object {$_.identityreference -eq 'NT AUTHORITY\SYSTEM'}).IsInherited | should -Be $false
            }
    }
}