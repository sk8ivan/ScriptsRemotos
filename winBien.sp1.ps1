function Hotfixreport { 
$computadoras = Get-Content C:\computadoras.txt 
$filename = "$env:D:\update\$computadora.txt"  
$ErrorActionPreference = 'Stop'   
ForEach ($computadora in $computadoras) {  
 
  try  
    { 
 (get-hotfix -cn $computadora | sort installedon | out-file "D:\win\$computadora.txt" ) 

  
    } 
 
catch  
 
    { 
#Add-content $computadora -path "$env:USERPROFILE\Desktop\Notreachable_Servers.txt"
    }  
}
 
} 
ii $filename
Hotfixreport >> "$env:D:\win\$computadora.txt"
