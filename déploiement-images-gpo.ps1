# Importation du module GroupPolicy
Import-Module GroupPolicy

# Définition du nom de la GPO
$GPOName = "Déploiement Image"

# Création de la GPO
$GPO = New-GPO -Name $GPOName

# Liaison de la GPO à une unité d'organisation (OU)
$OU = "OU=Postes,DC=monDomaine,DC=com"
New-GPLink -Name $GPOName -Target $OU

# Définition du fond d'écran via le registre
$RegistryPath = "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System"
$RegistryName = "Wallpaper"
$ImagePath = "\\serveur\partage\image.jpg"

# Création de la clé si elle n'existe pas
If (!(Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force
}


# Définition de la préférence de registre via la GPO
Set-GPPrefRegistryValue -Name $GPOName -Context User -Key $RegistryPath -ValueName $RegistryName -Type String -Value $ImagePath -Action Create


# Forcer l’application de la GPO
gpupdate /force

Write-Output "La GPO '$GPOName' a été créée et configurée avec l’image de fond d’écran."
