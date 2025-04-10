#Ajout des groupes dans les groupes

Add-ADGroupMember -Identity 'Direction' -Members DirectionParis,DirectionLondres,DirectionBerlin
Add-ADGroupMember -Identity 'Sales' -Members SalesParis,SalesLondres,SalesBerlin
Add-ADGroupMember -Identity 'Traders'-Members TradersParis,TradersLondres,TradersBerlin
Add-ADGroupMember -Identity 'Secretary' -Members SecretaryParis,SecretaryLondres,SecretaryBerlin
Add-ADGroupMember -Identity 'Accounting'-Members AccountingParis,AccountingLondres,AccountingBerlin
Add-ADGroupMember -Identity 'Financial-Consultant' -Members Financial-ConsultantParis,Financial-ConsultantLondres,Financial-ConsultantBerlin


