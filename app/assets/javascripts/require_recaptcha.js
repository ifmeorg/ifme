function recaptcha_verified () {
  document.querySelector('.recaptcha-submit').removeAttribute('disabled')
}

function recaptcha_expired () {
  document.querySelector('.recaptcha-submit').setAttribute('disabled', 'disabled')
}
