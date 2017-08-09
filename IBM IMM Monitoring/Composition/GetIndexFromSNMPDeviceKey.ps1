param($StartOID , $LogicalDeviceKey)

$oapi = New-Object -ComObject mom.scriptapi

$Bag = $oapi.CreatePropertyBag()
<#Regex Explained
	Regex Pattern
	(?n) = Regex option to only catch named groups
	^ = Beginning of the string
	(\.){0,1} = zero or one dot (".")
	$($StartOID.replace('.' , '\.') )= Replace any normal dot by a \. so regex interpretes it correctly (and not as a wildcard)
	\. = a dot
	(?<key>[\d\.]+?) = a named group, consisting of any combination of digits (0-9) and a dot (.). The entire group is named 'key'
	$ = End of the string, making sure all other characters are included

	Regex Replace
	${key} = the value gathered from the pattern in the 'key' group. Note that it needs to be enclosed in brackets in dotnet
#>
$Index = [regex]::replace($LogicalDeviceKey, "(?n)^(\.){0,1}$($StartOID.replace('.' , '\.') )\.(?<key>[\d\.]+?)$", '${key}' )
$Bag.AddValue('Index',  $Index)
$Bag