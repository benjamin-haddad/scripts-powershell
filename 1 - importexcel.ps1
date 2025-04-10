Import-Module ActiveDirectory
Import-Module 'Microsoft.PowerShell.Security'

$users = Import-Csv -Delimiter ";" -Path "C:\docs\import.csv"

#********************Création des OU********************************

New-ADOrganizationalUnit -Name "Employés" -Path "dc=m2L,dc=fr"
New-ADOrganizationalUnit -Name "Londres" -Path "ou=Employés,dc=m2L,dc=fr"
New-ADOrganizationalUnit -Name "Paris" -Path "ou=Employés,dc=m2L,dc=fr"
New-ADOrganizationalUnit -Name "Berlin" -Path "ou=Employés,dc=m2L,dc=fr"

#*******Ajout de chaque utilisateur dans son OU spécifique*******

foreach ($user in $users){
    
    $name = $user.firstName + " " + $user.lastName
    $fname = $user.firstName
    $lname = $user.lastName
    $login = $user.firstName + "." + $user.lastName
    $Uoffice = $user.office
    $Upassword = $user.password
    $dept = $user.department
    

    switch($user.office){
        "Paris" {$office = "OU=Paris,OU=Employés,DC=m2L,DC=fr"}
        "Berlin" {$office = "OU=Berlin,OU=Employés,DC=m2L,DC=fr"}
        "Londres" {$office = "OU=Londres,OU=Employés,DC=m2L,DC=fr"}
        default {$office = $null}    
    }
    
     try {
            New-ADUser -Name $name -SamAccountName $login -UserPrincipalName $login -DisplayName $name -GivenName $fname -Surname $lname -AccountPassword (ConvertTo-SecureString $Upassword -AsPlainText -Force) -City $Uoffice -Path $office -Department $dept -Enabled $true
            echo "Utilisateur ajouté : $name"
          
           
        } catch{
            echo "utilisateur non ajouté : $name"
       }   

   }
