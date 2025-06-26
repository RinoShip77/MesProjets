<template>
  <nav class="navbar navbar-expand-lg bg-success-subtle">
    <div class="container-fluid">
      <a class="navbar-brand fs-1" href="">
        <i class="bi bi-tools"></i>
        MyBuilder
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
        aria-controls="offcanvasNavbar" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
        <div class="offcanvas-header">
          <h5 class="offcanvas-title" id="offcanvasNavbarLabel">
            <i class="bi bi-tools"></i>
          </h5>
          <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
        <div class="offcanvas-body align-items-center text-center fs-5">
          <ul class="navbar-nav justify-content-end flex-grow-1 pe-3 gap-2">
            <li class="nav-item">
              <a class="nav-link" aria-current="page" href="">Home</a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                Categories
              </a>
              <ul id="categoriesDropdown" class="dropdown-menu">
              </ul>
            </li>
            <li class="nav-item d-flex justify-content-around align-items-center me-4">
              <a class="nav-link" type="button" @click="switch_theme">
                <i id="themeSwitcher" class="bi bi-moon-stars-fill"></i>
              </a>
              <a class="nav-link position-relative me-2" type="button" data-bs-toggle="modal"
                data-bs-target="#cartModal" aria-label="cart" @click="open_cart">
                <i class="bi bi-cart-fill"></i>
                <span id="cartQuantity"
                  class="position-absolute top-25 start-100 translate-middle badge rounded-circle bg-secondary d-none">
                </span>
              </a>
              <a class="nav-link position-relative" type="button" data-bs-toggle="modal" data-bs-target="#loginModal"
                aria-label="Login">
                <i id="loginLink" class="bi bi-person-circle fs-4"></i>
                <span id="userStatus"
                  class="position-absolute top-25 start-75 translate-middle mt-1 p-2 bg-success border border-light rounded-circle d-none">
                  <span class="visually-hidden">Connected</span>
                </span>
              </a>
              <button id="logoutLink" class="btn btn-link d-none" @click="user_disconnect">
                Logout
              </button>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </nav>

  <!-- #region Modals -->
  <!-- Login modal -->
  <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModal" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h1 class="modal-title text-center fs-5">Connexion</h1>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="d-flex flex-column justify-content-center align-items-center">
            <div class="input-group mb-3">
              <span class="input-group-text">
                <i class="bi bi-at"></i>
              </span>
              <input id="login_email" class="form-control" type="email" placeholder="Please enter your email address.">
            </div>
            <div class="input-group mb-3">
              <span class="input-group-text">
                <i class="bi bi-shield-lock"></i>
              </span>
              <input id="login_password" class="form-control" type="password" placeholder="Please enter your password.">
            </div>
            <button type="submit" class="btn btn-dark fs-4 mt-3 ps-3 pe-3" @click="user_login">
              Login
              <i class="bi bi-unlock2-fill ms-3"></i>
            </button>
            <a class="btn btn-link" @click="user_login">
              Cheat
            </a>
          </div>
        </div>
        <div class="text-center">
          <p>
            No account yet?
            <button class="btn btn-link text-decoration-none text-dark fw-bold fs-5 ms-2" data-bs-target="#signUpModal"
              data-bs-toggle="modal">
              Sign up
            </button>
          </p>
        </div>
      </div>
    </div>
  </div>

  <!-- Sign up modal -->
  <div class="modal fade" id="signUpModal" aria-hidden="true" aria-labelledby="signUpModal" tabindex="-1">
    <div class="modal-dialog modal-xl">
      <div class="modal-content">
        <div class="modal-header">
          <h1 class="modal-title fs-5">Sign up</h1>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="d-flex flex-column justify-content-center align-items-center mx-5 px-5">
            <div class="d-flex gap-5 mb-3">
              <div class="input-group mx-3">
                <span class="input-group-text">
                  <i class="bi bi-person-vcard-fill"></i>
                </span>
                <div class="form-floating">
                  <input id="_firstName" class="form-control" type="text" placeholder="Please enter your first name.">
                  <label for="_firstName">First name</label>
                </div>
              </div>
              <div class="input-group mx-3">
                <span class="input-group-text">
                  <i class="bi bi-person-vcard-fill"></i>
                </span>
                <div class="form-floating">
                  <input id="_lastName" class="form-control" type="text" placeholder="Please enter your last name.">
                  <label for="_lastName">Last name</label>
                </div>
              </div>
            </div>
            <div class="input-group mb-3">
              <span class="input-group-text">
                <i class="bi bi-envelope-at-fill"></i>
              </span>
              <div class="form-floating">
                <input id="signup_email" class="form-control" type="email" placeholder="Please enter your email address.">
                <label for="signup_email">Email</label>
              </div>
            </div>
            <div class="input-group mb-3">
              <span class="input-group-text">
                <i class="bi bi-key-fill"></i>
              </span>
              <div class="form-floating">
                <input id="signup_password" class="form-control" type="password" placeholder="Please enter your password.">
                <label for="signup_password">Password</label>
              </div>
            </div>
            <button type="submit" class="btn btn-success fs-4 mt-3 ps-3 pe-3" @click="user_signup">
              Create account
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Cart modal -->
  <div class="modal fade" id="cartModal" aria-labelledby="exampleModalToggleLabel" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-xl">
      <div class="modal-content">
        <div class="modal-body d-flex">
          <div class="col-8 d-flex flex-column align-items-center rounded-5 bg-body-tertiary">
            <h1 class="text-center mt-3 mb-4 pb-3 border-bottom">
              Your Cart
              <i class="bi bi-basket2-fill me-1"></i>
            </h1>
            <div id="cart" class="d-flex flex-column align-items-center d-none">
              <div class="row m-3">
                <div class="card text-center">
                  <table class="table table-hover align-middle">
                    <thead>
                      <tr>
                        <th class="h5" scope="col">Visual</th>
                        <th class="h5" scope="col-3">Name</th>
                        <!-- <th class="h5" scope="col">Quantity</th> -->
                        <th class="h5" scope="col-2">Price</th>
                        <th class="h5" scope="col">Operation</th>
                      </tr>
                    </thead>
                    <tbody id="cartContainer">
                    </tbody>
                  </table>
                </div>
              </div>
              <div class="my-2 mb-5">
                <button class="btn btn-dark" @click="empty_cart">
                  <i class="bi bi-trash3 me-2"></i>Empty the cart
                </button>
              </div>
            </div>
            <div id="emptyCartMessage" class="d-none">
              <p class="display-6 mt-4 text-center text-white bg-dark rounded m-3 p-3" id="txtRaleway">
                Your cart is empty.
              </p>
            </div>
          </div>
          <div class="col-4">
            <h1 class="text-center mt-3 mb-4 pb-3">
              Summary
              <i class="bi bi-currency-dollar me-1"></i>
            </h1>
            <div class="row fs-5 mx-2">
              <div class="my-1">
                <div class="d-flex justify-content-between">
                  <p>Subtotal</p>
                  <p id="subtotalLabel" class="fw-bolder fs-4"></p>
                </div>
                <hr>
              </div>
              <div class="my-1">
                <div class="d-flex justify-content-between">
                  <p>GST</p>
                  <p id="gstLabel" class="fw-bolder fs-4"></p>
                </div>
                <hr>
              </div>
              <div class="my-1">
                <div class="d-flex justify-content-between">
                  <p>QST</p>
                  <p id="qstLabel" class="fw-bolder fs-4"></p>
                </div>
                <hr>
              </div>
              <div class="my-1">
                <div class="d-flex justify-content-between">
                  <p>Delivery fee</p>
                  <p id="deliveryLabel" class="fw-bolder fs-4"></p>
                </div>
                <hr>
              </div>
              <div class="my-1">
                <div class="d-flex justify-content-between">
                  <p>Total</p>
                  <p id="totalLabel" class="fw-bolder fs-4"></p>
                </div>
                <hr>
              </div>
              <div class="text-center my-5">
                <a id="checkoutLink" class="btn btn-success align-items-center fs-5" @click="checkout()">
                  Go to checkout
                  <i class="bi bi-cash-coin m-2"></i>
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- #endregion Modals -->
</template>

<script>
import { switchTheme } from "../assets/js/helpers/functions";
import { openCart, emptyCart } from "../assets/js/components/cart/cart";
import { disconnect, login, signup } from "../assets/js/components/user/user";

export default {
  methods: {
    switch_theme() {
      switchTheme();
    },

    open_cart() {
      openCart();
    },

    user_disconnect() {
      disconnect();
    },

    user_login() {
      login(document.getElementById('login_email').value.trim(), document.getElementById('login_password').value.trim());
    },

    empty_cart() {
      emptyCart();
    },

    user_signup() {
      signup(document.getElementById('_firstName').value, document.getElementById('_lastName').value, document.getElementById('signup_email').value, document.getElementById('signup_password').value);
    }
  }
};
</script>