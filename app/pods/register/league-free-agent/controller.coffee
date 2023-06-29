import * as lz from 'lz-string'
import cloneDeep from 'lodash/cloneDeep'
import Controller from '@ember/controller'
import every from 'lodash/every'
import isEmpty from 'lodash/isEmpty'
import isString from 'lodash/isString'
import values from 'lodash/values'
import { action, computed, get, set } from '@ember/object'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default Controller.extend({

  api:    I()
  router: I()

  User: I('models/user')

  title_string: computed('model.league.name', ->
    ln = get(@, 'model.league.val.name')
    return (ln || 'League') + ' → Free Agent Registration - Mutambo'
  )

  validateForm: ->
    formOk = every(values(get(@, 'form.valid')))
    set(@, 'form.ok', formOk)
    return formOk

  validateAbout: ->
    val = get(@, 'form.values.about')
    ok  = isString(val) && !isEmpty(val)
    set(@, 'form.valid.about', ok)
    return ok

  validateDisplayName: ->
    val = get(@, 'form.values.display_name')
    ok  = @.User.ok.displayName(val)
    set(@, 'form.valid.display_name', ok)
    return ok

  formKeyPress: action((field, e) ->
    # switch field
    #   when 'email'
    #     @sendCodeEmail() if (e.code == 'Enter' || e.code == 'NumpadEnter') && @validateForm()
    return
  )

  formValueChanged: action(() ->
    if arguments.length == 2
      [ field, e ] = arguments
      set(@, "form.values.#{field}", e.target.value)
    if arguments.length == 3
      [ field, selection, e ] = arguments
      set(@, "form.values.#{field}", selection)

    switch field
      when 'about'        then @.validateAbout()
      when 'display_name' then @.validateDisplayName()

    @.validateForm()
    return
  )

  register: action(->
    set(@, 'form.submitted', true)

    if !@.validateForm()
      return

    form = cloneDeep(get(@, 'form'))

    obj =
      form: form.values
      code: @.model.code

    reply = await @.api.echo({
      data: obj
      path: '/v2/registrations/league-free-agent/create'
    })

    await all([
      @.User.sync({ force: true })
    ])

    if reply?
      q = { queryParams: { league_id: @.model.league.meta.id }}
      @.router.transitionTo('app.league.free-agents.index', q)
    else
      @.router.transitionTo('app.player-cards')
    return
  )

  toggleHelp: action((field) ->
    set(@, "form.help.#{field}", !get(@, "form.help.#{field}"))
    return
  )


})