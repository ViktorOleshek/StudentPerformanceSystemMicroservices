# Generate self-signed certificates for Docker services using PowerShell
Write-Host "Generating self-signed certificates for Docker services..." -ForegroundColor Green

# Create certs directory if it doesn't exist
$certsDir = ".\certs"
if (!(Test-Path $certsDir)) {
    New-Item -ItemType Directory -Path $certsDir
}

# Services and their DNS names
$services = @("auth", "users", "courses", "grades")

foreach ($serviceName in $services) {
    Write-Host "Generating certificate for $serviceName service..." -ForegroundColor Yellow
    
    # Create self-signed certificate
    $cert = New-SelfSignedCertificate `
        -DnsName $serviceName, "localhost", "127.0.0.1" `
        -CertStoreLocation "cert:\LocalMachine\My" `
        -NotAfter (Get-Date).AddYears(1) `
        -FriendlyName "GradeHub $serviceName Service" `
        -KeyUsage DigitalSignature, KeyEncipherment `
        -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.1") `
        -KeyAlgorithm RSA `
        -KeyLength 2048
    
    # Export certificate to PFX file
    $pfxPath = "$certsDir\$serviceName.pfx"
    $password = ConvertTo-SecureString -String "password" -Force -AsPlainText
    Export-PfxCertificate -Cert $cert -FilePath $pfxPath -Password $password | Out-Null
    
    # Remove certificate from store
    Remove-Item -Path "cert:\LocalMachine\My\$($cert.Thumbprint)" -Force
    
    Write-Host "Certificate generated for $serviceName at $pfxPath" -ForegroundColor Green
}

Write-Host "All certificates generated successfully!" -ForegroundColor Green
Write-Host "Certificates are stored in the 'certs' directory" -ForegroundColor Cyan
Write-Host "Certificate password: password" -ForegroundColor Yellow
