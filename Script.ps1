Import-Module ActiveDirectory
Import-Module 'Microsoft.PowerShell.Security'

$users = Import-Csv -Delimiter ";" -Path "C:\Users\Administrateur\Documents\docs\scripts\import.csv"

#********************Création des OU********************************

New-ADOrganizationalUnit -Name "Bâtiment-A" -Path "dc=m2l,dc=lan"
New-ADOrganizationalUnit -Name "Escrime" -Path "ou=Bâtiment-A,dc=m2l,dc=lan"
New-ADOrganizationalUnit -Name "Badminton" -Path "ou=Bâtiment-A,dc=m2l,dc=lan"
New-ADOrganizationalUnit -Name "Volley" -Path "ou=Bâtiment-A,dc=m2l,dc=lan"

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
        "Escrime" {$office = "OU=Escrime,OU=Bâtiment-A,dc=m2l,DC=lan"}
        "Badminton" {$office = "OU=Badminton,OU=Bâtiment-A,dc=m2l,DC=lan"}
        "Volley" {$office = "OU=Volley,OU=Bâtiment-A,dc=m2l,DC=lan"}
        default {$office = $null}    
    }
    
     try {
            New-ADUser -Name $name -SamAccountName $login -UserPrincipalName $login -DisplayName $name -GivenName $fname -Surname $lname -AccountPassword (ConvertTo-SecureString $Upassword -AsPlainText -Force) -City $Uoffice -Path $office -Department $dept -Enabled $true
            echo "Utilisateur ajouté : $name"
          
           
        } catch{
            echo "utilisateur non ajouté : $name"
       }   

   }

# ********Création des Groupes*********

New-ADGroup -Name Direction -GroupScope Global -GroupCategory Security -Path "ou=Bâtiment-A,dc=m2l,dc=lan"

New-ADGroup -Name Sales -GroupScope Global -GroupCategory Security -Path "ou=Bâtiment-A,dc=m2l,dc=lan"
New-ADGroup -Name Traders -GroupScope Global -GroupCategory Security -Path "ou=Bâtiment-A,dc=m2l,dc=lan"
New-ADGroup -Name Secretary -GroupScope Global -GroupCategory Security -Path "ou=Bâtiment-A,dc=m2l,dc=lan"
New-ADGroup -Name Accounting -GroupScope Global -GroupCategory Security -Path "ou=Bâtiment-A,dc=m2l,dc=lan"
New-ADGroup -Name Financial-Consultant -GroupScope Global -GroupCategory Security -Path "ou=Bâtiment-A,dc=m2l,dc=lan"

#*********************Groupes sous Escrime************************

New-ADGroup -Name DirectionParis -GroupScope Global -GroupCategory Security -Path "ou=Escrime,ou=Bâtiment-A,dc=m2l,dc=lan"
New-ADGroup -Name SalesParis -GroupScope Global -GroupCategory Security -Path "ou=Escrime,ou=Bâtiment-A,dc=m2l,dc=lan"
New-ADGroup -Name TradersParis -GroupScope Global -GroupCategory Security -Path "ou=Escrime,ou=Bâtiment-A,dc=m2l,dc=lan"
New-ADGroup -Name SecretaryParis -GroupScope Global -GroupCategory Security -Path "ou=Escrime,ou=Bâtiment-A,dc=m2l,dc=lan"
New-ADGroup -Name AccountingParis -GroupScope Global -GroupCategory Security -Path "ou=Escrime,ou=Bâtiment-A,dc=m2l,dc=lan"
New-ADGroup -Name Financial-ConsultantParis -GroupScope Global -GroupCategory Security -Path "ou=Escrime,ou=Bâtiment-A,dc=m2l,dc=lan"

#*********************Groupes sous Badminton************************

New-ADGroup -Name DirectionBerlin -GroupScope Global -GroupCategory Security -Path "ou=Badminton,ou=Bâtiment-A,dc=m2l,dc=lan"
New-ADGroup -Name SalesBerlin -GroupScope Global -GroupCategory Security -Path "ou=Badminton,ou=Bâtiment-A,dc=m2l,dc=lan"
New-ADGroup -Name TradersBerlin -GroupScope Global -GroupCategory Security -Path "ou=Badminton,ou=Bâtiment-A,dc=m2l,dc=lan"
New-ADGroup -Name SecretaryBerlin -GroupScope Global -GroupCategory Security -Path "ou=Badminton,ou=Bâtiment-A,dc=m2l,dc=lan"
New-ADGroup -Name AccountingBerlin -GroupScope Global -GroupCategory Security -Path "ou=Badminton,ou=Bâtiment-A,dc=m2l,dc=lan"
New-ADGroup -Name Financial-ConsultantBerlin -GroupScope Global -GroupCategory Security -Path "ou=Badminton,ou=Bâtiment-A,dc=m2l,dc=lan"

#*********************Groupes sous Volley************************

New-ADGroup -Name DirectionLondres -GroupScope Global -GroupCategory Security -Path "ou=Volley,ou=Bâtiment-A,dc=m2l,dc=lan"
New-ADGroup -Name SalesLondres -GroupScope Global -GroupCategory Security -Path "ou=Volley,ou=Bâtiment-A,dc=m2l,dc=lan"
New-ADGroup -Name TradersLondres -GroupScope Global -GroupCategory Security -Path "ou=Volley,ou=Bâtiment-A,dc=m2l,dc=lan"
New-ADGroup -Name SecretaryLondres -GroupScope Global -GroupCategory Security -Path "ou=Volley,ou=Bâtiment-A,dc=m2l,dc=lan"
New-ADGroup -Name AccountingLondres -GroupScope Global -GroupCategory Security -Path "ou=Volley,ou=Bâtiment-A,dc=m2l,dc=lan"
New-ADGroup -Name Financial-ConsultantLondres -GroupScope Global -GroupCategory Security -Path "ou=Volley,ou=Bâtiment-A,dc=m2l,dc=lan"


foreach ($user in $users){

    $name = $user.firstName + " " + $user.lastName
    $fname = $user.firstName
    $lname = $user.lastName
    $login = $user.firstName + "." + $user.lastName
    $Uoffice = $user.office
    $Upassword = $user.password
    $dept = $user.department 



#********Ajout des utilisateurs de Volley dans leurs groupes********************

if ($Uoffice -eq "Volley" -and $dept -eq "Direction"){

    Add-ADGroupMember -Identity 'DirectionLondres' -Members $login

}
elseif ($Uoffice -eq "Volley" -and $dept -eq "Traders"){

    Add-ADGroupMember -Identity 'TradersLondres' -Members $login

}
elseif ($Uoffice -eq "Volley" -and $dept -eq "Secretary"){

    Add-ADGroupMember -Identity 'SecretaryLondres' -Members $login

}
elseif ($Uoffice -eq "Volley" -and $dept -eq "Accounting"){

    Add-ADGroupMember -Identity 'AccountingLondres' -Members $login

}
elseif ($Uoffice -eq "Volley" -and $dept -eq "Financial-Consultant"){

    Add-ADGroupMember -Identity 'Financial-ConsultantLondres' -Members $login

}
elseif ($Uoffice -eq "Volley" -and $dept -eq "Sales"){

    Add-ADGroupMember -Identity 'SalesLondres' -Members $login
} 


#********Ajout des utilisateurs de Badminton dans leurs groupes********************

if ($Uoffice -eq "Badminton" -and $dept -eq "Direction"){

    Add-ADGroupMember -Identity 'DirectionBerlin' -Members $login

}
elseif ($Uoffice -eq "Badminton" -and $dept -eq "Traders"){

    Add-ADGroupMember -Identity 'TradersBerlin' -Members $login

}
elseif ($Uoffice -eq "Badminton" -and $dept -eq "Secretary"){

    Add-ADGroupMember -Identity 'SecretaryBerlin' -Members $login

}
elseif ($Uoffice -eq "Badminton" -and $dept -eq "Accounting"){

    Add-ADGroupMember -Identity 'AccountingBerlin' -Members $login

}
elseif ($Uoffice -eq "Badminton" -and $dept -eq "Financial-Consultant"){

    Add-ADGroupMember -Identity 'Financial-ConsultantBerlin' -Members $login

}
elseif ($Uoffice -eq "Badminton" -and $dept -eq "Sales"){

    Add-ADGroupMember -Identity 'SalesBerlin' -Members $login
} 


#********Ajout des utilisateurs de Escrime dans leurs groupes********************

if ($Uoffice -eq "Escrime" -and $dept -eq "Direction"){

    Add-ADGroupMember -Identity 'DirectionParis' -Members $login

}
elseif ($Uoffice -eq "Escrime" -and $dept -eq "Traders"){

    Add-ADGroupMember -Identity 'TradersParis' -Members $login

}
elseif ($Uoffice -eq "Escrime" -and $dept -eq "Secretary"){

    Add-ADGroupMember -Identity 'SecretaryParis' -Members $login

}
elseif ($Uoffice -eq "Escrime" -and $dept -eq "Accounting"){

    Add-ADGroupMember -Identity 'AccountingParis' -Members $login

}
elseif ($Uoffice -eq "Escrime" -and $dept -eq "Financial-Consultant"){

    Add-ADGroupMember -Identity 'Financial-ConsultantParis' -Members $login

}
elseif ($Uoffice -eq "Escrime" -and $dept -eq "Sales"){

    Add-ADGroupMember -Identity 'SalesParis' -Members $login
} 

} 

#Ajout des groupes dans les groupes

Add-ADGroupMember -Identity 'Direction' -Members DirectionParis,DirectionLondres,DirectionBerlin
Add-ADGroupMember -Identity 'Sales' -Members SalesParis,SalesLondres,SalesBerlin
Add-ADGroupMember -Identity 'Traders'-Members TradersParis,TradersLondres,TradersBerlin
Add-ADGroupMember -Identity 'Secretary' -Members SecretaryParis,SecretaryLondres,SecretaryBerlin
Add-ADGroupMember -Identity 'Accounting'-Members AccountingParis,AccountingLondres,AccountingBerlin
Add-ADGroupMember -Identity 'Financial-Consultant' -Members Financial-ConsultantParis,Financial-ConsultantLondres,Financial-ConsultantBerlin


