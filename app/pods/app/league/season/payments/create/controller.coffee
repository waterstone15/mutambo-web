import Controller from '@ember/controller'
import every from 'lodash/every'
import isCurrency from 'validator/lib/isCurrency'
import isEmpty from 'lodash/isEmpty'
import isString from 'lodash/isString'
import set from 'lodash/set'
import trim from 'lodash/trim'
import values from 'lodash/values'
import { action } from '@ember/object'
import { computed } from '@ember/object'
import { get as eget } from '@ember/object'
import { inject as I } from '@ember/service'
import { set as eset } from '@ember/object'

export default (Controller.extend {

  api:     I()
  router:  I()

  league_id: ''
  season_id: ''
  queryParams: [ 'league_id', 'season_id', ]

  title_string: (computed 'model.league.val.name', 'model.season.val.name', ->
    ln = @.model.league?.val?.name ? 'League'
    sn = @.model.season?.val?.name ? 'Season'
    return "#{ln} → #{sn} → Payments → Create Payment - Mutambo"
    return title
  )

  validateForm: ->
    ok = (every (values (eget @, 'form.valid')))
    (eset @, 'form.ok', ok)
    return ok

  validateTitle: ->
    val = (eget @, 'form.values.title')
    ok  = !(isEmpty val) && (isString val)
    (eset @, 'form.valid.title', ok)
    return ok

  validateDescription: ->
    val = (eget @, 'form.values.description')
    ok  = !(isEmpty val) && (isString val)
    (eset @, 'form.valid.description', ok)
    return ok

  validatePrice: ->
    val = (eget @, 'form.values.price')
    ok  = (isCurrency val, { require_decimal: true })
    (eset @, 'form.valid.price', ok)
    return ok

  formValueChanged: (action ->
    if arguments.length == 2
      [ field, e ] = arguments
      (eset @, "form.values.#{field}", e.target.value)
    if arguments.length == 3
      [ field, selection, e ] = arguments
      (eset @, "form.values.#{field}", selection)

    switch field
      when 'description' then @.validateDescription()
      when 'price'       then @.validatePrice()
      when 'title'       then @.validateTitle()

    @.validateForm()
    return
  )

  toggleHelp: (action (field) ->
    (eset @, "form.help.#{field}", !(eget @, "form.help.#{field}"))
    return
  )

  create: action(->
    (eset @, 'form.submitted', true)

    @.validateDescription()
    @.validatePrice()
    @.validateTitle()

    if !@.validateForm()
      return

    form = (eget @, 'form')
    league_id = @.model.league.meta.id
    season_id = @.model.season.meta.id

    console.log JSON.stringify form, 2, 2

    obj = {}
    (set obj, 'rel.league',      @.model.league.meta.id)
    (set obj, 'rel.season',      @.model.season.meta.id)
    (set obj, 'val.amount',      (trim form.values.price))
    (set obj, 'val.currency',    (trim form.values.currency))
    (set obj, 'val.description', (trim form.values.description))
    (set obj, 'val.title',       (trim form.values.title))

    reply = await (@.api.echo {
      data: obj
      path: "/v2/season/payments/create"
    })

    q = { queryParams: { league_id, season_id }}
    @.router.transitionTo('app.league.season.payments', q)
    return
  )



})

