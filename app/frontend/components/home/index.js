function addTask(element, event) {
  event.preventDefault();

  if (event.keyCode === 13) {
    let headers = {
      'Content-Type': 'application/json'
    };

    let body = {};
    body[element.name] = element.value;

    var target = document.querySelector('[data-target=tasks-list]')

    fetch("tasks", { method: 'POST', headers: headers, body: JSON.stringify(body) })
      .then(response => response.text())
      .then(response => target.innerHTML = response)
      .then(_ => element.value = '')
  }
}

function deleteTask(element) {
  var taskId = element.dataset["taskId"];

  fetch(`tasks/${taskId}`, { method: 'DELETE' })
    .then(response => response.text())
    .then(response => element.parentElement.remove())
}
