<#
    Net Check - is the internet working, and is it slow?

    Distinguishes the three failures that need different responses:
      no local network  -> your router or cable
      no DNS            -> resolver problem, internet itself is fine
      no internet       -> your line or your ISP
#>
$ErrorActionPreference = 'SilentlyContinue'

function Ping-Ms($target) {
    $r = Test-Connection -ComputerName $target -Count 2 -Quiet:$false -ErrorAction SilentlyContinue
    if (-not $r) { return $null }
    $times = $r | ForEach-Object { if ($null -ne $_.Latency) { $_.Latency } else { $_.ResponseTime } }
    $avg = ($times | Measure-Object -Average).Average
    if ($null -eq $avg) { return $null }
    return [math]::Round($avg)
}

$gateway = (Get-NetRoute -DestinationPrefix '0.0.0.0/0' -ErrorAction SilentlyContinue |
            Sort-Object RouteMetric | Select-Object -First 1).NextHop

$gatewayMs = if ($gateway) { Ping-Ms $gateway } else { $null }
$netMs     = Ping-Ms '1.1.1.1'
$dnsOk     = [bool](Resolve-DnsName 'cloudflare.com' -QuickTimeout -ErrorAction SilentlyContinue)

if ($null -eq $gatewayMs -and $gateway) {
    Write-Output "I can't reach your router, so this looks like a local network problem."
}
elseif ($null -eq $netMs) {
    Write-Output "Your local network is fine but nothing is getting out - that looks like your line or your provider."
}
elseif (-not $dnsOk) {
    Write-Output ("The internet is reachable at {0} milliseconds, but DNS isn't resolving - that's a name server problem." -f $netMs)
}
else {
    $quality = if ($netMs -lt 30) { 'good' } elseif ($netMs -lt 80) { 'fine' } else { 'slow' }
    Write-Output ("Internet is up and looking {0} - {1} milliseconds to Cloudflare." -f $quality, $netMs)
}
