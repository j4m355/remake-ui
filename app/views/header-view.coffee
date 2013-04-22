View = require 'views/base/view'
template = require 'views/templates/header'

module.exports = class HeaderView extends View
  autoRender: yes
  className: 'header'
  region: 'header'
  id: 'header'
  template: template

  initialize:()=>
    super
    @delegate 'click', "#Signin", @doLogin
    @delegate 'click', '#closeLoginSuccsesAlert', @closeLoginSuccsesAlert
    @delegate 'click', '#closeLoginErrorAlert', @closeLoginErrorAlert

  render:()=>
    super
    @$('#loginSuccsesAlert').hide()
    @$('#loginErrorAlert').hide()

  doLogin:()=>
    if validate()
      showSuccessAlert("<p> <strong>Thank you for your message we will be in touch soon. </strong>Please check your junk mail just in case.</P>")
      $.ajax
        url: "/api/customer/login",
        type: "post",
        data: $('#loginForm').serialize()
        success: (e)->
            console.log e
        error: (e)->
          $('#loginSuccsesAlert').hide()
          showErrorAlert(e)

  validate = ()=>
    errors = []
    loginEmail = $('#loginEmail').val()
    loginPassword = $('#loginPassword').val()

    errors.push "<strong>Please fill out the following information: </strong><br>"
    if loginEmail.length < 1
      errors.push "-Your Email <br>"
    if loginPassword.length < 1
      errors.push "-Your Password <br>"

    if errors.length >1
      showErrorAlert(errors)
      return false
    else
      return true

  closeLoginSuccsesAlert:()=>
    @$('#loginSuccsesAlert').hide()

  closeLoginErrorAlert:()=>
    @$('#loginErrorAlert').hide()

  showSuccessAlert = (message)=>
    $('#successMessage').html(message)
    $('#loginSuccsesAlert').show()

  showErrorAlert = (message)=>
    $('#errorMessage').html(message)
    $('#loginErrorAlert').show()