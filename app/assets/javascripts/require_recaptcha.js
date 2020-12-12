function recaptcha_verified () {
  document.querySelector('.recaptcha_submit').removeAttribute('disabled')
}

function recaptcha_expired () {
  document.querySelector('.recaptcha_submit').setAttribute('disabled', 'disabled')
}
