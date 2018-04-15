# Description

ACLTools is a Module that contains the missing Update-ACL cmdlet for PowerShell.

Update-ACL can be used in a few different ways:

Add, Update, or Remove a specific ACL
```PS C:\windows\System32> Update-ACL -Path C:\temp\file.txt -Principal 'josh' -Rights ReadAndExecute,ReadPermissions -InheritanceFlag none -PropagationFlag none -Access Allow -UpdateType Add```

Set the Owner
```Update-ACL -Path C:\temp\file.txt -Principal 'josh' -SetAdminOwner```

Reset the Inheritance on the item
```Update-ACL -Path C:\temp\file.txt -Reset```

Disable Inheritance on an item or path
```Update-ACL -Path C:\temp\file.txt -DisableInheritance```

The module structure was created using the PSFramework (https://github.com/PowershellFrameworkCollective) by https://github.com/FriedrichWeinmann.

Written by Joshua Corrick (@joshCorr)
Licensed under MIT. 2018