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
  	@$('#contactError').show()

  postMessage:()=>
  	$.ajax
  		url: "/api/contact/create",
  		type: "post",
  		data: $('#ContactForm').serialize()
  		success: ()->
  			@$('#contactSuccess').show()
		error: ()->
			@$('#contactError').show()

  closeSuccess:()=>
  	@$('#contactSuccess').hide()

  closeError:()=>
  	@$('#contactError').hide()

