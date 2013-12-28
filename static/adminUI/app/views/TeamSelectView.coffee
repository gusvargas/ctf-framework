App = require 'application'

class TeamSelect extends Backbone.View
  tagName: 'select'
  className: 'chosen-select'

  initialize: ->
    @listenTo @collection, 'destroy', @updateSelection

  updateSelection: ->
    @render()
    @$el.trigger 'chosen:updated'

  render: ->
    @$el.empty()

    @$el.append $(document.createElement 'option')
    @collection.each (team) ->
      $option = $(document.createElement 'option')
      $option.val(team.get 'id')
              .text team.get 'name'

      @$el.append $option
    , @

    @

  initChosen: ->
    @$el.chosen(
      placeholder_text_single: 'Select a team'
      width: '200px'
    ).change (e, selObj) =>
      selectedId = +selObj.selected
      team = @collection.get selectedId

      App.vent.trigger 'teams:edit', team

module.exports = TeamSelect
