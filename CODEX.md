# Pautas para Codex

## Objetivo del proyecto

Completar la práctica DevOps 00 con una web estática y una infraestructura AWS
mínima definida en Terraform.

## Reglas de trabajo

- Interpretar las menciones a Claude o Gemini de la práctica como Codex.
- No guardar credenciales AWS, tokens, claves privadas ni variables de entorno
  en archivos del repositorio.
- Mantener `main.tf` simple: proveedor AWS, bucket S3 y VPC de prueba.
- No añadir políticas públicas, configuración de hosting ni recursos extra salvo
  que el usuario lo pida expresamente.
- Mantener el estado local de Terraform fuera de Git.
- Revisar ortografía, legibilidad y presentación visual antes de entregar
  cambios.

## Comandos recomendados

```powershell
terraform fmt
terraform validate
terraform state list
aws sts get-caller-identity --region us-east-1
```

Para subir la web a S3, usar AWS CLI solo cuando las credenciales temporales del
Learner Lab estén cargadas en la terminal:

```powershell
aws s3 cp .\index.html s3://devops-prueba-david-2026-v2/index.html --region us-east-1
aws s3 sync .\css s3://devops-prueba-david-2026-v2/css --delete --region us-east-1
aws s3 sync .\js s3://devops-prueba-david-2026-v2/js --delete --region us-east-1
aws s3 sync .\assets s3://devops-prueba-david-2026-v2/assets --delete --region us-east-1
```

## Validación esperada

- `terraform validate` debe terminar correctamente.
- `terraform state list` debe mostrar `aws_s3_bucket.bucket_prueba`.
- El repositorio no debe incluir `terraform.tfstate`, `.terraform/`, `.env`,
  credenciales AWS ni archivos DOCX temporales.
- Si AWS Academy bloquea una operación, documentar el comando y el error sin
  intentar saltarse la política.
