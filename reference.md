# powershell-glpi : Reference
## Table of contents
* [Properies](#properties)
* [InitSession](#initsession)
* [KillSession](#killsession)
* [LostPassword](#lostpassword)
* [GetMyProfiles](#getmyprofiles)
* [GetActiveProfile](#getactiveprofile)
* [ChangeActiveProfile](#changeactiveprofile)
* [GetMyEntities](#getmyentities)
* [GetActiveEntities](#getactiveentities)
* [ChangeActiveEntities](#changeactiveentities)
* [GetFullSession](#getfullsession)
* [GetGLPIConfig](#getglpiconfig)
* [GetAnItem](#getanitem)
* [GetAllItems](#getallitems)
* [GetSubItem](#getsubitem)
* [GetMultipleItem](#getmultipleitems)
* [ListSearchOptions](#listsearchoptions)
* [Search](#search)
* [AddItem](#additem)
* [UpdateItem](#updateitem)
* [DeleteItem](#deleteitem)
* [DownloadDocument](#downloaddocument)

## GLPI_API
```powershell
GLPI_API([string]$URL) 
```
```powershell
GLPI_API([string]$URL, [string]$AppToken) 
```
### Properties
- URL: [*string*]URL of the GLPI REST API
- Headers: [*hashtable*]Default headers for the HTTP requests, with 
`Content-Type`, `Session-Token` and optionnaly `App-Token`.
### Methods
#### InitSession
Authenticate to the API with a user-token and create a session.
```powershell
[void] InitSession([string]$UserToken)
```
**Parameters:**
- $UserToken: User-token provided by GLPI administration.

**Returns**

None.

```powershell
[void] InitSession([string]$UserToken, [hashtable]$Parameters)
```
**Parameters:**
- $UserToken: User-token provided by GLPI administration.
- $Parameters: Hash-table of the query parameters, should follow the format
`$Parameters["ParameterName"]=$Value`.

**Returns**

None.

More details on this request and its parameters: [GLPI Documentation](https://github.com/glpi-project/glpi/blob/10.0/bugfixes/apirest.md#init-session).
#### KillSession
Ends the session.
```powershell
[void] KillSession()
```
**Returns**

None.

More details on this request and its parameters: [GLPI Documentation](https://github.com/glpi-project/glpi/blob/10.0/bugfixes/apirest.md#kill-session).
#### GetMyProfiles
Get available profiles for the logged user.
```powershell
[pscustomobject] GetMyProfiles()
```
**Returns**

HTTP response.

More details on this request and its parameters: [GLPI Documentation](https://github.com/glpi-project/glpi/blob/10.0/bugfixes/apirest.md#get-my-profiles).
#### GetActiveProfile
Get the profile currently used by this API session.
```powershell
[pscustomobject] GetActiveProfile()
```
**Returns**

HTTP response.

More details on this request and its parameters: [GLPI Documentation](https://github.com/glpi-project/glpi/blob/10.0/bugfixes/apirest.md#get-active-profile).
#### ChangeActiveProfile
Switches to another profile.
```powershell
[void] ChangeActiveProfile($ID)
```
**Parameters:**
- $ID: ID of the profile to use.
**Returns**

None.

More details on this request and its parameters: [GLPI Documentation](https://github.com/glpi-project/glpi/blob/10.0/bugfixes/apirest.md#change-active-profile).
#### GetMyEntities
Selects entities of the logged user.
```powershell
[pscustomobject] GetMyEntities()
```
**Returns**

HTTP response.
```powershell
[pscustomobject] GetMyEntities([hashtable]$Parameters)
```
**Parameters:**
- $Parameters: Hash-table of the query parameters, should follow the format
`$Parameters["ParameterName"]=$Value`.

**Returns**

HTTP response.

More details on this request and its parameters: [GLPI Documentation](https://github.com/glpi-project/glpi/blob/10.0/bugfixes/apirest.md#get-my-entities).
#### GetActiveEntities
Selects active entities of the logged user.
```powershell
[pscustomobject] GetActiveEntities()
```
**Returns**

HTTP response.

More details on this request and its parameters: [GLPI Documentation](https://github.com/glpi-project/glpi/blob/10.0/bugfixes/apirest.md#get-active-entities).
#### ChangeActiveEntities
Switches to another available entity.
```powershell
[void] ChangeActiveEntities($ID)
```
**Parameters:**
- $ID: ID of the entity to use.

**Returns**

None.
```powershell
[void] ChangeActiveEntities($ID, [hashtable]$Parameters)
```
**Parameters:**
- $ID: ID of the entity to use.
- $Parameters: Hash-table of the query parameters, should follow the format
`$Parameters["ParameterName"]=$Value`.

**Returns**

None.

More details on this request and its parameters: [GLPI Documentation](https://github.com/glpi-project/glpi/blob/10.0/bugfixes/apirest.md#change-active-entities).
#### GetFullSession
Returns the current PHP session.
```powershell
[pscustomobject] GetFullSession()
```
**Returns**

HTTP response.

More details on this request and its parameters: [GLPI Documentation](https://github.com/glpi-project/glpi/blob/10.0/bugfixes/apirest.md#get-full-session).
#### GetGLPIConfig
Returns the GLPI configuration informations.
```powershell
[pscustomobject] GetGLPIConfig()
```
**Returns**

HTTP response.

More details on this request and its parameters: [GLPI Documentation](https://github.com/glpi-project/glpi/blob/10.0/bugfixes/apirest.md#get-glpi-config).
#### GetAnItem
Selects an item based on its category and its ID.
```powershell
[pscustomobject] GetAnItem([string]$ItemType, $ID)
```
**Parameters:**
- $ItemType: Type of the selected item (computer, ticket, user, ...).
- $ID: ID of the selected item.

**Returns**

HTTP response.

```powershell
[pscustomobject] GetAnItem([string]$ItemType, $ID, [hashtable]$Parameters)
```
**Parameters:**
- $ItemType: Type of the selected item (computer, ticket, user, ...).
- $ID: ID of the selected item.
- $Parameters: Hash-table of the query parameters, should follow the format
`$Parameters["ParameterName"]=$Value`.

**Returns**

HTTP response.

More details on this request and its parameters: [GLPI Documentation](https://github.com/glpi-project/glpi/blob/10.0/bugfixes/apirest.md#get-an-item).
#### GetAllItems
Selects every item of a category.
```powershell
[pscustomobject] GetAllItems([string]$ItemType)
```
**Parameters:**
- $ItemType: Type of the selected item (computer, ticket, user, ...).

**Returns**

HTTP response.
```powershell
[pscustomobject] GetAllItems([string]$ItemType, [hashtable]$Parameters)
```
**Parameters:**
- $ItemType: Type of the selected item (computer, ticket, user, ...).
- $Parameters: Hash-table of the query parameters, should follow the format
`$Parameters["ParameterName"]=$Value`.

**Returns**

HTTP response.

More details on this request and its parameters: [GLPI Documentation](https://github.com/glpi-project/glpi/blob/10.0/bugfixes/apirest.md#get-all-items).
#### GetSubItems
Selects a sub-item of an item.
```powershell
[pscustomobject] GetSubItem([string]$ItemType, $ID, [string]$SubItemType)
```
**Parameters:**
- $ItemType: Type of the selected item (computer, ticket, user, ...).
- $ID: ID of the selected item.
- $SubItemType: Type of the sub-item (infocom, item_devices, item_disks).

**Returns**

HTTP response.
```powershell
[pscustomobject] GetSubItem([string]$ItemType, $ID, [string]$SubItemType, [hashtable]$Parameters)
```
**Parameters:**
- $ItemType: Type of the selected item (computer, ticket, user, ...).
- $ID: ID of the selected item.
- $SubItemType: Type of the sub-item (infocom, item_devices, item_disks).
- $Parameters: Hash-table of the query parameters, should follow the format
`$Parameters["ParameterName"]=$Value`.

**Returns**

HTTP response.

More details on this request and its parameters: [GLPI Documentation](https://github.com/glpi-project/glpi/blob/10.0/bugfixes/apirest.md#get-sub-items).
#### GetMultipleItems
Get a list of item.
```powershell
[pscustomobject] GetMultipleItems([array]$Items)
```
**Parameters:**
- $Items: Array of the selected items'ID

**Returns**

HTTP response.
```powershell
[pscustomobject] GetMultipleItems([array]$Items, [hashtable]$Parameters)
```
**Parameters:**
- $Items: Array of the selected items' ID, should follow the format
`@(@{"itemtype"="type1";"items_id"=$id1}, ...)`
- $Parameters: Hash-table of the query parameters, should follow the format
`$Parameters["ParameterName"]=$Value`.

**Returns**

HTTP response.

More details on this request and its parameters: [GLPI Documentation](https://github.com/glpi-project/glpi/blob/10.0/bugfixes/apirest.md#get-multiple-items).
#### ListSearchOptions
Lists the search options for a category.
```powershell
[pscustomobject] ListSearchOptions([string]$ItemType)
```
**Parameters:**
- $ItemType: Type of the selected category (computer, ticket, user, ...).

**Returns**

HTTP response.
```powershell
[pscustomobject] ListSearchOptions([string]$ItemType, [bool]$raw)
```
**Parameters:**
- $ItemType: Type of the selected category (computer, ticket, user, ...).
- $raw: Boolean to control wether the response is formated or not.

**Returns**

HTTP response.

More details on this request and its parameters: [GLPI Documentation](https://github.com/glpi-project/glpi/blob/10.0/bugfixes/apirest.md#list-searchoptions).
#### Search
Proceeds to a search based on a query.
```powershell
[pscustomobject] Search([string]$ItemType, [array]$Criteria)
```
**Parameters:**
- $ItemType: Type of the selected item (computer, ticket, user, ...).
- $Criteria: Array of criteria.

**Returns**

HTTP response.
```powershell
[pscustomobject] Search([string]$ItemType, [array]$Criteria, [hashtable]$Parameters)
```
**Parameters:**
- $ItemType: Type of the selected item (computer, ticket, user, ...).
- $Criteria: Array of criteria.
- $Parameters: Hash-table of the query parameters, should follow the format
`$Parameters["ParameterName"]=$Value`.

**Returns**

HTTP response.

More details on this request and its parameters: [GLPI Documentation](https://github.com/glpi-project/glpi/blob/10.0/bugfixes/apirest.md#search-items).
#### AddItem
Adds an item.
```powershell
[pscustomobject] AddItem([string]$ItemType, $Payload)
```
**Parameters:**
- $ItemType: Type of the selected item (computer, ticket, user, ...).
- $Payload: Array of new items and their values, should follow the format
`@(@{"field1-1"="value"; "field1-2"="value"; ...}, ...)`. If one item only is 
added, an array is not necessary and the payload can simply be a hashtable.

**Returns**

HTTP response.

More details on this request and its parameters: [GLPI Documentation](https://github.com/glpi-project/glpi/blob/10.0/bugfixes/apirest.md#add-items).
#### UpdateItem
Changes some values of an item or a list of items.
```powershell
[pscustomobject] UpdateItem([string]$ItemType, $ID, $Payload)
```
**Parameters:**
- $ItemType: Type of the selected item (computer, ticket, user, ...).
- $ID: ID of the item to update. Used if only one item is updated.
- $Payload: Array of updated items and their values, should follow the format
`@(@{"id"=$id1; "field1-1"="value"; "field1-2"="value"; ...}, ...)`. If one
item only is updated, an array is not necessary and the payload can simply be a
hashtable.

**Returns**

HTTP response.
```powershell
[pscustomobject] UpdateItem([string]$ItemType, $Payload)
```
**Parameters:**
- $ItemType: Type of the selected item (computer, ticket, user, ...).
- $Payload: Array of updated items and their values, should follow the format
`@(@{"id"=$id1; "field1-1"="value"; "field1-2"="value"; ...}, ...)`. If one
item only is updated, an array is not necessary and the payload can simply be a
hashtable.

**Returns**

HTTP response.
```powershell
[pscustomobject] UpdateItem([string]$ItemType, $ID, $Payload, [hashtable]$Parameters)
```
**Parameters:**
- $ItemType: Type of the selected item (computer, ticket, user, ...).
- $ID: ID of the item to upload. Used if only one item is updated.
- $Payload: Array of updated items and their values, should follow the format
`@(@{"id"=$id1; "field1-1"="value"; "field1-2"="value"; ...}, ...)`. If one
item only is updated, an array is not necessary and the payload can simply be a
hashtable.
- $Parameters: Hash-table of the query parameters, should follow the format
`$Parameters["ParameterName"]=$Value`.

**Returns**

HTTP response.
```powershell
[pscustomobject] UpdateItem([string]$ItemType, $Payload, [hashtable]$Parameters)
```
**Parameters:**
- $ItemType: Type of the selected item (computer, ticket, user, ...).
- $Payload: Array of updated items and their values, should follow the format
`@(@{"id"=$id1; "field1-1"="value"; "field1-2"="value"; ...}, ...)`. If one
item only is updated, an array is not necessary and the payload can simply be a
hashtable.
- $Parameters: Hash-table of the query parameters, should follow the format
`$Parameters["ParameterName"]=$Value`.

**Returns**

HTTP response.

More details on this request and its parameters: [GLPI Documentation](https://github.com/glpi-project/glpi/blob/10.0/bugfixes/apirest.md#update-items).
#### DeleteItem
Deletes an item or a list of items.
```powershell
[pscustomobject] DeleteItem([string]$ItemType, $ID)
```
**Parameters:**
- $ItemType: Type of the selected item (computer, ticket, user, ...).
- $ID: ID of the single item to delete.

**Returns**

HTTP response.
```powershell
[pscustomobject] DeleteItem([string]$ItemType, $Payload)
```
**Parameters:**
- $ItemType: Type of the selected item (computer, ticket, user, ...).
- $Payload: Array of deleted items and their values, should follow the format
`@(@{"id"=$id1}, @{"id"=$id2}, ..., @{"id"=$idn})`. If one
item only is deleted, an array is not necessary and the payload can simply be a
hashtable.

**Returns**

HTTP response.
```powershell
[pscustomobject] DeleteItem([string]$ItemType, $ID, [hashtable]$Parameters)
```
**Parameters:**
- $ItemType: Type of the selected item (computer, ticket, user, ...).
- $ID: ID of the single item to delete.
- $Parameters: Hash-table of the query parameters, should follow the format
`$Parameters["ParameterName"]=$Value`.

**Returns**

HTTP response.
```powershell
[pscustomobject] DeleteItem([string]$ItemType, $Payload, [hashtable]$Parameters)
```
**Parameters:**
- $ItemType: Type of the selected item (computer, ticket, user, ...).
- $Payload: Array of deleted items and their values, should follow the format
`@(@{"id"=$id1}, @{"id"=$id2}, ..., @{"id"=$idn})`. If one
item only is updated, an array is not necessary and the payload can simply be a
hashtable.
- $Parameters: Hash-table of the query parameters, should follow the format
`$Parameters["ParameterName"]=$Value`.

**Returns**

HTTP response.

More details on this request and its parameters: [GLPI Documentation](https://glpi.it3.fr/apirest.php#delete-items).
#### DownloadDocument
Downloads a document based on its ID in the document category.
```powershell
[pscustomobject] DownloadDocument($ID)
```
**Parameters:**
- $ID: ID of the document to download.

**Returns**

HTTP response.

More details on this request and its parameters: [GLPI Documentation](https://github.com/glpi-project/glpi/blob/10.0/bugfixes/apirest.md#download-a-document-file).
