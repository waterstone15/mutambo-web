import Controller from '@ember/controller'
import copy from 'copy-to-clipboard'
import every from 'lodash/every'
import toLower from 'lodash/toLower'
import values from 'lodash/values'
import { action } from '@ember/object'
import { computed } from '@ember/object'
import { get as eget } from '@ember/object'
import { inject as I } from '@ember/service'
import { Notyf } from 'notyf'
import { set as eset } from '@ember/object'


export default (Controller.extend {

  api: I()
  router: I()

  team_id: ''
  queryParams: [ 'team_id' ]

  notyf: undefined

  showInviteManagers: false
  showInvitePlayers: false

  title_string: (computed 'model.team.val.name', ->
    tn = (eget @, 'model.team.val.name')
    return (tn || 'Team')  + ' - Mutambo'
  )

  willDestroy: ->
    @.notyf = null

  toggleInviteManagers: action(->
    (eset @, 'showInviteManagers', !eget(@, 'showInviteManagers'))
    return
  )

  toggleInvitePlayers: action(->
    (eset @, 'showInvitePlayers', !eget(@, 'showInvitePlayers'))
    return
  )

  copy: (action (path)->
    if !@.notyf
      @.notyf = (new Notyf {
        types: [
          {
            type: 'info'
            position: { x: 'center', y: 'bottom' }
            ripple: false
            icon: false
            dismissable: false
          }
        ]
      })

    (copy @.model[path].ui.link)

    (@.notyf.open {
      className: 'info-toast'
      type: 'info'
      message: 'Link Copied'
      duration: 2500
    })

    return
  )

  show_remove_player_box: false

  toggleRemovePlayerBox: (action (player) ->
    (eset @, 'show_remove_player_box', !(eget @, 'show_remove_player_box'))
    (eset @, 'form.values.confirm_text', '')
    (eset @, 'form.values.player', (player ? null))
    return
  )

  validateForm: ->
    ok = (every (values (eget @, 'form.valid')))
    (eset @, 'form.ok', ok)
    return ok


  validateConfirmText: ->

    val = (eget @, 'form.values.confirm_text')
    ok  = ('remove' == (toLower val))
    (eset @, 'form.valid.confirm_text', ok)
    return ok


  formValueChanged: (action ->
    if arguments.length == 2
      [ field, e ] = arguments
      (eset @, "form.values.#{field}", e.target.value)
    if arguments.length == 3
      [ field, selection, e ] = arguments
      (eset @, "form.values.#{field}", selection)

    switch field
      when 'confirm_text' then @.validateConfirmText()

    @.validateForm()
    return
  )

  confirm: (action ->
    (eset @, 'form.submitted', true)

    if !@.validateForm()
      return

    form = (eget @, 'form')
    obj =
      player_id: (eget form, 'values.player.meta.id')
      team_id:   @.model.team.meta.id

    reply = await (@.api.echo {
      data: obj
      path: "/v2/team/remove-player"
    })

    if !@.notyf
      @.notyf = new Notyf({
        types: [
          {
            type: 'info'
            position: { x: 'center', y: 'bottom' }
            ripple: false
            icon: false
            dismissable: false
          }
        ]
      })

    if reply
      @.notyf.open({
        className: 'info-toast'
        type: 'info'
        message: 'Player Removed'
        duration: 2500
      })

    (@.send 'toggleRemovePlayerBox')
    (@.send 'reload')
    return
  )

})