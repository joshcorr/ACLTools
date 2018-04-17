<#
This script publishes the module to the gallery.
It expects as input an ApiKey authorized to publish the module.

Insert any build steps you may need to take before publishing it here.
#>
param (
	$ApiKey,
	[switch]$WhatIf
)

if ($WhatIf) { Publish-Module -Path "$($env:SYSTEM_DEFAULTWORKINGDIRECTORY)\ACLTools\ACLTools" -NuGetApiKey $ApiKey -Force -WhatIf }
else { Publish-Module -Path "$($env:SYSTEM_DEFAULTWORKINGDIRECTORY)\ACLTools\ACLTools" -NuGetApiKey $ApiKey -Force }