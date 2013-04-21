template = require 'views/templates/contact'
View = require 'views/base/view'

module.exports = class ContactView extends View
  autoRender: yes
  className: 'contact-page'
  container: '#page-container'
  template: template

  initialize: ()=>
    super
    @delegate 'click', '#submitContact', @postMessage
    @delegate 'click', '#closeSuccess', @closeSuccess
    @delegate 'click', '#closeError', @closeError

  render:()=>
    super
    @$('#contactSuccess').hide()
    @$('#contactError').hide()

  postMessage:()=>
    if validate()
      $('#contactError').hide()
      showSuccessAlert("<p> <strong>Thank you for your message we will be in touch soon. </strong>Please check your junk mail just in case.</P>")
      $.ajax
        url: "/api/contact/create",
        type: "post",
        data: $('#ContactForm').serialize()
        error: ()->
          $('#contactSuccess').hide()
          showErrorAlert("<p> <strong>Oops somethign has gone wrong. </strong>Please contact us on 07519746777 and we can sort you out.</P>")


  closeSuccess:()=>
    @$('#contactSuccess').hide()

  closeError:()=>
    @$('#contactError').hide()

  showSuccessAlert = (message)=>
    $('#successMessage').html(message)
    $('#contactSuccess').show()

  showErrorAlert = (message)=>
    $('#errorMessage').html(message)
    $('#contactError').show()

  validate = ()=>
    errors = []
    contactName = $('#contactName').val()
    contactEmail = $('#contactEmail').val()
    contactMessage = $('#contactMessage').val()
    contactSource = $('#contactSource').val()

    errors.push "<strong>Please fill out the following information: </strong><br>"
    if contactName.length < 1
      errors.push "-Your Name <br>"
    if contactMessage.length < 1
      errors.push "-Your Query <br>"
    if contactSource == "--Please Select--"
      errors.push "-How you heard of us <br>"
    if contactEmail.length < 1
      errors.push "-Your Email / Phone <br>"
    else
      if !validateEmail(contactEmail)
        errors.push "-Invalid Email Address <br>"
      if !validatePhone(contactEmail)
        errors.push "-Invalid Phone Number <br>"



    if errors.length >1
      showErrorAlert(errors)
      return false
    else
      return true

  validateEmail = (email)=>
    re = /\S+@\S+\.\S+/
    return re.test(email)

  validatePhone = (number)=>
    return number.split(/\d/).length===11



