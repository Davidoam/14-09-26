# DEVOPS 00 - Publicación web estática en AWS S3 con IA + MCP

Alumno: David

Bucket S3: `devops-prueba-david-2026-v2`

Región: `us-east-1`

## Objetivo

Crear una aplicación web estática y desplegar sus archivos en Amazon S3. La
infraestructura se gestiona con Terraform y los archivos de la web se suben con
AWS CLI.

## Estructura

```text
.
+-- index.html
+-- css/
|   +-- styles.css
+-- js/
|   +-- app.js
+-- assets/
|   +-- s3-devops.svg
+-- CODEX.md
+-- main.tf
+-- README.md
```

## IA y MCP

La práctica menciona Gemini CLI o Claude Code. En este proyecto se interpreta
esa herramienta como Codex, que trabaja directamente sobre los archivos del
proyecto desde el entorno de desarrollo.

La integración MCP queda representada por el flujo de trabajo del asistente
conectado a herramientas locales para leer, modificar y validar el proyecto.

## Terraform

Comandos principales:

```powershell
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform state list
```

El archivo `main.tf` se mantiene mínimo, con:

- proveedor AWS en `us-east-1`;
- bucket S3 `devops-prueba-david-2026-v2`;
- configuración de hosting web estático para publicar por HTTP;
- política de lectura pública para los objetos del sitio;
- VPC de prueba `10.0.0.0/16`.

El bucket debe aparecer en el estado de Terraform:

```text
aws_s3_bucket.bucket_prueba
```

La política pública y la configuración de hosting son necesarias para que el
sitio sea accesible mediante el endpoint HTTP de S3. Si AWS Academy bloquea
alguna operación, se debe documentar el error exacto.

## AWS CLI

Antes de subir archivos, las credenciales temporales del Learner Lab deben estar
cargadas en PowerShell. La comprobación de identidad es:

```powershell
aws sts get-caller-identity --region us-east-1
```

Despliegue manual recomendado de los archivos estáticos:

```powershell
terraform apply -auto-approve
aws s3 cp .\index.html s3://devops-prueba-david-2026-v2/index.html --region us-east-1
aws s3 sync .\css s3://devops-prueba-david-2026-v2/css --delete --region us-east-1
aws s3 sync .\js s3://devops-prueba-david-2026-v2/js --delete --region us-east-1
aws s3 sync .\assets s3://devops-prueba-david-2026-v2/assets --delete --region us-east-1
terraform output s3_website_endpoint
```

Comprobación de archivos:

```powershell
aws s3 ls s3://devops-prueba-david-2026-v2 --recursive --region us-east-1
```

## Log de cambios

- Se eliminó `deploy-site.ps1` y todas sus referencias.
- Se quitó la validación de tres estados del README y de la interfaz.
- Se retiraron de Terraform las políticas públicas, la configuración de hosting
  S3 y los outputs añadidos previamente.
- Se dejó `main.tf` solo con bucket S3 y VPC.
- Se revisó la ortografía de la web y del README.
- Se mantuvo JavaScript separado para cumplir la estructura de la práctica.
- Se añadió `CODEX.md` con pautas para próximos mensajes.
- Se reintrodujo la configuración estrictamente necesaria para publicar por HTTP
  en S3 cuando el usuario pidió desplegar la web por HTTP.

## Validación

- `terraform validate` debe finalizar correctamente.
- `terraform state list` debe mostrar `aws_s3_bucket.bucket_prueba`.
- La web mantiene HTML, CSS, JavaScript y un recurso visual.
- El repositorio no debe contener credenciales ni estado local de Terraform.
- El endpoint HTTP se obtiene con `terraform output s3_website_endpoint` después
  de aplicar Terraform con credenciales activas.
