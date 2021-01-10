# see https://stackoverflow.com/questions/27294589/creating-self-signed-certificate-for-domain-and-subdomains-neterr-cert-commo

#Requires -RunAsAdministrator

function New-SelfSignedCert {
    $opensslPath = "C:\Program Files\Git\usr\bin\openssl.exe"
    
    if (-not (Test-Path $opensslPath)) {
        Write-Error "Could not find $opensslPath, this probably means you don't have " `
            + "64-bit Git for Windows installed (https://git-scm.com/download/win)"
    }

    Set-Alias openssl $opensslPath
    
    $certDir = "$PSScriptRoot\.certs"
    [System.IO.Directory]::CreateDirectory($certDir)

    $fqdn = "localhost"
    $key = "$certDir\$fqdn.key"
    $crt = "$certDir\$fqdn.crt"

    $sslCnf = (Get-Content -Path "$PSScriptRoot\openssl.cnf").Replace("{FQDN}", $fqdn)
    $sslCnfFile = [System.IO.Path]::GetTempFileName()
    Set-Content -Path $sslCnfFile -Value $sslCnf

    try {
        openssl req -x509 -sha256 -nodes -days 3650 -newkey rsa:2048 -keyout $key -out $crt  -config $sslCnfFile

        Import-Certificate -FilePath $crt -CertStoreLocation Cert:\LocalMachine\Root
    }
    finally {
       Remove-Item $sslCnfFile
    }
}

New-SelfSignedCert