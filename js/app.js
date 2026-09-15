const updatedAt = document.querySelector("#updated-at");

if (updatedAt) {
  updatedAt.textContent = new Intl.DateTimeFormat("es-ES", {
    dateStyle: "long",
    timeStyle: "short",
  }).format(new Date());
}
