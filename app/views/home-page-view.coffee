template = require 'views/templates/home'
View = require 'views/base/view'
mediator = require 'mediator'
AppointmentWizardView = require './appointmentWizard-view'


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
      #dingo = new AppointmentWizardView()
      postcode = @$('#postcodeBox').val()
      #mediator.publish 'postcodeSearch', theZep
      #@dispose()
      $.ajax
      url: "/api/postcode/?postcode=" + postcode,
      type: "post"
      error: (e)->
        console.log e
      success: (e)->
        console.log e