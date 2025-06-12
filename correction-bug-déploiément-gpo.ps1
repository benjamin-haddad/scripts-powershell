New-GPPrefRegistryValue -Name $GPOName -Context User -Key $RegistryPath -ValueName $RegistryName -Type String -Value $ImagePath

# Application de la valeur
Set-ItemProperty -Path $RegistryPath -Name $RegistryName -Value $ImagePath
