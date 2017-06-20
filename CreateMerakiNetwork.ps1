Remove-Variable * -ErrorAction SilentlyContinue
$error.Clear()

$proxyUri = [Uri]$null
$proxy = [System.Net.WebRequest]::GetSystemWebProxy()
if ($proxy)
{
    $proxyUri = $proxy.GetProxy("https://www.google.com")
}

$headers = @{ 'X-Cisco-Meraki-API-Key' = 'KEY' }
$body = @{ 'name' = 'NETWORKNAME'; 'type' = 'wireless'; 'timeZone' = 'America/Chicago' ; 'tags' = 'TAG' }
$jsbody = ConvertTo-Json $body
$url = "https://dashboard/api/v0/organizations/ORGID/networks"
if ("$proxyUri" -ne "$url")
{   
 try{
    write-host "Using Proxy: $proxyuri"
    Invoke-RestMethod -Uri $url -Headers $headers -Body $jsbody -method Post -ContentType 'Application/Json' -Proxy $proxyuri -ProxyUseDefaultCredentials
 }
 catch{
    $err = $_
    write-host $err.exception
 }
}




#Read-Host "Press any key to exit..." 



