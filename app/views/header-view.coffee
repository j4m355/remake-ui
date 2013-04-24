View = require 'views/base/view'
template = require 'views/templates/header'
Spinner = components 'spin'

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
      #spinner = new Spinner({color:'#E8620C', lines: 12, width:1, radius:2}).spin(@$("#spin")[0]);
      $.ajax
        url: "/api/customer/login",
        type: "post",
        data: $('#loginForm').serialize()
        success: (e)->
          console.log e
        statusCode:
          401: ()->
            showErrorAlert("Incorrect Login or Password")
        error: (xhr, err, status)->
          console.log "Staus: " + status
          console.log "err: " + err
          console.log "error for 401"
          $('#loginSuccsesAlert').hide()
          showErrorAlert(xhr.responseText)

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