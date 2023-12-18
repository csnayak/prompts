#!/bin/pwsh

$my_nerdfont_ttf = "Fira Code Regular Nerd Font Complete.ttf"
$my_fontdir = "$Env:UserProfile\AppData\Local\Microsoft\Windows\Fonts"

New-Item -Path "$my_fontdir" -ItemType Directory -Force | Out-Null
IF (!(Test-Path -Path "$my_fontdir\$my_nerdfont_ttf")) {
    & curl.exe -fsSLo "$my_nerdfont_ttf" 'https://github.com/ryanoasis/nerd-fonts/raw/v2.3.3/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf'
    & Move-Item "$my_nerdfont_ttf" "$my_fontdir"
}


Push-Location "$my_fontdir"

$regFontPath = "\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"
$fontRegistryPath = "HKCU:$regFontPath"
$fontFiles = Get-ChildItem -Recurse -Include *.ttf, *.otf
foreach ($font in $fontFiles) {
    # See https://github.com/PPOSHGROUP/PPoShTools/blob/master/PPoShTools/Public/FileSystem/Add-Font.ps1#L80
    Add-Type -AssemblyName System.Drawing
    $objFontCollection = New-Object System.Drawing.Text.PrivateFontCollection
    $objFontCollection.AddFontFile($font.FullName)
    $FontName = $objFontCollection.Families.Name

    $regTest = Get-ItemProperty -Path $fontRegistryPath -Name "*$FontName*" -ErrorAction SilentlyContinue
    if (-not ($regTest)) {
        New-ItemProperty -Name $FontName -Path $fontRegistryPath -PropertyType string -Value $font.Name
        Write-Output "Registered font {$($font.Name)} in Current User registry as {$FontName}"
    }
    Write-Output "Installed $my_nerdfont_ttf to $my_fontdir"
    # because adding to the registry alone doesn't actually take
    & start $font.FullName
    Write-Output ""
    Write-Output "IMPORTANT: Click 'Install' to complete installation"
}
