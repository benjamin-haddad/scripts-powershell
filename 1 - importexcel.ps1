Import-Module ActiveDirectory
Import-Module 'Microsoft.PowerShell.Security'

$users = Import-Csv -Delimiter ";" -Path "C:\docs\import.csv"

#********************Cr�ation des OU********************************

New-ADOrganizationalUnit -Name "Employ�s" -Path "dc=m2L,dc=fr"
New-ADOrganizationalUnit -Name "Londres" -Path "ou=Employ�s,dc=m2L,dc=fr"
New-ADOrganizationalUnit -Name "Paris" -Path "ou=Employ�s,dc=m2L,dc=fr"
New-ADOrganizationalUnit -Name "Berlin" -Path "ou=Employ�s,dc=m2L,dc=fr"

#*******Ajout de chaque utilisateur dans son OU sp�cifique*******

foreach ($user in $users){
    
    $name = $user.firstName + " " + $user.lastName
    $fname = $user.firstName
    $lname = $user.lastName
    $login = $user.firstName + "." + $user.lastName
    $Uoffice = $user.office
    $Upassword = $user.password
    $dept = $user.department
    

    switch($user.office){
        "Paris" {$office = "OU=Paris,OU=Employ�s,DC=m2L,DC=fr"}
        "Berlin" {$office = "OU=Berlin,OU=Employ�s,DC=m2L,DC=fr"}
        "Londres" {$office = "OU=Londres,OU=Employ�s,DC=m2L,DC=fr"}
        default {$office = $null}    
    }
    
     try {
            New-ADUser -Name $name -SamAccountName $login -UserPrincipalName $login -DisplayName $name -GivenName $fname -Surname $lname -AccountPassword (ConvertTo-SecureString $Upassword -AsPlainText -Force) -City $Uoffice -Path $office -Department $dept -Enabled $true
            echo "Utilisateur ajout� : $name"
          
           
        } catch{
            echo "utilisateur non ajout� : $name"
       }   

   }
