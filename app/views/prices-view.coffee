template = require 'views/templates/prices'
View = require 'views/base/view'

module.exports = class PricesView extends View
  autoRender: yes
  className: 'prices-page'
  container: '#page-container'
  template: template
