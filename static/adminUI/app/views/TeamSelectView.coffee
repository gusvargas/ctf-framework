class TeamSelect extends Backbone.View
  tagName: 'select'
  className: 'chosen-select'

  render: ->
    @$el.append $(document.createElement 'option')

    @collection.each (team) ->
      $option = $(document.createElement 'option')
      $option.val(team.get 'id')
              .text team.get 'name'

      @$el.append $option
    , @

    @

  initChosen: ->
    @$el.chosen
      placeholder_text_single: 'Select a team'
      width: '200px'


module.exports = TeamSelect
