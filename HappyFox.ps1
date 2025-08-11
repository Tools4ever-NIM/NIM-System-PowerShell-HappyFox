#
# HappyFox.ps1 - HappyFox
#
$Log_MaskableKeys = @(
    'Password',
    "proxy_password"
)

$Global:AssetsCacheTime = Get-Date
$Global:ContactsCacheTime = Get-Date
$Global:ContactGroupsCacheTime = Get-Date
$Global:Assets = [System.Collections.ArrayList]@()
$Global:Contacts = [System.Collections.ArrayList]@()
$Global:ContactGroups = [System.Collections.ArrayList]@()

$Properties = @{
    Assets = @(
        @{ name = 'id';           						    options = @('default','key')}    
        @{ name = 'display_id';           				options = @('default')}    
        @{ name = 'name';           					options = @('default')}
        @{ name = 'created_by';           		            options = @('default')}
        @{ name = 'asset_type_id';           				options = @('default')}
        @{ name = 'asset_type_name';           				options = @('default')}
        @{ name = 'updated_by';           					options = @('default')}
    )
    AssetsContacts = @(
        @{ name = 'key_id';           			            options = @('default','key')}    
        @{ name = 'id';           						    options = @('default')}
        @{ name = 'name';           						options = @('default')}
        @{ name = 'email';           						options = @('default')}
        @{ name = 'assets_id';           			        options = @('default')}
    )
    AssetsCustomFields = @(
        @{ name = 'key_id';           			            options = @('default','key')}    
        @{ name = 'id';           						    options = @('default')}
        @{ name = 'name';           						options = @('default')}
        @{ name = 'type';           						options = @('default')}
        @{ name = 'order';           						options = @('default')}
        @{ name = 'value';           						options = @('default')}
        @{ name = 'assets_id';           			        options = @('default')}
    )
    AssetsTypes = @(
        @{ name = 'id';           						    options = @('default','key')}    
        @{ name = 'display_id';           				    options = @('default')}    
        @{ name = 'description';           				    options = @('default')}    
        @{ name = 'name';           					    options = @('default')}
        @{ name = 'settings_enable_ticket_association';     options = @('default')}
        @{ name = 'settings_enable_contact_association';    options = @('default')}
        @{ name = 'settings_enable_asset_quantity_for_ticket';	options = @('default')}
    )
    Categories = @(
        @{ name = 'id';           						    options = @('default','key')}    
        @{ name = 'prepopulate_cc';           				options = @('default')}    
        @{ name = 'description';           					options = @('default')}
        @{ name = 'time_spent_mandatory';           		options = @('default')}
        @{ name = 'public';           						options = @('default')}
        @{ name = 'name';           						options = @('default')}
    )
    Contacts = @(
        @{ name = 'id';           						    options = @('default','key')}
        @{ name = 'name';           						options = @('default','create','update')}
        @{ name = 'is_login_enabled';           			options = @('default','update')}
        @{ name = 'primary_phone_id';           			options = @('default')}
        @{ name = 'primary_phone_number';           		options = @('default')}
        @{ name = 'primary_phone_type';           			options = @('default')}
        @{ name = 'created_at';           					options = @('default')}
        @{ name = 'updated_at';           					options = @('default')}
        @{ name = 'pending_tickets_count';           		options = @('default')}
        @{ name = 'tickets_count';           				options = @('default')}
        @{ name = 'email';           						options = @('default','create','update')}
    )
    ContactsCustomFields = @(
        @{ name = 'key_id';           			            options = @('default','key')}    
        @{ name = 'id';           						    options = @('default','create','update')}
        @{ name = 'name';           						options = @('default')}
        @{ name = 'type';           						options = @('default')}
        @{ name = 'value';           						options = @('default','create','update')}
        @{ name = 'value_id';           					options = @('default')}
        @{ name = 'value_to_staff_only';           			options = @('default')}
        @{ name = 'contacts_id';           			        options = @('default','create','update')}
    )
    ContactsPhones = @(
        @{ name = 'key_id';           			            options = @('default','key')}    
        @{ name = 'id';           						    options = @('default')}
        @{ name = 'is_primary';       						options = @('default')}
        @{ name = 'type';           						options = @('default')}
        @{ name = 'number';           						options = @('default')}
        @{ name = 'contacts_id';           			        options = @('default')}
    )
    ContactGroups = @(
        @{ name = 'id';           						    options = @('default','key')}
        @{ name = 'tagged_domains';       					options = @('default','create','update')}
        @{ name = 'description';           					options = @('default','create','update')}
        @{ name = 'name';           						options = @('default','create','update')}
    )
    ContactGroupMembers = @(
        @{ name = 'key_id';           						options = @('default','key')}
        @{ name = 'group_id';           					options = @('default','add')}
        @{ name = 'id';           						    options = @('default','add')}
        @{ name = 'email';       					        options = @('default')}
        @{ name = 'view_tickets_in_group';           		options = @('default','add')}
    )
    KBArticles = @(
        @{ name = 'id';           						    options = @('default','key')}
        @{ name = 'attachments';           				    options = @('default')}
        @{ name = 'language_visible';           			options = @('default')}
        @{ name = 'language_enabled';           			options = @('default')}
        @{ name = 'language_id';           					options = @('default')}
        @{ name = 'language_name';           				options = @('default')}
        @{ name = 'views';       					        options = @('default')}
        @{ name = 'title';           		                options = @('default')}
        @{ name = 'section_id';           					options = @('default')}
        @{ name = 'slug';           						options = @('default')}
        @{ name = 'last_updated_at';           				options = @('default')}
        @{ name = 'tags';           						options = @('default')}
        @{ name = 'section_name';           				options = @('default')}
        @{ name = 'full_url';           					options = @('default')}
        @{ name = 'contents';           					options = @('default')}
        @{ name = 'related_articles';           			options = @('default')}
    )
    KBInternalArticles = @(
        @{ name = 'id';           						    options = @('default','key')}
        @{ name = 'attachments';           				    options = @()} # Future: Convert to Table of objects
        @{ name = 'language_visible';           			options = @('default')}
        @{ name = 'language_enabled';           			options = @('default')}
        @{ name = 'language_id';           					options = @('default')}
        @{ name = 'language_name';           				options = @('default')}
        @{ name = 'views';       					        options = @('default')}
        @{ name = 'title';           		                options = @('default')}
        @{ name = 'section_id';           					options = @('default')}
        @{ name = 'slug';           						options = @('default')}
        @{ name = 'last_updated_at';           				options = @('default')}
        @{ name = 'tags';           						options = @('default')}
        @{ name = 'section_name';           				options = @('default')}
        @{ name = 'full_url';           					options = @('default')}
        @{ name = 'contents';           					options = @('default')}
        @{ name = 'related_articles';           			options = @()}
    )
    KBSections = @(
        @{ name = 'id';           						    options = @('default','key')}
        @{ name = 'parent_section_name';           			options = @('default')}
        @{ name = 'articles';           			        options = @()}
        @{ name = 'description';           			        options = @('default')}
        @{ name = 'parent_section_id';           			options = @('default')}
        @{ name = 'categories';           				    options = @()} # Future: Convert to Table of objects
        @{ name = 'name';       					        options = @('default')}
    )
    Staff = @(
        @{ name = 'id';           						    options = @('default','key')}
        @{ name = 'name';           			            options = @('default')}
        @{ name = 'is_account_admin';           			options = @('default')}
        @{ name = 'email';           			            options = @('default')}
        @{ name = 'role_name';       					    options = @('default')}
        @{ name = 'role_id';       					        options = @('default')}
        @{ name = 'active';       					        options = @('default')}
        @{ name = 'categories';       					    options = @('default')}
        @{ name = 'permissions';       					    options = @('default')}
    )
    Statuses = @(
        @{ name = 'id';           						    options = @('default','key')}
        @{ name = 'name';           			            options = @('default')}
        @{ name = 'color';           			            options = @('default')}
        @{ name = 'order';           			            options = @('default')}
        @{ name = 'default';       					        options = @('default')}
        @{ name = 'behavior';       					    options = @('default')}
    )
    Tickets = @(
        @{ name = 'id';           						    options = @('default','key')}
        @{ name = 'category';           			        options = @('default')}
        @{ name = 'contact';           			            options = @('default')}
        @{ name = 'group';           			            options = @('default')}
        @{ name = 'assignee';       					    options = @('default')}
        @{ name = 'status';       					        options = @('default')}
        @{ name = 'priority';       					    options = @('default')}
        @{ name = 'duedate';       					        options = @('default')}
        @{ name = 'tag';       					            options = @('default')}
        @{ name = 'has_attachments';       					options = @('default')}
        @{ name = 'breached';       					    options = @('default')}
        @{ name = 'unresponded';       					    options = @('default')}
    )
    TicketCustomFields = @(
        @{ name = 'id';           						    options = @('default','key')}
        @{ name = 'name';           			            options = @('default')}
        @{ name = 'depends_on_choice';           			options = @('default')}
        @{ name = 'required';           			        options = @('default')}
        @{ name = 'type';       					        options = @('default')}
        @{ name = 'compulsory_on_completed';       			options = @('default')}
        @{ name = 'compulsory_on_move';       			    options = @('default')}
        @{ name = 'choices';       					        options = @()} # Future: Convert to Table of objects
        @{ name = 'categories';       					    options = @()} # Future: Convert to Table of objects
        @{ name = 'order';       					        options = @('default')}
        @{ name = 'visible_to_staff_only';       			options = @('default')}
    )
    UserCustomFields = @(
        @{ name = 'id';           						    options = @('default','key')}
        @{ name = 'name';           			            options = @('default')}
        @{ name = 'depends_on_choice';           			options = @('default')}
        @{ name = 'required';           			        options = @('default')}
        @{ name = 'type';       					        options = @('default')}
        @{ name = 'choices';       					        options = @()} # Future: Convert to Table of objects
        @{ name = 'order';       					        options = @('default')}
        @{ name = 'visible_to_staff_only';       			options = @('default')}
    )
    
}

#
# System functions
#
function Idm-SystemInfo {
    param (
        # Operations
        [switch] $Connection,
        [switch] $TestConnection,
        [switch] $Configuration,
        # Parameters
        [string] $ConnectionParams
    )

    Log info "-Connection=$Connection -TestConnection=$TestConnection -Configuration=$Configuration -ConnectionParams='$ConnectionParams'"

    if ($Connection) {
        @(
            @{
                name = 'hostname'
                type = 'textbox'
                label = 'Hostname'
                description = ''
                value = 'customer.happyfox.com'
            }
            @{
                name = 'username'
                type = 'textbox'
                label = 'Username'
                label_indent = $true
                tooltip = 'User account'
                value = ''
            }
            @{
                name = 'password'
                type = 'textbox'
                password = $true
                label = 'Password'
                label_indent = $true
                tooltip = 'User account password'
                value = ''
            }
            @{
                name = 'use_proxy'
                type = 'checkbox'
                label = 'Use Proxy'
                description = 'Use Proxy server for requests'
                value = $false # Default value of checkbox item
            }
            @{
                name = 'proxy_address'
                type = 'textbox'
                label = 'Proxy Address'
                description = 'Address of the proxy server'
                value = 'http://127.0.0.1:8888'
                disabled = '!use_proxy'
                hidden = '!use_proxy'
            }
            @{
                name = 'use_proxy_credentials'
                type = 'checkbox'
                label = 'Use Proxy Credentials'
                description = 'Use credentials for proxy'
                value = $false
                disabled = '!use_proxy'
                hidden = '!use_proxy'
            }
            @{
                name = 'proxy_username'
                type = 'textbox'
                label = 'Proxy Username'
                label_indent = $true
                description = 'Username account'
                value = ''
                disabled = '!use_proxy_credentials'
                hidden = '!use_proxy_credentials'
            }
            @{
                name = 'proxy_password'
                type = 'textbox'
                password = $true
                label = 'Proxy Password'
                label_indent = $true
                description = 'User account password'
                value = ''
                disabled = '!use_proxy_credentials'
                hidden = '!use_proxy_credentials'
            }
            @{
                name = 'nr_of_retries'
                type = 'textbox'
                label = 'Max. number of retry attempts'
                description = ''
                value = 5
            }
            @{
                name = 'retryDelay'
                type = 'textbox'
                label = 'Seconds to wait for retry'
                description = ''
                value = 2
            }
            @{
                name = 'nr_of_sessions'
                type = 'textbox'
                label = 'Max. number of simultaneous sessions'
                description = ''
                value = 1
            }
            @{
                name = 'sessions_idle_timeout'
                type = 'textbox'
                label = 'Session cleanup idle time (minutes)'
                description = ''
                value = 1
            }
        )
    }

    if ($TestConnection) {
        
    }

    if ($Configuration) {
        @()
    }

    Log info "Done"
}

function Idm-OnUnload {
}

#
# Object CRUD functions
#

function Idm-assetsRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'Assets'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {

            if(     $Global:Assets.count -lt 1 `
                    -or ( ((Get-Date) - $Global:AssetsCacheTime) -gt (new-timespan -minutes 5) ) 
            ) {   

                $uri = "https://$($system_params.hostname)/api/1.1/json/assets/"
                

            
                $splat = @{
                    SystemParams = $system_params
                    Method = "GET"
                    Uri = $uri                    
                    Body = $null
                }

                
                $response = Execute-HappyFoxRequest @splat
                
                foreach($rowItem in $response) {
                    [void]$Global:Assets.Add($rowItem)
                }

                $Global:AssetsCacheTime = Get-Date
            }
            
            $properties = ($Global:Properties.$Class).name
                $hash_table = [ordered]@{}

                foreach ($prop in $properties.GetEnumerator()) {
                    $hash_table[$prop] = ""
                }

                foreach($rowItem in $Global:Assets) {
                    $row = New-Object -TypeName PSObject -Property $hash_table

                    foreach($prop in $rowItem.PSObject.properties) {
                        if($prop.Name -eq 'asset_type') {
                            $row.asset_type_id = $prop.Value.id
                            $row.asset_type_name = $prop.Value.name
                        }

                        if(!$properties.contains($prop.Name)) { continue }
                        
                        $row.($prop.Name) = $prop.Value
                        
                    }

                    $row
                }
            
        }
}

function Idm-assets_contactsRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'AssetsContacts'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {

            if(     $Global:Assets.count -lt 1 `
                    -or ( ((Get-Date) - $Global:AssetsCacheTime) -gt (new-timespan -minutes 5) ) 
            ) {   

                Idm-assetsRead -SystemParams $SystemParams -FunctionParams $FunctionParams | Out-Null
            }
            
            $properties = ($Global:Properties.$Class).name
            $hash_table = [ordered]@{}

            foreach ($prop in $properties.GetEnumerator()) {
                $hash_table[$prop] = ""
            }

            foreach($asset in $Global:Assets) {
                foreach($rowItem in $asset.contacts) {
                    $row = New-Object -TypeName PSObject -Property $hash_table
                    $row.assets_id = $asset.id
                    $row.key_id = "$($asset.id).$($rowItem.id)"
                    foreach($prop in $rowItem.PSObject.properties) {
                        if(!$properties.contains($prop.Name)) { continue }
                        
                        $row.($prop.Name) = $prop.Value
                        
                    }

                    $row
                }
            }
        }
}

function Idm-assets_custom_fieldsRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'AssetsCustomFields'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {

            if(     $Global:Assets.count -lt 1 `
                    -or ( ((Get-Date) - $Global:AssetsCacheTime) -gt (new-timespan -minutes 5) ) 
            ) {   

                Idm-assetsRead -SystemParams $SystemParams -FunctionParams $FunctionParams | Out-Null
            }
            
            $properties = ($Global:Properties.$Class).name
            $hash_table = [ordered]@{}

            foreach ($prop in $properties.GetEnumerator()) {
                $hash_table[$prop] = ""
            }

            foreach($asset in $Global:Assets) {
                foreach($rowItem in $asset.custom_fields) {
                    $row = New-Object -TypeName PSObject -Property $hash_table
                    $row.assets_id = $asset.id
                    $row.key_id = "$($asset.id).$($rowItem.id)"
                    foreach($prop in $rowItem.PSObject.properties) {
                        if(!$properties.contains($prop.Name)) { continue }
                        
                        $row.($prop.Name) = $prop.Value
                        
                    }

                    $row
                }
            }
        }
}

function Idm-assetTypesRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'AssetsTypes'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {
            $uri = "https://$($system_params.hostname)/api/1.1/json/asset_types/"
            
            $splat = @{
                SystemParams = $system_params
                Method = "GET"
                Uri = $uri                    
                Body = $null
            }

            
            $response = Execute-HappyFoxRequest @splat
            
            $properties = ($Global:Properties.$Class).name
            $hash_table = [ordered]@{}

            foreach ($prop in $properties.GetEnumerator()) {
                $hash_table[$prop] = ""
            }

            foreach($rowItem in $response) {
                $row = New-Object -TypeName PSObject -Property $hash_table

                foreach($prop in $rowItem.PSObject.properties) {
                    if($prop.Name -eq "settings") {
                        $row.settings_enable_ticket_association = $prop.Value.enable_ticket_association
                        $row.settings_enable_contact_association = $prop.Value.enable_contact_association
                        $row.settings_enable_asset_quantity_for_ticket = $prop.Value.enable_asset_quantity_for_ticket
                    }
                    if(!$properties.contains($prop.Name)) { continue }
                    
                    $row.($prop.Name) = $prop.Value
                    
                }

                $row
            }
        }
}
function Idm-categoriesRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'Categories'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {
            $uri = "https://$($system_params.hostname)/api/1.1/json/categories/"
            
            $splat = @{
                SystemParams = $system_params
                Method = "GET"
                Uri = $uri                    
                Body = $null
            }

            
            $response = Execute-HappyFoxRequest @splat
            
            $properties = ($Global:Properties.$Class).name
            $hash_table = [ordered]@{}

            foreach ($prop in $properties.GetEnumerator()) {
                $hash_table[$prop] = ""
            }

            foreach($rowItem in $response) {
                $row = New-Object -TypeName PSObject -Property $hash_table

                foreach($prop in $rowItem.PSObject.properties) {
                    if(!$properties.contains($prop.Name)) { continue }
                    
                    $row.($prop.Name) = $prop.Value
                    
                }

                $row
            }
        }
}

function Idm-contactsRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'Contacts'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {

            if(     $Global:Contacts.count -lt 1 `
                    -or ( ((Get-Date) - $Global:ContactsCacheTime) -gt (new-timespan -minutes 5) ) 
            ) {   

                $uri = "https://$($system_params.hostname)/api/1.1/json/users/"

                $splat = @{
                    SystemParams = $system_params
                    Method = "GET"
                    Uri = $uri                    
                    Body = $null
                }

                
                $response = Execute-HappyFoxRequest @splat
                
                foreach($rowItem in $response) {
                    [void]$Global:Contacts.Add($rowItem)
                }

                $Global:ContactsCacheTime = Get-Date
            }
            
            $properties = ($Global:Properties.$Class).name
                $hash_table = [ordered]@{}

                foreach ($prop in $properties.GetEnumerator()) {
                    $hash_table[$prop] = ""
                }

                foreach($rowItem in $Global:Contacts) {
                    $row = New-Object -TypeName PSObject -Property $hash_table

                    foreach($prop in $rowItem.PSObject.properties) {
                        if($prop.Name -eq 'primary_phone') {
                            $row.primary_phone_id = $prop.Value.id
                            $row.primary_phone_number = $prop.Value.number
                            $row.primary_phone_type = $prop.Value.type
                        }

                        if(!$properties.contains($prop.Name)) { continue }
                        
                        $row.($prop.Name) = $prop.Value
                        
                    }

                    $row
                }
            
        }
}

function Idm-contactsCreate {
    param (
        # Operations
        [switch] $GetMeta,
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams
    )

    Log info "-GetMeta=$GetMeta -SystemParams='$SystemParams' -FunctionParams='$FunctionParams'"
    $Class = 'Contacts'

    if ($GetMeta) {
        #
        # Get meta data
        #
        @{
            semantics = 'create'
            parameters = @(
                ($Global:Properties.$Class | Where-Object { $_.options.Contains('create') }) | ForEach-Object {
                    @{ name = $_.name;  allowance = 'mandatory' }
                }

                $Global:Properties.$Class | Where-Object { !$_.options.Contains('create') } | ForEach-Object {
                    @{ name = $_.name; allowance = 'prohibited' }
                }
            )
        }
    }
    else {
        #
        # Execute function
        #
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams

        $uri = "https://$($system_params.hostname)/api/1.1/json/users/"

        $splat = @{
            SystemParams = $system_params
            Method = "POST"
            Uri = $uri                    
            Body = ($function_params | ConvertTo-Json)
        }

        Execute-HappyFoxRequest @splat

    }

    Log info "Done"
}

function Idm-contactsUpdate {
    param (
        # Operations
        [switch] $GetMeta,
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams
    )

    Log info "-GetMeta=$GetMeta -SystemParams='$SystemParams' -FunctionParams='$FunctionParams'"
    $Class = 'Contacts'

    if ($GetMeta) {
        #
        # Get meta data
        #
        @{
            semantics = 'update'
            parameters = @(
                ($Global:Properties.$Class | Where-Object { $_.options.Contains('key') }) | ForEach-Object {
                    @{ name = $_.name;  allowance = 'mandatory' }
                }
            
                ($Global:Properties.$Class | Where-Object { $_.options.Contains('update') }) | ForEach-Object {
                    @{ name = $_.name;  allowance = 'optional' }
                }

                $Global:Properties.$Class | Where-Object { !$_.options.Contains('key') -and !$_.options.Contains('update') } | ForEach-Object {
                    @{ name = $_.name; allowance = 'prohibited' }
                }
            )
        }
    }
    else {
        #
        # Execute function
        #
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams

        $key = ($Global:Properties.$Class | Where-Object { $_.options.Contains('key') }).name

        $uri = "https://$($system_params.hostname)/api/1.1/json/user/$($function_params.$key)/"

        $splat = @{
            SystemParams = $system_params
            Method = "POST"
            Uri = $uri                    
            Body = ($function_params | ConvertTo-Json)
        }
        
        Execute-HappyFoxRequest @splat

    }

    Log info "Done"
}

function Idm-contacts_custom_fieldsRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'ContactsCustomFields'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {

            if(     $Global:Contacts.count -lt 1 `
                    -or ( ((Get-Date) - $Global:ContactsCacheTime) -gt (new-timespan -minutes 5) ) 
            ) {   

                Idm-contactsRead -SystemParams $SystemParams -FunctionParams $FunctionParams | Out-Null
            }
            
            $properties = ($Global:Properties.$Class).name
            $hash_table = [ordered]@{}

            foreach ($prop in $properties.GetEnumerator()) {
                $hash_table[$prop] = ""
            }

            foreach($contact in $Global:Contacts) {
                foreach($rowItem in $contact.custom_fields) {
                    $row = New-Object -TypeName PSObject -Property $hash_table
                    $row.contacts_id = $contact.id
                    $row.key_id = "$($contact.id).$($rowItem.id)"
                    foreach($prop in $rowItem.PSObject.properties) {
                        if(!$properties.contains($prop.Name)) { continue }
                        
                        $row.($prop.Name) = $prop.Value
                        
                    }

                    $row
                }
            }
        }
}

function Idm-contacts_custom_fieldsCreate {
    param (
        # Operations
        [switch] $GetMeta,
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams
    )

    Log info "-GetMeta=$GetMeta -SystemParams='$SystemParams' -FunctionParams='$FunctionParams'"
    $Class = 'ContactsCustomFields'

    if ($GetMeta) {
        #
        # Get meta data
        #
        @{
            semantics = 'create'
            parameters = @(           
                ($Global:Properties.$Class | Where-Object { $_.options.Contains('create') }) | ForEach-Object {
                    @{ name = $_.name;  allowance = 'optional' }
                }

                $Global:Properties.$Class | Where-Object { $_.options.Contains('key') -or !$_.options.Contains('create') } | ForEach-Object {
                    @{ name = $_.name; allowance = 'prohibited' }
                }
            )
        }
    }
    else {
        #
        # Execute function
        #
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams

        $contacts_id = $function_params.contacts_id
        $field_id = $function_params.id

        # Retrieve Current Custom Fields to avoid clearly fields not specified
        $uri = "https://$($system_params.hostname)/api/1.1/json/user/$($contacts_id)/"

        $splat = @{
            SystemParams = $system_params
            Method = "GET"
            Uri = $uri                    
            Body = $null
        }
        
        $userData = Execute-HappyFoxRequest @splat
        
        $payload = @{}
        foreach($field in $userData.custom_fields) {
            $payload["c-cf-$($field.id)"] = $field.value
            
            if($field.id -eq $field_id) {
                $payload["c-cf-$($field.id)"] = $function_params.value
            } else {
                $payload["c-cf-$($field.id)"] = $field.value
            }
        }

        logIO info ($payload | ConvertTo-Json)

        $splat = @{
            SystemParams = $system_params
            Method = "POST"
            Uri = $uri                    
            Body = ($payload | ConvertTo-Json)
        }

        $response = Execute-HappyFoxRequest @splat

        $obj = @{
            key_id = "$($contacts_id).$($field_id)"
            contacts_id = $contacts_id
        }

        foreach($prop in ($response.custom_fields | Where-Object { $_.id -eq $field_id }).PSObject.Properties ) {
            $obj[$prop.Name] = $prop.Value
        }

        LogIO info $obj
        [PSCustomObject]$obj
    }

    Log info "Done"
}

function Idm-contacts_custom_fieldsUpdate {
    param (
        # Operations
        [switch] $GetMeta,
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams
    )

    Log info "-GetMeta=$GetMeta -SystemParams='$SystemParams' -FunctionParams='$FunctionParams'"
    $Class = 'ContactsCustomFields'

    if ($GetMeta) {
        #
        # Get meta data
        #
        @{
            semantics = 'update'
            parameters = @(
                ($Global:Properties.$Class | Where-Object { $_.options.Contains('key') }) | ForEach-Object {
                    @{ name = $_.name;  allowance = 'mandatory' }
                }
            
                ($Global:Properties.$Class | Where-Object { $_.options.Contains('update') }) | ForEach-Object {
                    @{ name = $_.name;  allowance = 'optional' }
                }

                $Global:Properties.$Class | Where-Object { !$_.options.Contains('key') -and !$_.options.Contains('update') } | ForEach-Object {
                    @{ name = $_.name; allowance = 'prohibited' }
                }
            )
        }
    }
    else {
        #
        # Execute function
        #
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams

        $key = ($Global:Properties.$Class | Where-Object { $_.options.Contains('key') }).name
        $contacts_id = $function_params.$key.split('.')[0]
        $field_id = $function_params.$key.split('.')[1]

        # Retrieve Current Custom Fields to avoid clearly fields not specified
        $uri = "https://$($system_params.hostname)/api/1.1/json/user/$($contacts_id)/"

        $splat = @{
            SystemParams = $system_params
            Method = "GET"
            Uri = $uri                    
            Body = $null
        }
        
        $userData = Execute-HappyFoxRequest @splat
        
        $payload = @{}
        foreach($field in $userData.custom_fields) {
            $payload["c-cf-$($field.id)"] = $field.value
            
            if($field.id -eq $field_id) {
                $payload["c-cf-$($field.id)"] = $function_params.value
            } else {
                $payload["c-cf-$($field.id)"] = $field.value
            }
        }

        logIO info ($payload | ConvertTo-Json)

        $splat = @{
            SystemParams = $system_params
            Method = "POST"
            Uri = $uri                    
            Body = ($payload | ConvertTo-Json)
        }

        $response = Execute-HappyFoxRequest @splat

        $obj = @{
            key_id = $function_params.$key
            contacts_id = $contacts_id
        }
        
        foreach($prop in ($response.custom_fields | Where-Object { $_.id -eq $field_id }).PSObject.Properties ) {
            $obj[$prop.Name] = $prop.Value
        }
        
        LogIO info $obj
        [PSCustomObject]$obj
    }

    Log info "Done"
}

function Idm-contacts_phonesRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'ContactsPhones'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {

            if(     $Global:Contacts.count -lt 1 `
                    -or ( ((Get-Date) - $Global:ContactsCacheTime) -gt (new-timespan -minutes 5) ) 
            ) {   

                Idm-contactsRead -SystemParams $SystemParams -FunctionParams $FunctionParams | Out-Null
            }
            
            $properties = ($Global:Properties.$Class).name
            $hash_table = [ordered]@{}

            foreach ($prop in $properties.GetEnumerator()) {
                $hash_table[$prop] = ""
            }

            foreach($contact in $Global:Contacts) {
                foreach($rowItem in $contact.phones) {
                    $row = New-Object -TypeName PSObject -Property $hash_table
                    $row.contacts_id = $contact.id
                    $row.key_id = "$($contact.id).$($rowItem.id)"
                    foreach($prop in $rowItem.PSObject.properties) {
                        if(!$properties.contains($prop.Name)) { continue }
                        
                        $row.($prop.Name) = $prop.Value
                        
                    }

                    $row   
                }
            }
        }
}
function Idm-contactGroupsRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'ContactGroups'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {

            if(     $Global:ContactGroups.count -lt 1 `
                    -or ( ((Get-Date) - $Global:ContactGroupsCacheTime) -gt (new-timespan -minutes 5) ) 
            ) {   

                $uri = "https://$($system_params.hostname)/api/1.1/json/contact_groups/"
                

            
                $splat = @{
                    SystemParams = $system_params
                    Method = "GET"
                    Uri = $uri                    
                    Body = $null
                }

                
                $response = Execute-HappyFoxRequest @splat
                
                foreach($rowItem in $response) {
                    [void]$Global:ContactGroups.Add($rowItem)
                }

                $Global:ContactGroupsCacheTime = Get-Date
            }
            
            $properties = ($Global:Properties.$Class).name
                $hash_table = [ordered]@{}

                foreach ($prop in $properties.GetEnumerator()) {
                    $hash_table[$prop] = ""
                }

                foreach($rowItem in $Global:ContactGroups) {
                    $row = New-Object -TypeName PSObject -Property $hash_table

                    foreach($prop in $rowItem.PSObject.properties) {
                        if(!$properties.contains($prop.Name)) { continue }
                        
                        $row.($prop.Name) = $prop.Value
                        
                    }

                    $row
                }
            
        }
}

function Idm-contactGroupsCreate {
    param (
        # Operations
        [switch] $GetMeta,
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams
    )

    Log info "-GetMeta=$GetMeta -SystemParams='$SystemParams' -FunctionParams='$FunctionParams'"
    $Class = 'ContactGroups'

    if ($GetMeta) {
        #
        # Get meta data
        #
        @{
            semantics = 'create'
            parameters = @(
                ($Global:Properties.$Class | Where-Object { $_.options.Contains('create') }) | ForEach-Object {
                    @{ name = $_.name;  allowance = 'mandatory' }
                }

                $Global:Properties.$Class | Where-Object { !$_.options.Contains('create') } | ForEach-Object {
                    @{ name = $_.name; allowance = 'prohibited' }
                }
            )
        }
    }
    else {
        #
        # Execute function
        #
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams

        $uri = "https://$($system_params.hostname)/api/1.1/json/contact_groups/"

        $splat = @{
            SystemParams = $system_params
            Method = "POST"
            Uri = $uri                    
            Body = ($function_params | ConvertTo-Json)
        }

        Execute-HappyFoxRequest @splat

    }

    Log info "Done"
}

function Idm-contactGroupsUpdate {
    param (
        # Operations
        [switch] $GetMeta,
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams
    )

    Log info "-GetMeta=$GetMeta -SystemParams='$SystemParams' -FunctionParams='$FunctionParams'"
    $Class = 'ContactGroups'

    if ($GetMeta) {
        #
        # Get meta data
        #
        @{
            semantics = 'update'
            parameters = @(
                ($Global:Properties.$Class | Where-Object { $_.options.Contains('key') }) | ForEach-Object {
                    @{ name = $_.name;  allowance = 'mandatory' }
                }
            
                ($Global:Properties.$Class | Where-Object { $_.options.Contains('update') }) | ForEach-Object {
                    @{ name = $_.name;  allowance = 'optional' }
                }

                $Global:Properties.$Class | Where-Object { !$_.options.Contains('key') -and !$_.options.Contains('update') } | ForEach-Object {
                    @{ name = $_.name; allowance = 'prohibited' }
                }
            )
        }
    }
    else {
        #
        # Execute function
        #
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams

        $key = ($Global:Properties.$Class | Where-Object { $_.options.Contains('key') }).name

        $uri = "https://$($system_params.hostname)/api/1.1/json/user/$($function_params.$key)/"

        $splat = @{
            SystemParams = $system_params
            Method = "POST"
            Uri = $uri                    
            Body = ($function_params | ConvertTo-Json)
        }
        
        Execute-HappyFoxRequest @splat

    }

    Log info "Done"
}

function Idm-contactGroupMembersRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'ContactGroupMembers'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {

            if(     $Global:ContactGroups.count -lt 1 `
                    -or ( ((Get-Date) - $Global:ContactGroupsCacheTime) -gt (new-timespan -minutes 5) ) 
            ) {   

                Idm-contactGroupsRead -SystemParams $SystemParams -FunctionParams $FunctionParams | Out-Null
            }
            
            $properties = ($Global:Properties.$Class).name

            foreach($group in $Global:ContactGroups) {
                $uri = "https://$($system_params.hostname)/api/1.1/json/contact_group/$($group.id)/"
                
                $splat = @{
                    SystemParams = $system_params
                    Method = "GET"
                    Uri = $uri                    
                    Body = $null
                }

                
                $response = Execute-HappyFoxRequest @splat
                
                $hash_table = [ordered]@{}

                foreach ($prop in $properties.GetEnumerator()) {
                    $hash_table[$prop] = ""
                }

                foreach($rowItem in $response.contacts) {
                    $row = New-Object -TypeName PSObject -Property $hash_table
                    $row.group_id = $group.id
                    $row.key_id = "$($group.id).$($rowItem.id)"
                    foreach($prop in $rowItem.PSObject.properties) {
                        if(!$properties.contains($prop.Name)) { continue }
                        
                        $row.($prop.Name) = $prop.Value
                        
                    }

                    $row   
                }
            }
        }
}

function Idm-contactGroupMembersAdd {
    param (
        # Operations
        [switch] $GetMeta,
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams
    )

    Log info "-GetMeta=$GetMeta -SystemParams='$SystemParams' -FunctionParams='$FunctionParams'"
    $Class = 'ContactGroupMembers'

    if ($GetMeta) {
        #
        # Get meta data
        #
        @{
            semantics = 'create'
            parameters = @(
                ($Global:Properties.$Class | Where-Object { $_.options.Contains('add') }) | ForEach-Object {
                    @{ name = $_.name;  allowance = 'mandatory' }
                }

                $Global:Properties.$Class | Where-Object { !$_.options.Contains('add') } | ForEach-Object {
                    @{ name = $_.name; allowance = 'prohibited' }
                }
            )
        }
    }
    else {
        #
        # Execute function
        #
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams

        $uri = "https://$($system_params.hostname)/api/1.1/json/contact_group/$($function_params.group_id)/update_contacts/"

        $splat = @{
            SystemParams = $system_params
            Method = "POST"
            Uri = $uri                    
            Body = "[{0}]" -f (@{ contact = $function_params.id; access_tickets = $function_params.view_tickets_in_group} | ConvertTo-Json)
        }

        Execute-HappyFoxRequest @splat | Out-Null

        $obj = [PSCustomObject]@{
            key_id = "$($function_params.group_id).$($rowItem.id)"
            group_id = $function_params.group_id
            id = $function_params.Id
            email = $null
            view_tickets_in_group = if (-not $function_params.view_tickets_in_group) { $false } else { $function_params.view_tickets_in_group }
        }

        $obj
    }

    Log info "Done"
}

function Idm-contactGroupMembersRemove {
    param (
        # Operations
        [switch] $GetMeta,
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams
    )

    Log info "-GetMeta=$GetMeta -SystemParams='$SystemParams' -FunctionParams='$FunctionParams'"
    $Class = 'ContactGroupMembers'

    if ($GetMeta) {
        #
        # Get meta data
        #
        @{
            semantics = 'delete'
            parameters = @(
                ($Global:Properties.$Class | Where-Object { $_.options.Contains('key') }) | ForEach-Object {
                    @{ name = $_.name;  allowance = 'mandatory' }
                }

                $Global:Properties.$Class | Where-Object { !$_.options.Contains('key') } | ForEach-Object {
                    @{ name = $_.name; allowance = 'prohibited' }
                }
            )
        }
    }
    else {
        #
        # Execute function
        #
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams

        $key = ($Global:Properties.$Class | Where-Object { $_.options.Contains('key') }).name
        $group_id = $function_params.$key.split('.')[0]
        $contact_id = $function_params.$key.split('.')[1]

        $uri = "https://$($system_params.hostname)/api/1.1/json/contact_group/$($group_id)/delete_contacts/"

        $splat = @{
            SystemParams = $system_params
            Method = "POST"
            Uri = $uri                    
            Body = (@{ contacts = @($contact_id) } | ConvertTo-Json)
        }

        Execute-HappyFoxRequest @splat | Out-Null
    }

    Log info "Done"
}

function Idm-kb_articlesRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'KBArticles'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {
            $uri = "https://$($system_params.hostname)/api/1.1/json/kb/articles/"
            
            $splat = @{
                SystemParams = $system_params
                Method = "GET"
                Uri = $uri                    
                Body = $null
            }

            
            $response = Execute-HappyFoxRequest @splat
            
            $properties = ($Global:Properties.$Class).name
            $hash_table = [ordered]@{}

            foreach ($prop in $properties.GetEnumerator()) {
                $hash_table[$prop] = ""
            }

            foreach($rowItem in $response) {
                $row = New-Object -TypeName PSObject -Property $hash_table

                foreach($prop in $rowItem.PSObject.properties) {
                    if($prop.Name -eq 'language') { 
                        $row.language_visible = $prop.value.visible
                        $row.language_enabled = $prop.value.enabled
                        $row.language_id = $prop.value.id
                        $row.language_name = $prop.value.name
                    }

                    if(!$properties.contains($prop.Name)) { continue }
                    
                    $row.($prop.Name) = $prop.Value
                    
                }

                $row
            }
        }
}

function Idm-kb_internalArticlesRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'KBInternalArticles'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {
            $uri = "https://$($system_params.hostname)/api/1.1/json/kb/internal-articles/"
            
            $splat = @{
                SystemParams = $system_params
                Method = "GET"
                Uri = $uri                    
                Body = $null
            }

            
            $response = Execute-HappyFoxRequest @splat
            
            $properties = ($Global:Properties.$Class).name
            $hash_table = [ordered]@{}

            foreach ($prop in $properties.GetEnumerator()) {
                $hash_table[$prop] = ""
            }

            foreach($rowItem in $response) {
                $row = New-Object -TypeName PSObject -Property $hash_table

                foreach($prop in $rowItem.PSObject.properties) {
                    if($prop.Name -eq 'language') { 
                        $row.language_visible = $prop.value.visible
                        $row.language_enabled = $prop.value.enabled
                        $row.language_id = $prop.value.id
                        $row.language_name = $prop.value.name
                    }

                    if(!$properties.contains($prop.Name)) { continue }
                    
                    $row.($prop.Name) = $prop.Value
                    
                }

                $row
            }
        }
}

function Idm-kb_sectionsRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'KBSections'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {
            $uri = "https://$($system_params.hostname)/api/1.1/json/kb/sections/"
            
            $splat = @{
                SystemParams = $system_params
                Method = "GET"
                Uri = $uri                    
                Body = $null
            }

            
            $response = Execute-HappyFoxRequest @splat
            
            $properties = ($Global:Properties.$Class).name
            $hash_table = [ordered]@{}

            foreach ($prop in $properties.GetEnumerator()) {
                $hash_table[$prop] = ""
            }

            foreach($rowItem in $response) {
                $row = New-Object -TypeName PSObject -Property $hash_table

                foreach($prop in $rowItem.PSObject.properties) {
                    if(!$properties.contains($prop.Name)) { continue }
                    
                    $row.($prop.Name) = $prop.Value
                    
                }

                $row
            }
        }
}

function Idm-staffRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'Staff'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {
            $uri = "https://$($system_params.hostname)/api/1.1/json/staff/"
            
            $splat = @{
                SystemParams = $system_params
                Method = "GET"
                Uri = $uri                    
                Body = $null
            }

            
            $response = Execute-HappyFoxRequest @splat
            
            $properties = ($Global:Properties.$Class).name
            $hash_table = [ordered]@{}

            foreach ($prop in $properties.GetEnumerator()) {
                $hash_table[$prop] = ""
            }

            foreach($rowItem in $response) {
                $row = New-Object -TypeName PSObject -Property $hash_table

                foreach($prop in $rowItem.PSObject.properties) {
                    if($prop.Name -eq 'role') {
                        $row.role_name = $prop.Value.name
                        $row.role_id = $prop.Value.id
                    }

                    if(!$properties.contains($prop.Name)) { continue }
                    
                    $row.($prop.Name) = $prop.Value
                    
                }

                $row
            }
        }
}

function Idm-statusesRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'Statuses'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {
            $uri = "https://$($system_params.hostname)/api/1.1/json/statuses/"
            
            $splat = @{
                SystemParams = $system_params
                Method = "GET"
                Uri = $uri                    
                Body = $null
            }

            
            $response = Execute-HappyFoxRequest @splat
            
            $properties = ($Global:Properties.$Class).name
            $hash_table = [ordered]@{}

            foreach ($prop in $properties.GetEnumerator()) {
                $hash_table[$prop] = ""
            }

            foreach($rowItem in $response) {
                $row = New-Object -TypeName PSObject -Property $hash_table

                foreach($prop in $rowItem.PSObject.properties) {
                    if(!$properties.contains($prop.Name)) { continue }
                    
                    $row.($prop.Name) = $prop.Value
                    
                }

                $row
            }
        }
}

<# 
    Disabled due to large number of requests required for tickets
    Future: Determine if necessary, if so use q parameter to filter tickets


function Idm-ticketsRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'Tickets'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {
            $uri = "https://$($system_params.hostname)/api/1.1/json/tickets/"
            
            $splat = @{
                SystemParams = $system_params
                Method = "GET"
                Uri = $uri                    
                Body = $null
            }

            
            $response = Execute-HappyFoxRequest @splat
            
            $properties = ($Global:Properties.$Class).name
            $hash_table = [ordered]@{}

            foreach ($prop in $properties.GetEnumerator()) {
                $hash_table[$prop] = ""
            }

            foreach($rowItem in $response) {
                $row = New-Object -TypeName PSObject -Property $hash_table

                foreach($prop in $rowItem.PSObject.properties) {
                    if(!$properties.contains($prop.Name)) { continue }
                    
                    $row.($prop.Name) = $prop.Value
                    
                }

                $row
            }
        }
}

function Idm-ticketCustomFieldsRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'TicketCustomFields'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {
            $uri = "https://$($system_params.hostname)/api/1.1/json/user_custom_fields/"
            
            $splat = @{
                SystemParams = $system_params
                Method = "GET"
                Uri = $uri                    
                Body = $null
            }

            
            $response = Execute-HappyFoxRequest @splat
            
            $properties = ($Global:Properties.$Class).name
            $hash_table = [ordered]@{}

            foreach ($prop in $properties.GetEnumerator()) {
                $hash_table[$prop] = ""
            }

            foreach($rowItem in $response) {
                $row = New-Object -TypeName PSObject -Property $hash_table

                foreach($prop in $rowItem.PSObject.properties) {
                    if(!$properties.contains($prop.Name)) { continue }
                    
                    $row.($prop.Name) = $prop.Value
                    
                }

                $row
            }
        }
}

#>
function Idm-userCustomFieldsRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'UserCustomFields'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {
            $uri = "https://$($system_params.hostname)/api/1.1/json/user_custom_fields/"
            
            $splat = @{
                SystemParams = $system_params
                Method = "GET"
                Uri = $uri                    
                Body = $null
            }

            
            $response = Execute-HappyFoxRequest @splat
            
            $properties = ($Global:Properties.$Class).name
            $hash_table = [ordered]@{}

            foreach ($prop in $properties.GetEnumerator()) {
                $hash_table[$prop] = ""
            }

            foreach($rowItem in $response) {
                $row = New-Object -TypeName PSObject -Property $hash_table

                foreach($prop in $rowItem.PSObject.properties) {
                    if(!$properties.contains($prop.Name)) { continue }
                    
                    $row.($prop.Name) = $prop.Value
                    
                }

                $row
            }
        }
}

#
#   Internal Functions
#
function Execute-HappyFoxRequest {
    param (
        [hashtable] $SystemParams,
        [string] $Method,
        [string] $Body,
        [string] $Uri
    )
    $authToken = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($SystemParams.username):$($SystemParams.password)"))

    $splat = @{
        Headers = @{
            "Authorization" = "Basic $($authToken)"
            "Accept" = "application/json"
            "Content-Type" = "application/json"
        }
        Method = $Method
        Uri = $Uri
    }

    if($Method -ne "GET") {
        $splat["Body"] = $Body
    } else {
        $splat["Body"] = @{
            page = 1
            size = 50
        }
    }

     if($SystemParams.use_proxy)
                {
                    Add-Type @"
using System.Net;
using System.Security.Cryptography.X509Certificates;
public class TrustAllCertsPolicy : ICertificatePolicy {
    public bool CheckValidationResult(
        ServicePoint srvPoint, X509Certificate certificate,
        WebRequest request, int certificateProblem) {
        return true;
    }
}
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
                    
        $splat["Proxy"] = $SystemParams.proxy_address

        if($SystemParams.use_proxy_credentials)
        {
            $splat["proxyCredential"] = New-Object System.Management.Automation.PSCredential ($SystemParams.proxy_username, (ConvertTo-SecureString $SystemParams.proxy_password -AsPlainText -Force) )
        }
    }

    do {
        $attempt = 0
        $retryDelay = $SystemParams.retryDelay
        do {
            try {
                    $attemptSuffix = if ($attempt -gt 0) { " (Attempt $($attempt + 1))" } else { "" }

                    if ($Method -eq "GET" -and $splat["Body"]) {
                        $queryParams = ($splat["Body"].GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join "&"
                        Log verbose "$($splat.Method) Call: $($splat.Uri)?$queryParams$attemptSuffix"
                    }
                    else {
                        Log verbose "$($splat.Method) Call: $($splat.Uri)$attemptSuffix"
                    }
                    $response = Invoke-RestMethod @splat -ErrorAction Stop
                    break
            } catch {
                    $statusCode = $_.Exception.Response.StatusCode.value__
                    if ($statusCode -eq 429) {
                        $attempt++
                        if ($attempt -ge $SystemParams.nr_of_retries) {
                            throw "Max retry attempts reached for $Uri"
                        }
                        Log warning "Received $statusCode. Retrying in $retryDelay seconds..."
                        Start-Sleep -Seconds $retryDelay
                        $retryDelay *= 2  # Exponential backoff
                    } else {
                        throw  # Rethrow for other errors
                    }
            }
        } while ($true)

        if ($null -eq $response.page_info.page_count) {
            return $response
        }

        $response.data

        if ($response.page_info.page_count -eq $splat['Body'].Page) {
            break
        }

        $splat['Body'].Page++
    } while ($true)
}

function Get-ClassMetaData {
    param (
        [string] $SystemParams,
        [string] $Class
    )

    @(
        @{
            name = 'properties'
            type = 'grid'
            label = 'Properties'
            table = @{
                rows = @( $Global:Properties.$Class | ForEach-Object {
                    @{
                        name = $_.name
                        usage_hint = @( @(
                            foreach ($opt in $_.options) {
                                if ($opt -notin @('default', 'idm', 'key')) { continue }

                                if ($opt -eq 'idm') {
                                    $opt.Toupper()
                                }
                                else {
                                    $opt.Substring(0,1).Toupper() + $opt.Substring(1)
                                }
                            }
                        ) | Sort-Object) -join ' | '
                    }
                })
                settings_grid = @{
                    selection = 'multiple'
                    key_column = 'name'
                    checkbox = $true
                    filter = $true
                    columns = @(
                        @{
                            name = 'name'
                            display_name = 'Name'
                        }
                        @{
                            name = 'usage_hint'
                            display_name = 'Usage hint'
                        }
                    )
                }
            }
            value = ($Global:Properties.$Class | Where-Object { $_.options.Contains('default') }).name
        }
    )
}
