import Controller from '@ember/controller'
import every from 'lodash/every'
import isEmpty from 'lodash/isEmpty'
import isString from 'lodash/isString'
import values from 'lodash/values'
import { action } from '@ember/object'
import { DateTime } from 'luxon'
import { get as g } from '@ember/object'
import { inject as I } from '@ember/service'
import { set as s } from '@ember/object'

export default Controller.extend({

  card_id: ''
  queryParams: [ 'card_id' ]

  api:    I()
  router: I()

  User:   (I 'models/user')

  validateForm: ->
    ok = (every (values (g @, 'form.valid')))
    (s @, 'form.ok', ok)
    return ok

  validateAbout: ->
    val = (g @, 'form.values.about')
    ok = (!(isEmpty val) && (isString val))
    (s @, 'form.valid.about', ok)
    return ok

  formKeyPress: (action ->
    return
  )

  formValueChanged: (action (_field, _s, _e) ->
    val = (if !_e then _s.target.value else _s)
    (s @, "form.values.#{_field}", val)

    switch _field
      when 'address' then @.validateAbout()

    @.validateForm()
    return
  )

  save: (action ->
    (s @, 'form.submitted', true)

    if !@.validateForm()
      return

    form = (g @, 'form')

    obj = 
      about:   form.values.about
      card_id: @.model.card.meta.id
      status:  form.values.status

    reply = await (@.api.echo {
      path: '/v2/card/update'
      data: obj
    })

    @.router.transitionTo('app.player-cards')
    return
  )

  toggleHelp: (action (field) ->
    (s @, "form.help.#{field}", !(g @, "form.help.#{field}"))
    return
  )


})