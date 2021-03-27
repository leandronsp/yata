export default class HomeComponent extends HTMLElement {
  isAuthenticated() {
    return (localStorage.getItem('email') != null);
  }

  async connectedCallback() {
    if (this.isAuthenticated()) {
      let templateResponse = await fetch('./public/javascripts/components/home/template.html');
      let responseText = await templateResponse.text();

      let email = localStorage.getItem('email');
      responseText = responseText.replace("{{email}}", email);

      var xhr = new XMLHttpRequest();
      xhr.open("GET", "/api/users/" + encodeURIComponent(email) + "/tasks", true);
      xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
          let apiResponse = JSON.parse(xhr.responseText);
          debugger
        }
      };

      xhr.send();

      this.innerHTML = responseText;
    } else {
      window.history.pushState({}, '', '#/login');
      this.innerHTML = '<login-component></login-component>';
    }
  }
}

window.customElements.define('home-component', HomeComponent);
