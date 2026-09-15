$ErrorActionPreference = "Stop"

$bucket = "devops-prueba-david-2026-v2"
$region = "us-east-1"

function Invoke-Checked {
    param(
        [Parameter(Mandatory = $true)]
        [string] $Command,

        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]] $Arguments
    )

    & $Command @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "Command failed with exit code ${LASTEXITCODE}: $Command $($Arguments -join ' ')"
    }
}

Write-Host "Checking AWS identity..."
Invoke-Checked aws sts get-caller-identity --region $region

Write-Host "Validating Terraform..."
Invoke-Checked terraform fmt -check
Invoke-Checked terraform validate

Write-Host "Applying Terraform infrastructure..."
Invoke-Checked terraform apply -auto-approve

Write-Host "Uploading static website files to S3..."
Invoke-Checked aws s3 cp ".\index.html" "s3://$bucket/index.html" --content-type "text/html; charset=utf-8" --region $region
Invoke-Checked aws s3 sync ".\css" "s3://$bucket/css" --delete --content-type "text/css; charset=utf-8" --region $region
Invoke-Checked aws s3 sync ".\js" "s3://$bucket/js" --delete --content-type "application/javascript; charset=utf-8" --region $region
Invoke-Checked aws s3 sync ".\assets" "s3://$bucket/assets" --delete --region $region

Write-Host "Files currently in S3:"
Invoke-Checked aws s3 ls "s3://$bucket" --recursive --region $region

Write-Host "Website endpoint from Terraform:"
Invoke-Checked terraform output s3_website_endpoint
