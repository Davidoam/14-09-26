const checks = [
  { text: "Terraform gestiona el bucket S3.", state: "ok" },
  { text: "La web contiene HTML, CSS, JavaScript y recurso visual.", state: "ok" },
  { text: "Los archivos se pueden sincronizar con AWS CLI.", state: "minor" },
];

const labels = {
  ok: "Comprobado",
  minor: "Error menor",
  major: "Error grave",
};

function renderValidation() {
  const list = document.querySelector("#validation-list");
  list.innerHTML = "";

  checks.forEach((check) => {
    const item = document.createElement("li");
    item.dataset.state = check.state;
    item.textContent = `${labels[check.state]}: ${check.text}`;
    list.appendChild(item);
  });
}

document.querySelector("#check-button").addEventListener("click", renderValidation);
renderValidation();
