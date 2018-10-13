@{
	# Script module or binary module file associated with this manifest
	RootModule = 'ACLTools.psm1'

	# Version number of this module.

  ModuleVersion = '0.1.2'


	# ID used to uniquely identify this module
	GUID = '0395d5d8-418e-4a44-b400-ea7414608d20'

	# Author of this module
	Author = 'Joshua Corrick'

	# Company or vendor of this module
	CompanyName = 'Corrick.io'

	# Copyright statement for this module
	Copyright = 'Copyright (c) 2018 Joshua Corrick'

	# Description of the functionality provided by this module
	Description = 'Module for managing NTFS Acls on files and folders'

	# Minimum version of the Windows PowerShell engine required by this module
	PowerShellVersion = '3.0'

	# Name of the Windows PowerShell host required by this module
	# PowerShellHostName = ''

	# Minimum version of the Windows PowerShell host required by this module
	# PowerShellHostVersion = ''

	# Minimum version of the .NET Framework required by this module
	# DotNetFrameworkVersion = '2.0'

	# Minimum version of the common language runtime (CLR) required by this module
	# CLRVersion = '2.0.50727'

	# Processor architecture (None, X86, Amd64, IA64) required by this module
	# ProcessorArchitecture = 'None'

	# Modules that must be imported into the global environment prior to importing
	# this module
	<#RequiredModules = @(
		@{ ModuleName='PSFramework'; ModuleVersion='0.9.14.37' }
	)#>

	# Assemblies that must be loaded prior to importing this module
	# RequiredAssemblies = @()

	# Script files (.ps1) that are run in the caller's environment prior to
	# importing this module
	# ScriptsToProcess = @()

	# Type files (.ps1xml) to be loaded when importing this module
	# TypesToProcess = @('xml\ACLTools.Types.ps1xml')

	# Format files (.ps1xml) to be loaded when importing this module
	# FormatsToProcess = @('xml\ACLTools.Format.ps1xml')

	# Modules to import as nested modules of the module specified in
	# ModuleToProcess
	# NestedModules = @()

	# Functions to export from this module
	FunctionsToExport = @(
        'Update-ACL'
    )

	# Cmdlets to export from this module
	CmdletsToExport = ''

	# Variables to export from this module
	VariablesToExport = ''

	# Aliases to export from this module
	AliasesToExport = ''

	# List of all modules packaged with this module
	ModuleList = @()

	# List of all files packaged with this module
	FileList = @()

	# Private data to pass to the module specified in ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
	PrivateData = @{

		#Support for PowerShellGet galleries.
		PSData = @{

			# Tags applied to this module. These help with module discovery in online galleries.
			Tags = @('ACL','Security','NTFS','FileSystemRights')

			# A URL to the license for this module.
			LicenseUri = 'https://github.com/joshcorr/ACLTools/blob/master/LICENSE'

			# A URL to the main website for this project.
			ProjectUri = 'https://github.com/joshcorr/ACLTools'

			# A URL to an icon representing this module.
			# IconUri = ''

			# ReleaseNotes of this module
			# ReleaseNotes = ''

		} # End of PSData hashtable

	} # End of PrivateData hashtable
}
