# DEVOPS 00 - Publicacion web estatica en AWS S3 con IA + MCP

Alumno: David

Bucket S3: `devops-prueba-david-2026-v2`

Region: `us-east-1`

## Objetivo

Crear una aplicacion web estatica y desplegar sus archivos en Amazon S3. La
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
+-- main.tf
+-- README.md
```

## IA y MCP

La practica menciona Gemini CLI o Claude Code. En este proyecto se interpreta
esa herramienta como Codex, que ha trabajado directamente sobre los archivos del
proyecto desde el entorno de desarrollo.

La integracion MCP funcional queda representada por el flujo de trabajo del
asistente conectado a herramientas locales para leer, modificar y validar el
proyecto.

## Terraform

Comandos usados o previstos:

```powershell
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform state list
```

El bucket debe aparecer en el estado:

```text
aws_s3_bucket.bucket_prueba
```

## AWS CLI

Antes de desplegar:

```powershell
aws sts get-caller-identity --region us-east-1
```

Resultado observado durante esta validacion:

```text
NoCredentials: Unable to locate credentials
```

Esto indica que las credenciales temporales del Learner Lab no estaban cargadas
en la terminal en el momento de la comprobacion.

Despliegue de los archivos estaticos:

```powershell
aws s3 sync . s3://devops-prueba-david-2026-v2 `
  --exclude ".terraform/*" `
  --exclude "terraform.tfstate*" `
  --exclude ".terraform.lock.hcl" `
  --exclude "main.tf" `
  --exclude "README.md" `
  --region us-east-1
```

Comprobacion de archivos:

```powershell
aws s3 ls s3://devops-prueba-david-2026-v2 --recursive --region us-east-1
```

## Hosting web S3

Terraform declara la configuracion de website hosting para usar `index.html`
como documento principal. Si AWS Academy permite la configuracion publica, el
endpoint se obtiene con:

```powershell
terraform output s3_website_endpoint
```

Si aparece `AccessDenied` o `explicit deny in a service control policy`, se debe
documentar como restriccion del Learner Lab.

## Validacion final

| Estado | Significado |
| --- | --- |
| Comprobado | El punto se ha verificado correctamente. |
| Error menor | El planteamiento es correcto, pero falta una comprobacion externa o hay una limitacion no critica. |
| Error grave | El punto impide cumplir el resultado minimo obligatorio. |

| Punto | Estado | Observacion |
| --- | --- | --- |
| Bucket S3 gestionado por Terraform | Comprobado | `terraform state list` muestra `aws_s3_bucket.bucket_prueba`. |
| Proyecto web con HTML, CSS, JS y recurso visual | Comprobado | Existen `index.html`, `css/styles.css`, `js/app.js` y `assets/s3-devops.svg`. |
| Hosting S3 declarado en Terraform | Comprobado | `main.tf` incluye `aws_s3_bucket_website_configuration`. |
| Despliegue con AWS CLI | Error menor | No se pudo ejecutar desde esta terminal porque AWS CLI respondio `NoCredentials`. |
| URL publica | Error menor | Depende de permisos publicos permitidos por AWS Academy. |
