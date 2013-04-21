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
    @$('#sending').hide()

  postMessage:()=>
    #@$('#sending').show()
    showSuccessAlert("<p> <strong>Thank you for your message we will be in touch soon. </strong>Please check your junk mail just in case.</P>")
    $.ajax
      url: "/api/contact/create",
      type: "post",
      data: $('#ContactForm').serialize()
      error: ()->
        showErrorAlert("<p> <strong>Oops somethign has gone wrong. </strong>Please contact us on 07519746777 and we can sort you out.</P>")

  closeSuccess:()=>
    @$('#contactSuccess').hide()

  closeError:()=>
    @$('#contactError').hide()

  showSuccessAlert = (message)=>
    $('#sending').hide()
    $('#successMessage').html(message)
    $('#contactSuccess').show()
    

  showErrorAlert = (message)=>
    $('#sending').hide()
    $('#errorMessage').html(message)
    $('#contactError').show()
    



