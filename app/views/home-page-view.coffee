template = require 'views/templates/home'
View = require 'views/base/view'
mediator = require 'mediator'
AppointmentWizardView = require './appointmentWizard-view'
Spinner = components 'spin.js'


module.exports = class HomePageView extends View
  autoRender: yes
  className: 'home-page'
  container: '#page-container'
  template: template

  initialize: ()=>
    super
    @delegate 'keyup', '#postcodeBox', @postcodeSearch

  render:()=>
    @$el.hide()
    super
    @$('.carousel').carousel()
    @$el.fadeIn()
    #@$el.show('slide', {direction : 'right'}, 1000)



  postcodeSearch:(e)=>
    if e.keyCode is 13
      $.ajax
        url: "/api/postcode",
        type: "post",
        data: $('#postcodeBox').serialize()
        success: (jqXhr, textStatus)->
          console.log jqXhr.responseText
          console.log textStatus
        error: ()->
          console.log "error"

      