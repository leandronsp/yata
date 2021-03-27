import HomeComponent from '../home/index.js'

export default class LoginComponent extends HTMLElement {
  async connectedCallback() {
    let templateResponse = await fetch('./public/javascripts/components/login/template.html');
    this.innerHTML = await templateResponse.text();
    let shadowRoot = this;

    this.$loginForm = document.querySelector('.login-form');

    this.$loginForm.onclick = function(event) {
      event.preventDefault();
      let email = this.querySelector('input[name=email]').value;
      let password = this.querySelector('input[name=password]').value;

      var xhr = new XMLHttpRequest();
      xhr.open("POST", "/api/login", true);
      xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

      xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
          let apiResponse = JSON.parse(xhr.responseText);
          localStorage.setItem('email', apiResponse.email);
          window.history.pushState({}, '', '#/home');
          shadowRoot.innerHTML = '<home-component></home-component>';
        }
      };

      xhr.send("email=" + email + "&password=" + password);
    };
  }
}

window.customElements.define('login-component', LoginComponent);
