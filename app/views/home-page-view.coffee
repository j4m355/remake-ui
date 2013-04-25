template = require 'views/templates/home'
View = require 'views/base/view'
mediator = require 'mediator'

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

  postcodeSearch:()=>
    mediator.publish 'postcodeSearch', "user"
    console.log "bon jovi"