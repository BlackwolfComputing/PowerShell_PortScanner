function PortScanner($hostname,$PortRange)
{
  Write-Host "Checking ports on $hostname"
  $ErrorActionPreference = "SilentlyContinue"
  $test = Test-Connection –BufferSize 32 –Count 1 -Quiet –ComputerName $hostname
  $Results = @()
    if ($test) {
    $IP = (Test-Connection –Count 1  –ComputerName $hostname).IPV4Address.IPAddressToString
    Write-Host "IP Resolved to $IP"
      foreach($port in $PortRange){
      Write-Host "Checking Port $Port"
      $socket = $null
      $socket = new-object System.Net.Sockets.TcpClient($ip, $port)
      if (!($Socket -eq $null)) {
      $socket | Add-Member -Name "Port" -MemberType NoteProperty -Value $port -Force
      $Results += $socket }
    }
    Return $Results
  } else {Write-Host "$hostname OFFLINE" -ForegroundColor Red -BackgroundColor Yellow}
}
