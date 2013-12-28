Team = require 'models/Team'

class Teams extends Backbone.Collection
  model: Team
  url: '/api/teams'

module.exports = Teams
