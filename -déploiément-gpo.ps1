# Définition des variables
$GPOName = "Déploiement Image"
$ShareName = "Images_Wallpaper$"  # Le signe $ rend le dossier caché
$FolderPath = "C:\Partages\Images_Wallpaper"
$ImageSource = "C:\Images\Windows-XD-HD.jpg"  # Chemin de l'image source
$ImageDestination = "$FolderPath\Windows-XD-HD.jpg"

# Importation du module GroupPolicy
Import-Module GroupPolicy

# Création du dossier partagé
If (!(Test-Path $FolderPath)) {
    New-Item -Path $FolderPath -ItemType Directory -Force
}

# Déplacement de l'image dans le dossier
Copy-Item -Path $ImageSource -Destination $ImageDestination -Force

# Configuration du partage réseau
New-SmbShare -Name $ShareName -Path $FolderPath -FullAccess "Domain Users" -Description "Fond d'écran déployé par GPO"

# Modification des permissions du dossier
$Acl = Get-Acl $FolderPath
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("Domain Users", "ReadAndExecute", "ContainerInherit,ObjectInherit", "None", "Allow")
$Acl.SetAccessRule($AccessRule)
Set-Acl -Path $FolderPath -AclObject $Acl

# Création de la GPO et définition du fond d’écran
$RegistryPath = "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System"
$RegistryName = "Wallpaper"
$ImagePathUNC = "\\serveur01\Images_Wallpaper$\Windows-xp.jpg"

New-GPO -Name $GPOName
New-GPLink -Name $GPOName -Target "OU=Postes,DC=monDomaine,DC=com"
Set-GPRegistryValue -Name $GPOName -Key $RegistryPath -ValueName $RegistryName -Type String -Value $ImagePathUNC
Set-GPRegistryValue -Name $GPOName -Key $RegistryPath -ValueName "WallpaperStyle" -Type String -Value "2"

# Forcer l’application de la GPO
gpupdate /force

Write-Output "La GPO '$GPOName' a été créée et configurée avec l’image de fond d’écran."
