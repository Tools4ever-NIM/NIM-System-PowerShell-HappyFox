#
# HappyFox.ps1 - HappyFox
#


$Log_MaskableKeys = @(
    'Password',
    "proxy_password"
)

$Global:ContactsCacheTime = Get-Date
$Global:ContactGroupsCacheTime = Get-Date
$Global:Contacts = [System.Collections.ArrayList]@()
$Global:ContactGroups = [System.Collections.ArrayList]@()


$Properties = @{
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
        @{ name = 'name';           						options = @('default')}
        @{ name = 'is_login_enabled';           			options = @('default')}
        @{ name = 'primary_phone_id';           			options = @('default')}
        @{ name = 'primary_phone_number';           		options = @('default')}
        @{ name = 'primary_phone_type';           			options = @('default')}
        @{ name = 'created_at';           					options = @('default')}
        @{ name = 'updated_at';           					options = @('default')}
        @{ name = 'pending_tickets_count';           		options = @('default')}
        @{ name = 'tickets_count';           				options = @('default')}
        @{ name = 'email';           						options = @('default')}
    )
    ContactsCustomFields = @(
        @{ name = 'key_id';           			            options = @('default','key')}    
        @{ name = 'id';           						    options = @('default')}
        @{ name = 'name';           						options = @('default')}
        @{ name = 'type';           						options = @('default')}
        @{ name = 'value';           						options = @('default')}
        @{ name = 'value_id';           					options = @('default')}
        @{ name = 'value_to_staff_only';           			options = @('default')}
        @{ name = 'contacts_id';           			        options = @('default')}
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
        @{ name = 'tagged_domains';       					options = @('default')}
        @{ name = 'description';           					options = @('default')}
        @{ name = 'name';           						options = @('default')}
    )
    ContactGroupMembers = @(
        @{ name = 'key_id';           						options = @('default','key')}
        @{ name = 'group_id';           					options = @('default')}
        @{ name = 'id';           						    options = @('default')}
        @{ name = 'email';       					        options = @('default')}
        @{ name = 'view_tickets_in_group';           		options = @('default')}
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
    UserCustomFields = @(
        @{ name = 'id';           						    options = @('default','key')}
        @{ name = 'name';           			            options = @('default')}
        @{ name = 'depends_on_choice';           			options = @('default')}
        @{ name = 'required';           			        options = @('default')}
        @{ name = 'type';       					        options = @('default')}
        @{ name = 'choices';       					        options = @()} # Future: Convert to Table of objects
        @{ name = 'order';       					        options = @()}
        @{ name = 'visible_to_staff_only';       			options = @()}
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
        }
        Method = $Method
        Uri = $Uri
    }

    if($Method -ne "GET") {
        $splat["Body"] = $Body
    } else {
        $splat["Body"] = @{
            page = 0
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
        Log verbose "$($splat.method) Call: $($splat.Uri)"
        $response = Invoke-RestMethod @splat -ErrorAction Stop

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
