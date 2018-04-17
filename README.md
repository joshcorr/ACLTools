# Description

ACLTools is a Module that contains the missing Update-ACL cmdlet for PowerShell.
The module structure was created using the PSFramework(https://github.com/PowershellFrameworkCollective) by https://github.com/FriedrichWeinmann.

Written by Joshua Corrick (@joshCorr). Licensed under MIT. 2018

## Build Status
<table>
    <tbody>
        <tr>
            <td><img align="left" src="https://corrickcode.visualstudio.com/_apis/public/build/definitions/ea27adb2-57cd-4762-a87b-14bccd302059/2/badge"></td>
            <td>Development Branch</td>
        </tr>
        <tr>
            <td><img align="left" src="https://corrickcode.visualstudio.com/_apis/public/build/definitions/ea27adb2-57cd-4762-a87b-14bccd302059/1/badge"></td>
            <td>Master Branch</td>
        </tr>
        <tr>
            <td><img align="left" src="https://corrickcode.vsrm.visualstudio.com/_apis/public/Release/badge/ea27adb2-57cd-4762-a87b-14bccd302059/2/2"></td>
            <td>Released to PowerShell Gallery</td>
        </tr>
    </tbody>
</table>

## Syntax and Use

Update-ACL can be used in a few different ways:

Add, Update, or Remove a specific ACL
```PS C:\windows\System32> Update-ACL -Path C:\temp\file.txt -Principal 'josh' -Rights ReadAndExecute,ReadPermissions -InheritanceFlag none -PropagationFlag none -Access Allow -UpdateType Add```

Set the Owner
```Update-ACL -Path C:\temp\file.txt -Principal 'josh' -SetAdminOwner```

Reset the Inheritance on the item
```Update-ACL -Path C:\temp\file.txt -Reset```

Disable Inheritance on an item or path
```Update-ACL -Path C:\temp\file.txt -DisableInheritance```