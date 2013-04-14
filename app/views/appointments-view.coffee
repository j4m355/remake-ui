template = require 'views/templates/appointments'
View = require 'views/base/view'

module.exports = class AppointmentsView extends View
  autoRender: yes
  className: 'appointments-page'
  container: '#page-container'
  template: template