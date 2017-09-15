###############################################################################
# Script to count objects in a regitrar Pool
# By Will Talbot 
# Version 1 - Written 14 Sept 2017, to assist with SBA Migration 
#
# Passing parameters:
# .\RegPool.ps1 PoolName
#
###############################################################################



param($getRegistrarPool)
 
 #Set DNS Suffix of Pool below
$DNSSuffix = "dir.ucb-group.com"

Function ListContents
{
    Param($Heading,$list)
 
    Write-Host $Heading"  "$getRegistrarPool
    Write-Host "--------------------------------------------------"
       $list.count
   Write-Host
 
}
 
clear-host

$getRegistrarPool =  $getRegistrarPool + "." + $DNSSuffix
 
Write-debug $getRegistrarPool
 
$csUsers=Get-CsUser -Filter {RegistrarPool -eq $getRegistrarPool} | Select-Object SipAddress | out-string -stream
$csAnalog=Get-CsAnalogDevice -Filter {RegistrarPool -eq $getRegistrarPool} | Select-Object SipAddress | out-string -stream
$csCAP=Get-CsCommonAreaPhone -Filter {RegistrarPool -eq $getRegistrarPool} | Select-Object SipAddress | out-string -stream
$csExUM=Get-CsExUmContact -Filter {RegistrarPool -eq $getRegistrarPool} | Select-Object SipAddress | out-string -stream
$csDialInConf=Get-CsDialInConferencingAccessNumber -Filter {Pool -eq $getRegistrarPool} | Select-Object PrimaryUri | out-string -stream
$csTrustedAppEnd=Get-CsTrustedApplicationEndpoint -Filter {RegistrarPool -eq $getRegistrarPool} | Select-Object SipAddress | out-string -stream
$csRGS=Get-CsRgsWorkflow | Where-Object {$_.OwnerPool -eq $getRegistrarPool} | Select-Object PrimaryUri | out-string -stream



 
if ($csUsers -ne $null){ListContents -Heading "Users" -list $csusers}
if ($csAnalog -ne $null){ListContents -Heading "Analog Devices" -list $csAnalog}
if ($csCAP -ne $null){ListContents -Heading "Common Area Phones" -list $csCAP}
if ($csExUM -ne $null){ListContents -Heading "Exchange UM Contact" -list $csExUM}
if ($csDialInConf -ne $null){ListContents -Heading "Dial-in Conference Numbers" -list $csDialInConf}
if ($csTrustedAppEnd -ne $null){ListContents -Heading "Trusted Application Endpoints" -list $csTrustedAppEnd}
if ($csRGS -ne $null){ListContents -Heading "Response Group Workflows" -list $csRGS}
