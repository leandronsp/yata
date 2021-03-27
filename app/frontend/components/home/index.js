function deleteTask(element) {
  var taskId = element.dataset["taskId"];

  fetch(`tasks/${taskId}`, { method: 'DELETE' })
    .then(response => response.text())
    .then(response => element.parentElement.remove())
}
