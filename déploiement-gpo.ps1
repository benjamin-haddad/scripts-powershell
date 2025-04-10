# Chargement du module Active Directory
Import-Module ActiveDirectory

# Définir les variables
$GPOName = "NomDeVotreGPO"  # Nom du GPO
$GPODescription = "Description de votre GPO"  # Description du GPO
$OUPath = "OU=NomDeVotreUnitéOrganisationnelle,DC=VotreDomaine,DC=com"  # Chemin LDAP de l'unité organisationnelle
$SecurityGroupName = "NomDuGroupeDeSécurité"  # Nom du groupe de sécurité

# Étape 1 : Créer un nouveau GPO
Write-Host "Création du GPO..."
New-GPO -Name $GPOName -Description $GPODescription
$GPO = Get-GPO -Name $GPOName

# Étape 2 : Configurer le GPO (Exemple de paramètres)
Write-Host "Configuration des paramètres du GPO..."
$RegistrySetting = @"
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Installer]
"DisableMSI"=dword:00000001
"@
$RegistryFilePath = "C:\Temp\GPO_RegistrySettings.reg"
$RegistrySetting | Out-File -FilePath $RegistryFilePath
Import-GPOBackup -Path $RegistryFilePath -BackupGPO $GPO

# Étape 3 : Lier le GPO à une unité organisationnelle
Write-Host "Liaison du GPO à l'unité organisationnelle..."
Set-GPLink -Name $GPOName -Target $OUPath -LinkEnabled Yes

# Étape 4 : Ajouter un filtre de sécurité basé sur un groupe de sécurité
Write-Host "Ajout du filtre de sécurité..."
$GPOPermissions = @("Read", "Apply Group Policy")
$Group = Get-ADGroup -Identity $SecurityGroupName
Set-GPPermission -Name $GPOName -PermissionLevel $GPOPermissions -TargetType Group -TargetName $Group.Name

Write-Host "Installation et déploiement du GPO terminés avec succès !"
