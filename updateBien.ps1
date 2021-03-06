function Hotfixreport { 
$computadoras = Get-Content C:\computadoras.txt 
$filename = "$env:D:\update\$computadora.txt"  
$ErrorActionPreference = 'Stop'   
ForEach ($computadora in $computadoras) {  
 
  try  
    { 
        
        $InputObject = $computadora       
        $Report = @()
        $filename = "$env:C:\update\$InputObject.txt"
        $InputObject | % {
        $objSession = [activator]::CreateInstance([type]::GetTypeFromProgID("Microsoft.Update.Session",$_))
        $objSearcher= $objSession.CreateUpdateSearcher()
        $HistoryCount = $objSearcher.GetTotalHistoryCount()
        $colSucessHistory = $objSearcher.QueryHistory(0, $HistoryCount)
        Foreach($objEntry in $colSucessHistory | where {$_.ResultCode -eq '2'}) {
        $pso = "" | select Computer,Title,Date
        $pso.Title = $objEntry.Title
        $pso.Date = $objEntry.Date
        $pso.computer = $_
        $Report += $pso
        }
        $objSession = $null
        }
        $Report | where { $_.Title -notlike 'Definition Update*'} | Export-Csv $filename -NoTypeInformation -UseCulture
        ii $filename
    } 
 
catch  
 
    { 
Add-content $computadora -path "$env:USERPROFILE\Desktop\Notreachable_Servers.txt"
    }  
} 
 
} 
ii $filename
Hotfixreport >> "$env:D:\update\$computadora.txt"
