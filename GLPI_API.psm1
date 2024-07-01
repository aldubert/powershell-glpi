<#
    .SYNOPSIS
        A PowerShell module to interract with GLPI REST API.
    .EXAMPLE
        using module /path/to/your/powershell-glpi/GLPI_API.psm1

        $Glpi = [GLPI_API]::new('http://path/to/glpi/apirest.php')
        $SessionToken = $Glpi.InitSession('YourUserToken')
        Write-Host "Successfuly connected to API with token: $SessionToken"

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
    .LINK
        Github repository: https://github.com/aldubert/powershell-glpi
    .NOTES
        Author: Alexandre Dubert
#>
class GLPI_API {
    # Properties
    [string]    $URL
    [hashtable] $Headers

    # Constructors
    GLPI_API([string]$URL) { 
        $this.URL = $URL
        $this.Headers = @{}
        $this.Headers.Add("Content-Type", "application/json")
    }
    GLPI_API([string]$URL, [string]$AppToken) { 
        $this.URL = $URL
        $this.Headers = @{}
        $this.Headers.Add("Content-Type", "application/json")
        $this.Headers.Add("App-Token", "$AppToken")
    }
    
    # Methods
    [void] InitSession([string]$UserToken) {
        # Not using $this.Headers to keep it fitted for most of the requests    
        $InitHeaders = @{}
        $InitHeaders.Add("Content-Type", "application/json")
        $InitHeaders.Add("Authorization", "user_token $UserToken")

        $response = Invoke-RestMethod `
            "$($this.URL)/initSession" -Method 'GET' -Headers $InitHeaders
        $this.Headers.Add("Session-Token", $response.session_token)
    }

    # TOFIX
    <# [pscustomobject] InitSession([string]$Login, [securestring]$Password) {
        # Not using $this.Headers to keep it fitted for most of the requests
        $InitHeaders = @{}
        $InitHeaders.Add("Content-Type", "application/json")
        $AuthInfoBytes = 
            [System.Text.Encoding]::Unicode.GetBytes("$($Login):$Password")
        $AuthInfoBase64 = [Convert]::ToBase64String($AuthInfoBytes)
        $InitHeaders.Add("Authorization", "Basic $AuthInfoBase64")

        $response = Invoke-RestMethod `
            "$($this.URL)/initSession" -Method 'GET' -Headers $InitHeaders
        $this.Headers.Add("Session-Token", $response.session_token)
    } #>

    [void] InitSession([string]$UserToken, [hashtable]$Parameters) {
        # Not using $this.Headers to keep it fitted for most of the requests    
        $InitHeaders = @{}
        $InitHeaders.Add("Content-Type", "application/json")
        $InitHeaders.Add("Authorization", "user_token $UserToken")

        $QueryString = $($this.ParseParameters($Parameters))

        $response = Invoke-RestMethod `
            "$($this.URL)/initSession?$QueryString" `
            -Method 'GET' -Headers $InitHeaders

        $this.Headers.Add("Session-Token", $response.session_token)
    }

    # TOFIX
    <# [void] InitSession([string]$Login, [secureString]$Password, 
    [hashtable]$Parameters) {
        # Not using $this.Headers to keep it fitted for most of the requests
        $InitHeaders = @{}
        $InitHeaders.Add("Content-Type", "application/json")
        $InitHeaders.Add("Authorization", "Basic $($Login):$Password")

        $QueryString = $($this.ParseParameters($Parameters))

        $response = Invoke-RestMethod `
            "$($this.URL)/initSession?$QueryString" `
            -Method 'GET' -Headers $InitHeaders

        $this.Headers.Add("Session-Token", $response.session_token)
        return $response
    } #>

    [void] KillSession() {
        Invoke-RestMethod `
            "$($this.URL)/killSession" -Method 'GET' -Headers $this.Headers
    }

    [pscustomobject] GetMyProfiles() {
        $response = Invoke-RestMethod `
            "$($this.URL)/getMyProfiles" -Method 'GET' -Headers $this.Headers
        return $response.myprofiles
    }

    [pscustomobject] GetActiveProfile() {
        $response = Invoke-RestMethod `
            "$($this.URL)/getActiveProfile" `
            -Method 'GET' -Headers $this.Headers
        return $response.active_profile
    }

    [void] ChangeActiveProfile($ID) {
        $body = "{`"profiles_id`": $ID}"

        Invoke-RestMethod `
            "$($this.URL)/changeActiveProfile" `
            -Method 'POST' -Headers $this.Headers -Body $body
    }

    [pscustomobject] GetMyEntities() {
        $response = Invoke-RestMethod `
            "$($this.URL)/getMyEntities" -Method 'GET' -Headers $this.Headers
        return $response.myentities
    }

    [pscustomobject] GetMyEntities([hashtable]$Parameters) {
        $QueryString = $($this.ParseParameters($Parameters))

        $response = Invoke-RestMethod `
            "$($this.URL)/getMyEntities?$QueryString" `
            -Method 'GET' -Headers $this.Headers
        return $response.myentities
    }

    [pscustomobject] GetActiveEntities() {
        $response = Invoke-RestMethod `
            "$($this.URL)/getActiveEntities" `
            -Method 'GET' -Headers $this.Headers
        return $response.active_entity
    }

    [void] ChangeActiveEntities($ID) {
        $body = "{`"profiles_id`": $ID}"

        Invoke-RestMethod `
            "$($this.URL)/changeActiveEntities" `
            -Method 'POST' -Headers $this.Headers -Body $body
    }

    [void] ChangeActiveEntities($ID, [hashtable]$Parameters) {
        $key = $Parameters.Keys[0]
        $value = $Parameters[$key].ToString()
        $body = "{`"profiles_id`": $ID, `"$key`": `"$value`"}"

        Invoke-RestMethod `
            "$($this.URL)/changeActiveEntities" `
            -Method 'POST' -Headers $this.Headers -Body $body
    }

    [pscustomobject] GetFullSession() {
        $response = Invoke-RestMethod `
            "$($this.URL)/getFullSession" `
            -Method 'GET' -Headers $this.Headers
        return $response.session
    }

    [pscustomobject] GetGLPIConfig() {
        $response = Invoke-RestMethod `
            "$($this.URL)/getGlpiConfig" `
            -Method 'GET' -Headers $this.Headers
        return $response.cfg_glpi
    }

    [pscustomobject] GetAnItem([string]$ItemType, $ID) {
        return Invoke-RestMethod `
            "$($this.URL)/$ItemType/$ID" `
            -Method 'GET' -Headers $this.Headers
    }

    [pscustomobject] GetAnItem([string]$ItemType, $ID, 
    [hashtable]$Parameters) {
        $QueryString = $this.ParseParameters($Parameters)

        return Invoke-RestMethod `
            "$($this.URL)/$ItemType/$($ID)?$QueryString" `
            -Method 'GET' -Headers $this.Headers
    }

    [pscustomobject] GetAllItems([string]$ItemType) {
        return Invoke-RestMethod `
            "$($this.URL)/$ItemType" `
            -Method 'GET' -Headers $this.Headers
    }

    [pscustomobject] GetAllItems([string]$ItemType, 
    [hashtable]$Parameters) {
        $QueryString = $this.ParseParameters($Parameters)

        return Invoke-RestMethod `
            "$($this.URL)/$ItemType/?$QueryString" `
            -Method 'GET' -Headers $this.Headers
    }
    
    [pscustomobject] GetSubItem([string]$ItemType, $ID, [string]$SubItemType) {
        return Invoke-RestMethod `
            "$($this.URL)/$ItemType/$ID/$SubItemType" `
            -Method 'GET' -Headers $this.Headers
    }

    [pscustomobject] GetSubItem([string]$ItemType, $ID, [string]$SubItemType, 
    [hashtable]$Parameters) {
        $QueryString = $this.ParseParameters($Parameters)

        return Invoke-RestMethod `
            "$($this.URL)/$ItemType/$ID/$($SubItemType)?$QueryString" `
            -Method 'GET' -Headers $this.Headers
    }

    [pscustomobject] GetMultipleItems([array]$Items) {
        $ItemQuery = $this.ParseItems($Items)

        return Invoke-RestMethod `
            "$($this.URL)/getMultipleItems?$ItemQuery" `
            -Method 'GET' -Headers $this.Headers
    }

    [pscustomobject] GetMultipleItems([array]$Items, [hashtable]$Parameters) {
        $ItemQuery = $this.ParseItems($Items)
        $QueryString = "$ItemQuery&$($this.ParseParameters($Parameters))"

        return Invoke-RestMethod `
            "$($this.URL)/getMultipleItems?$QueryString" `
            -Method 'GET' -Headers $this.Headers
    }

    [pscustomobject] ListSearchOptions([string]$ItemType) {
        return Invoke-RestMethod `
            "$($this.URL)/listSearchOptions/$ItemType" `
            -Method 'GET' -Headers $this.Headers
    }

    [pscustomobject] ListSearchOptions([string]$ItemType, [bool]$raw) {
        $QueryString = ""
        if ($raw) {$QueryString = "?raw"}

        return Invoke-RestMethod `
            "$($this.URL)/listSearchOptions/$ItemType$QueryString" `
            -Method 'GET' -Headers $this.Headers
    }

    [pscustomobject] Search([string]$ItemType, [array]$Criteria) {
        $CriteriaQuery = $this.ParseCriteria($Criteria)

        return Invoke-RestMethod `
            "$($this.URL)/search/$($ItemType)?$CriteriaQuery" `
            -Method 'GET' -Headers $this.Headers
    }

    [pscustomobject] Search([string]$ItemType, [array]$Criteria, 
    [hashtable]$Parameters) {
        $CriteriaQuery = $this.ParseCriteria($Criteria)
        $QueryString = "$CriteriaQuery&$($this.ParseParameters($Parameters))"

        return Invoke-RestMethod `
            "$($this.URL)/search/$($ItemType)?$QueryString" `
            -Method 'GET' -Headers $this.Headers
    }

    [pscustomobject] AddItem([string]$ItemType, $Payload) {
        $JsonPayload = @{ "input" = $Payload } | ConvertTo-Json

        return Invoke-RestMethod `
            "$($this.URL)/$ItemType/" `
            -Method 'POST' -Headers $this.Headers -Body $JsonPayload
    }

    [pscustomobject] UpdateItem([string]$ItemType, $ID, $Payload) {
        $JsonPayload = @{ "input" = $Payload } | ConvertTo-Json

        return Invoke-RestMethod `
            "$($this.URL)/$ItemType/$ID" `
            -Method 'PUT' -Headers $this.Headers -Body $JsonPayload
    }

    [pscustomobject] UpdateItem([string]$ItemType, $Payload) {
        $JsonPayload = @{ "input" = $Payload } | ConvertTo-Json

        return Invoke-RestMethod `
            "$($this.URL)/$ItemType/" `
            -Method 'PUT' -Headers $this.Headers -Body $JsonPayload
    }

    [pscustomobject] UpdateItem([string]$ItemType, $ID, $Payload,
    [hashtable]$Parameters) {
        $JsonPayload = @{ "input" = $Payload } | ConvertTo-Json
        $QueryString = $this.ParseParameters($Parameters)

        return Invoke-RestMethod `
            "$($this.URL)/$ItemType/$($ID)?$QueryString" `
            -Method 'PUT' -Headers $this.Headers -Body $JsonPayload
    }

    [pscustomobject] UpdateItem([string]$ItemType, $Payload,
    [hashtable]$Parameters) {
        $JsonPayload = @{ "input" = $Payload } | ConvertTo-Json
        $QueryString = $this.ParseParameters($Parameters)

        return Invoke-RestMethod `
            "$($this.URL)/$ItemType/?$QueryString" `
            -Method 'PUT' -Headers $this.Headers -Body $JsonPayload
    }

    [pscustomobject] DeleteItem([string]$ItemType, $ID) {
        return Invoke-RestMethod `
            "$($this.URL)/$ItemType/$ID" `
            -Method 'DELETE' -Headers $this.Headers
    }

    [pscustomobject] DeleteItem([string]$ItemType, [hashtable] $Payload) {
        $JsonPayload = @{ "input" = $Payload } | ConvertTo-Json

        return Invoke-RestMethod `
            "$($this.URL)/$ItemType/" `
            -Method 'DELETE' -Headers $this.Headers -Body $JsonPayload
    }

    [pscustomobject] DeleteItem([string]$ItemType, $ID, 
    [hashtable]$Parameters) {
        $QueryString = $this.ParseParameters($Parameters)

        return Invoke-RestMethod `
            "$($this.URL)/$ItemType/$($ID)?$QueryString" `
            -Method 'DELETE' -Headers $this.Headers
    }

    [pscustomobject] DeleteItem([string]$ItemType, [hashtable] $Payload, 
    [hashtable]$Parameters) {
        $JsonPayload = @{ "input" = $Payload } | ConvertTo-Json
        $QueryString = $this.ParseParameters($Parameters)

        return Invoke-RestMethod `
            "$($this.URL)/$ItemType/?$QueryString" `
            -Method 'DELETE' -Headers $this.Headers -Body $JsonPayload
    }

    # TOFIX
    <# [pscustomobject] UploadDocument([string]$FileName, [string]$Path) {
        # Not using $this.Headers to keep it fitted for most of the requests   
        $UploadHeaders = @{}
        $UploadHeaders["Session-Token"] = $this.Headers["Session-Token"]
        if ($null -ne $this.Headers["App-Token"]) {
            $UploadHeaders["App-Token"] = $this.Headers["App-Token"]
        }
        $UploadHeaders["Content-Type"] = "multipart/form-data"
        $UploadHeaders["Accept"] = "application/json"

        $Form = @{
            'uploadManifest'=
                "{""input"":{""name"":""$FileName"","+
                """_filename"":[""$Path""]},""type"":""application/json""}"
            'filename[0]'=@($Path)
        } 

        return Invoke-RestMethod `
            "$($this.URL)/Document/" `
            -Method 'POST' -Headers $UploadHeaders -Form $Form -Verbose
    } #>

    [pscustomobject] DownloadDocument($ID) {
        return Invoke-RestMethod `
            "$($this.URL)/Document/$($ID)?alt=media" `
            -Method 'GET' -Headers $this.Headers
    }

    # Internal methods
    <#
        .SYNOPSIS
            Formats a hashtable of parameters to a web request parameter list.
        .EXAMPLE
            Input:
            @{ "expand_dropdowns"=$true; "with_infocoms"=$true }
            Output:
            "expand_dropdowns=true&with_infocoms=true"
    #>
    hidden [string] ParseParameters([hashtable]$parameters) {
        $formatedParameters = ""
        foreach ($p in $parameters.Keys) {
            $formatedParameters = `
            "$formatedParameters&$p=$($parameters[$p].ToString())"
        }
        return $formatedParameters.Substring(1) # Removing first '&'
    }
    <#
        .SYNOPSIS
            Formats an array to a web request list.
        .EXAMPLE
            Input:
            @(@{"field1" = "bonjour"; "field2" = 1}, 
            @{"field1" = "hello"; "field2" = 2})
            Output:
            arrayname[0][field1]=bonjour&arrayname[0][field2]=1& `
            arrayname[1][field1]=hello&arrayname[1][field2]=2
    #>
    hidden [string] ParseArray([array]$array, [string]$arrayName) {
        $formatedArray = ""
        for ($i = 0; $i -lt $array.Count; $i++) {
            foreach ($field in $array[$i].Keys) {
                $formatedArray +=
                    "&$arrayName[$i][$field]=$($array[$i][$field])"
            }
        }
        return $formatedArray.Substring(1) # Removing first '&'
    }
    hidden [string] ParseItems([array]$items) {
        return $this.ParseArray($items, "items")
    }
    hidden [string] ParseCriteria([array]$criteria) {
        # TODO : Nested criteria
        return $this.ParseArray($criteria, "criteria")
    }
}