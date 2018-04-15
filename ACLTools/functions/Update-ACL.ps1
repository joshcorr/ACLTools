Function Update-ACL {
<#
.SYNOPSIS
Update-ACL modifies owner and updates for files

.DESCRIPTION
Update-ACL leverages the System.Security.AccessControl .net class to set file and folder permissions

.PARAMETER Path
Path of folders or files that needs permission changes

.PARAMETER Rights
The rights that are granted to the user. You may assign any of the following rights: `
    AppendData,ChangePermissions,CreateDirectories,CreateFiles,Delete,DeleteSubdirectoriesAndFiles,
	ExecuteFile,FullControl,ListDirectory,Modify,Read,ReadAndExecute,ReadAttributes,ReadData,ReadExtendedAttributes,
	ReadPermissions,Synchronize,TakeOwnership,Traverse,Write,WriteAttributes,WriteData,WriteExtendedAttributes

.PARAMETER InheritanceFlag
Whether the rights granted are for the folder or files under the path.
Accepts ContainerInherit, ObjectInherit, or None. Default is None

.PARAMETER PropagationFlag
Whether the rights granted become propagated to the folders or files under the path
Accepts InheritOnly, NoPropagateInherit, or None. Default is None

.PARAMETER Access
Either Allow or Deny access of a specified right

.PARAMETER Principal
The user that is being granted the permissions

.PARAMETER UpdateType
This determines the permission set action can be Add to create a new entry, Set to update an entry, Remove to remove the entry, or RemoveAll to remove all permissions for the principle

.PARAMETER SetAdminOwner
This switch calls the SetOwner on the path for the defined principle

.PARAMETER Reset
This switch calls the SetAccessRuleProtection method to Set inheritence on the file or folder. Similar to icacls /reset

.PARAMETER DisableInheritance
This switch calls the SetAccessRuleProtection method to Disable inheritence on the file or folder.

.NOTES
Author: Joshua Corrick
Requires: Administrative Rights

Copyright (C) 2018 Joshua@Corrick.io

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

.EXAMPLE
Update-ACL -Path "\\$Server\$Drive`$\$folder\$user" -InheritanceFlag ObjectInherit,ContainerInherit -Rights FullControl -Principal "BUILTIN\Administrators" -Access Allow -UpdateType Set

If used in a script like New-UserShares this would update the permissions for the BUILTIN\Administrators

.EXAMPLE
Update-ACL -Path "C:\temp" -Principal "BUILTIN\Administrators" -SetAdminOwner

This would set the owner on the folder declared

#>
[cmdletBinding(
	DefaultParameterSetName="ACLS",
	SupportsShouldProcess=$True
)]
param(
    [Parameter(
		Mandatory=$true,
		ValueFromPipelineByPropertyName=$true,
		HelpMessage="Give a valid file or folder path"
	)]
    [system.object]$Path,

    [Parameter(
		Mandatory=$false,
	    ParameterSetName='ACLS')]
	[System.Security.AccessControl.FileSystemRights]$Rights = "Read",

    [Parameter(
		Mandatory=$false,
		ParameterSetName='ACLS'
	)]
	[System.Security.AccessControl.InheritanceFlags]$InheritanceFlag = "None",


    [Parameter(
		Mandatory=$false,
		ParameterSetName='ACLS'
	)]
	[System.Security.AccessControl.PropagationFlags]$PropagationFlag = "None",

    [Parameter(
		Mandatory=$false,
		HelpMessage="Select Allow or Deny",
		ParameterSetName='ACLS'
	)]
	[ValidateSet("Allow","Deny")]
	[System.Security.AccessControl.AccessControlType]$Access = "Deny",

    [Parameter(
		Mandatory=$true,
		HelpMessage="Enter domain\username or domain\groupname",
		ParameterSetName='ACLS'
	)]
	[Parameter(
        Mandatory=$true,
        ParameterSetName='Owner'
    )]
	[System.String]$Principal,

    [Parameter(
		Mandatory=$true,
		HelpMessage="Select Add, Remove, or RemoveAll,",
		ParameterSetName='ACLS'
	)]
    [ValidateSet("Add","Set","Remove","RemoveAll")]
	[string]$UpdateType,

	[Parameter(
		HelpMessage="Switch which calls the Owner Set",
		ParameterSetName='Owner'
	)]
	[switch]$SetAdminOwner,

    [Parameter(
		HelpMessage="Switch which calls the Reset similar to icacls /reset",
		ParameterSetName='Reset'
	)]
	[switch]$Reset,

	[Parameter(
		HelpMessage="Switch which disables inheritance on a existing file or folder",
		ParameterSetName='DisableInheritance'
	)]
	[switch]$DisableInheritance
)

	Begin{
		if ($SetAdminOwner){
				$objUser =  New-Object System.Security.Principal.NTAccount("$Principal")
			}

		if(!($PSBoundParameters.Keys -match ('SetAdminOwner|Reset|DisableInheritance'))) {
				$objUser = New-Object System.Security.Principal.NTAccount("$Principal")
				$objACE = New-Object System.Security.AccessControl.FileSystemAccessRule ("$objUser", "$Rights", "$InheritanceFlag", "$PropagationFlag", "$Access")
			}
		try{
            $objACL = Get-ACL -Path $Path -ErrorAction Stop
        }
        Catch{
			Write-Error -Message "Error retreiving ACL from path: $Path"
        }

	}
	Process{

		if ($SetAdminOwner){
			$objACL.SetOwner($objUser)
		}
		elseif ($Reset) {
			$($objACL.SetAccessRuleProtection($false, $false))
		}
		elseif ($DisableInheritance){
			$($objACL.SetAccessRuleProtection($true, $true))
		}
		else {
			Switch ($UpdateType)
				{
					Add       {$objACL.AddAccessRule($objACE) ; Break}
					Set       {$objACL.SetAccessRule($objACE) ; Break}
					Remove    {$objACL.RemoveAccessRule($objACE) ; Break}
					RemoveAll {$objACL.RemoveAccessRuleAll($objACE) ; Break}
				}
		}
            $shouldMessage = $(if($null -eq $objACE){$($objACE | Select-Object -property *)}else{$objACL | Select-Object -Property *})
			if($PSCmdlet.ShouldProcess("Attempting to Set-ACL for $Path with the following ACL: `n`n $shouldMessage")){
                #foreach($p in $path){
				    try{
                       Set-ACL -Path $path -AclObject $objACL -ErrorAction Stop
                    }
                    catch{
						Write-Error -Message "Error Setting ACL of: $shouldMessage on path: $Path"
                    }
                #}
			}
	}
	End{

	}
}