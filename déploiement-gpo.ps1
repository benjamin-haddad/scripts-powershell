# Importer le module Active Directory si nécessaire
Import-Module ActiveDirectory

# Définir le nom de la GPO et sa description
$GPOName = "Interdire Accès Panneau de Configuration"
$GPODescription = "Cette GPO interdit l'accès au Panneau de configuration"

# Créer la GPO
$GPO = New-GPO -Name $GPOName -Comment $GPODescription
Write-Host "GPO '$GPOName' créée avec succès."

# Modifier les paramètres de la GPO pour interdire l'accès au panneau de configuration
$RegistryPath = "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$RegistryValueName = "NoControlPanel"
$RegistryValueData = 1  # La valeur est un entier, pas une chaîne

Set-GPRegistryValue -Name $GPOName -Key $RegistryPath -ValueName $RegistryValueName -Type DWord -Value $RegistryValueData
Write-Host "Les paramètres de la GPO '$GPOName' ont été configurés."

# Lier la GPO aux OU spécifiques
$OUs = @(
    "OU=Paris,OU=Employes,DC=m2l,DC=lan",
    "OU=Londres,OU=Employes,DC=m2l,DC=lan",
    "OU=Berlin,OU=Employes,DC=m2l,DC=lan"
)

foreach ($OU in $OUs) {
    New-GPLink -Name $GPOName -Target $OU -Enforced No
    Write-Host "GPO '$GPOName' liée à l'OU '$OU'."
}

Write-Host "La configuration et les liaisons de la GPO sont terminées avec succès."
