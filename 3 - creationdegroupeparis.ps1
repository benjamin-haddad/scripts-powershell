#*********************Groupes sous Paris************************

New-ADGroup -Name DirectionParis -GroupScope Global -GroupCategory Security -Path "ou=Paris,ou=Employ�s,dc=m2L,dc=fr"
New-ADGroup -Name SalesParis -GroupScope Global -GroupCategory Security -Path "ou=Paris,ou=Employ�s,dc=m2L,dc=fr"
New-ADGroup -Name TradersParis -GroupScope Global -GroupCategory Security -Path "ou=Paris,ou=Employ�s,dc=m2L,dc=fr"
New-ADGroup -Name SecretaryParis -GroupScope Global -GroupCategory Security -Path "ou=Paris,ou=Employ�s,dc=m2L,dc=fr"
New-ADGroup -Name AccountingParis -GroupScope Global -GroupCategory Security -Path "ou=Paris,ou=Employ�s,dc=m2L,dc=fr"
New-ADGroup -Name Financial-ConsultantParis -GroupScope Global -GroupCategory Security -Path "ou=Paris,ou=Employ�s,dc=m2L,dc=fr"

