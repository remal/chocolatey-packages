$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

foreach($line in Get-Content "$toolsPath/hosts-forbidden.txt") {
  $line = $line.Trim()
  if ($line -ne '') {
    & hosts remove $line
  }
}
