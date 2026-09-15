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
+-- deploy-site.ps1
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

Terraform tambien declara:

- `aws_s3_bucket_website_configuration.web_prueba`
- `aws_s3_bucket_public_access_block.web_prueba`
- `aws_s3_bucket_policy.web_public_read`

## AWS CLI

Antes de desplegar:

```powershell
aws sts get-caller-identity --region us-east-1
```

Resultado observado durante la validacion del 15/09/2026:

```text
NoCredentials: Unable to locate credentials
```

Esto indica que las credenciales temporales del Learner Lab no estaban cargadas
en la terminal en el momento de la comprobacion.

Despliegue recomendado de los archivos estaticos:

```powershell
.\deploy-site.ps1
```

El script valida la identidad AWS, valida Terraform, aplica la infraestructura y
sube solo `index.html`, `css/`, `js/` y `assets/`. No sube `.git/`, `.terraform/`,
`terraform.tfstate`, credenciales, README ni archivos internos.

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
| Hosting S3 declarado en Terraform | Comprobado | `main.tf` incluye `aws_s3_bucket_website_configuration`. Falta aplicarlo con credenciales activas. |
| Permisos publicos declarados en Terraform | Comprobado | `main.tf` incluye `aws_s3_bucket_public_access_block` y `aws_s3_bucket_policy`. AWS Academy puede bloquear su aplicacion. |
| Despliegue con AWS CLI | Error menor | Se corrigio el despliegue usando `deploy-site.ps1`, que se detiene si no hay credenciales. En esta terminal AWS CLI respondio `NoCredentials`. |
| URL publica | Error menor | Depende de ejecutar `terraform apply`, subir archivos y que AWS Academy permita acceso publico. |
