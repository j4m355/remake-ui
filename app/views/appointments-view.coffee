template = require 'views/templates/appointments'
View = require 'views/base/view'

Calendar = components('calendar')

module.exports = class AppointmentsView extends View
  autoRender: yes
  className: 'appointments-page'
  container: '#page-container'
  template: template

  render:()=>
  	super
  	calendar = new Calendar()
  	calendar.el.appendTo(@$('#calendarView'))
  	calendar.on 'change', @select
  
  select: (dateOrEvent) =>
    if $(dateOrEvent.currentTarget).text() != "Next"
      if dateOrEvent.getTime
        @set dateOrEvent
      else
        @set new Date(dateString)