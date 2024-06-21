# powershell-glpi
A PowerShell module to interract with GLPI REST API.

## Prerequisites
To be able to connect to the API and interract with it, you first need to allow
API in GLPI administration tab and then retrieve a User Token and optionnaly
an App Session.

## Installation
Just clone the repository wherever you want. For now, installation through
PowerShell Gallery isn't supported.

## Usage
Here is an example of a connection and a few simple requests.
```powershell
using module /path/to/your/powershell-glpi/GLPI_API.psm1

$Glpi = [GLPI_API]::new('http://path/to/glpi/apirest.php')
$SessionToken = $Glpi.InitSession('YourUserToken')
Write-Host "Successfuly connected to GLPI API with token: $SessionToken"

$Glpi.GetActiveProfile()
$Glpi.GetAnItem("computer", 
    "55", 
    @{"expand_dropdowns"=$true; "with_infocoms"=$true}
)
$Glpi.UpdateItem(
    "computer", 
    @(@{"id" = 560; "comment"="text"}, @{"id" = 562; "comment"="text"})
)

$Glpi.KillSession()
```
For more details read [the reference](https://github.com/aldubert/powershell-glpi/blob/main/reference.md).

## Auteur
Alexandre Dubert