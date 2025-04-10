# ********Création des Groupes*********

New-ADGroup -Name Direction -GroupScope Global -GroupCategory Security -Path "ou=Employés,dc=m2L,dc=fr"

New-ADGroup -Name Sales -GroupScope Global -GroupCategory Security -Path "ou=Employés,dc=m2L,dc=fr"
New-ADGroup -Name Traders -GroupScope Global -GroupCategory Security -Path "ou=Employés,dc=m2L,dc=fr"
New-ADGroup -Name Secretary -GroupScope Global -GroupCategory Security -Path "ou=Employés,dc=m2L,dc=fr"
New-ADGroup -Name Accounting -GroupScope Global -GroupCategory Security -Path "ou=Employés,dc=m2L,dc=fr"
New-ADGroup -Name Financial-Consultant -GroupScope Global -GroupCategory Security -Path "ou=Employés,dc=m2L,dc=fr"
