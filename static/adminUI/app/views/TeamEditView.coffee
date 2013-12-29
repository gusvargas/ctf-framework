template = require 'views/templates/teamEdit'
App = require 'application'

class TeamEdit extends Backbone.Marionette.ItemView
  template: template
  className: 'team-edit-container'

  ui:
    password: 'input.password'
    admin: 'input.admin-status'

  events:
    'click .update-password': 'updatePassword'
    'change .admin-status': 'updateAdminStatus'
    'click .delete': 'deleteTeam'

  initialize: ->
    @listenTo App.vent, 'teams:edit', @setModel

  setModel: (model) ->
    if @model?
      @stopListening @model

    @model = model
    @render()

  serializeData: ->
    isAdmin: @model?.get 'admin'

  updatePassword: ->
    attrs =
      password: @ui.password.val()

    @updateTeam attrs

  updateAdminStatus: ->
    attrs =
      admin: +@ui.admin.is ':checked'

    @updateTeam attrs

  updateTeam: (attrs) ->
    unless _.isEmpty attrs
      @model?.save attrs,
        wait: true
        patch: true

  deleteTeam: ->
    @model?.destroy()

module.exports = TeamEdit
