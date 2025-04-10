Import-Module ActiveDirectory
Import-Module 'Microsoft.PowerShell.Security'

$users = Import-Csv -Delimiter ";" -Path "C:\docs\import.csv"

foreach ($user in $users){

    $name = $user.firstName + " " + $user.lastName
    $fname = $user.firstName
    $lname = $user.lastName
    $login = $user.firstName + "." + $user.lastName
    $Uoffice = $user.office
    $Upassword = $user.password
    $dept = $user.department 


#********Ajout des utilisateurs de Paris dans leurs groupes********************

if ($Uoffice -eq "Paris" -and $dept -eq "Direction"){

    Add-ADGroupMember -Identity 'DirectionParis' -Members $login

}
elseif ($Uoffice -eq "Paris" -and $dept -eq "Traders"){

    Add-ADGroupMember -Identity 'TradersParis' -Members $login

}
elseif ($Uoffice -eq "Paris" -and $dept -eq "Secretary"){

    Add-ADGroupMember -Identity 'SecretaryParis' -Members $login

}
elseif ($Uoffice -eq "Paris" -and $dept -eq "Accounting"){

    Add-ADGroupMember -Identity 'AccountingParis' -Members $login

}
elseif ($Uoffice -eq "Paris" -and $dept -eq "Financial-Consultant"){

    Add-ADGroupMember -Identity 'Financial-ConsultantParis' -Members $login

}
elseif ($Uoffice -eq "Paris" -and $dept -eq "Sales"){

    Add-ADGroupMember -Identity 'SalesParis' -Members $login
} 

} 
