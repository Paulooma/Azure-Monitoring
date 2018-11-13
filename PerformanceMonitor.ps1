<#
# Script: Get-Counter
# Author: Paul Oyemakinwa
# Comments: This script will collect the specific counters value from the target machines/servers 
which will be used to analayze the performance of target servers.
#>


$ComputerName = WEu-P-SQL4 
$pathmon = "C:\PerfMonitor.txt"
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}

function Global:Convert-HString {      
[CmdletBinding()]            
 Param             
   (
    [Parameter(Mandatory=$false,
               ValueFromPipeline=$true,
               ValueFromPipelineByPropertyName=$true)]
    [String]$HString
   )#End Param
   Begin 
{
    Write-Verbose "Converting Here-String to Array"
}#Begin
Process 
{
    $HString -split "`n" | ForEach-Object {
    
        $ComputerName = $_.trim()
        if ($ComputerName -notmatch "#")
            {
                $ComputerName
            }    
        
        
        }
}#Process
End 
{
    # Nothing to do here.
}#End

}#Convert-HString


#Performance counters declaration

<#function Get-CounterStats { 
param 
    ( 
    [String]$ComputerName = $ENV:ComputerName
    
    )#> 

$Object =@()

$Counter = @" 
\PhysicalDisk(*)\Current Disk Queue Length
\PhysicalDisk(*)\% Disk Time
\PhysicalDisk(*)\Avg. Disk Queue Length
\PhysicalDisk(*)\% Disk Read Time
\PhysicalDisk(*)\Avg. Disk Read Queue Length
\PhysicalDisk(*)\% Disk Write Time
\PhysicalDisk(*)\Avg. Disk Write Queue Length
\PhysicalDisk(*)\Avg. Disk sec/Transfer
\PhysicalDisk(*)\Avg. Disk sec/Read
\PhysicalDisk(*)\Avg. Disk sec/Write
\PhysicalDisk(*)\Disk Transfers/sec
\PhysicalDisk(*)\Disk Reads/sec
\PhysicalDisk(*)\Disk Writes/sec
\PhysicalDisk(*)\Disk Bytes/sec
\PhysicalDisk(*)\Disk Read Bytes/sec
\PhysicalDisk(*)\Disk Write Bytes/sec
\PhysicalDisk(*)\Avg. Disk Bytes/Transfer
\PhysicalDisk(*)\Avg. Disk Bytes/Read
\PhysicalDisk(*)\Avg. Disk Bytes/Write
\PhysicalDisk(*)\% Idle Time
\PhysicalDisk(*)\Split IO/Sec
"@ 

 (Get-Counter  -Counter (Convert-HString -HString $Counter)).counterSamples | ForEach-Object { 
        $path = $_.path 
        New-Object PSObject -Property @{
        computerName=$ComputerName;
        Counter        = $path.Trim("\\$ComputerName")| ForEach-Object{"\" + $_} ;
        } 
        
        } | Out-File -FilePath $pathmon

        Write-Host "PLEASE CHECK THE C:\perfMonitor.txt FOR THE OUTPUT"




        #Discover the Available Counter on the Azure Performance Counter
Get-Counter -ListSet * | Select-Object CounterSetName, Paths | Sort-Object CounterSetName


Premium P30 (Twice) 1023GB

Get-AzureVM –ServiceName $serviceName –Name $vmName |Add-AzureEndpoint –Name "Remote Desktop" –Protocol tcp –Localport 3389 -PublicPort 50100 |Update-AzureVM