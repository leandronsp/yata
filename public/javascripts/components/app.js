import LoginComponent from './login/index.js'
import HomeComponent from './home/index.js'

export default class AppComponent extends HTMLElement {
  isAuthenticated() {
    return (localStorage.getItem('email') != null);
  }

  async connectedCallback() {
    if (this.isAuthenticated()) {
      window.history.pushState({}, '', '#/home');
      this.innerHTML = '<home-component></home-component>';
    } else {
      window.history.pushState({}, '', '#/login');
      this.innerHTML = '<login-component></login-component>';
    }
  }
}

window.customElements.define('app-component', AppComponent);
