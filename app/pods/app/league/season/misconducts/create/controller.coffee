import Controller from '@ember/controller'
import every from 'lodash/every'
import find from 'lodash/find'
import includes from 'lodash/includes'
import isCurrency from 'validator/lib/isCurrency'
import isInteger from 'lodash/isInteger'
import readInt from 'lodash/parseInt'
import set from 'lodash/set'
import trim from 'lodash/trim'
import values from 'lodash/values'
import { action } from '@ember/object'
import { all } from 'rsvp'
import { computed } from '@ember/object'
import { get as eget } from '@ember/object'
import { inject as I } from '@ember/service'
import { set as eset } from '@ember/object'

export default (Controller.extend {

  api:     I()
  router:  I()

  LSTGames:  (I 'models/season/team/games')
  LSTPeople: (I 'models/season/team/people')

  league_id: ''
  season_id: ''
  queryParams: [ 'league_id', 'season_id', ]

  title_string: computed('model.league.val.name', 'model.season.val.name', ->
    ln = @.model.league?.val?.name ? 'League'
    sn = @.model.season?.val?.name ? 'Season'
    return "#{ln} → #{sn} → Misconduct → Create Misconduct - Mutambo"
    return title
  )

  validateForm: ->
    ok = (every (values (eget @, 'form.valid')))
    (eset @, 'form.ok', ok)
    return ok

  validateTeam: ->
    val = (eget @, 'form.values.team')
    ok  = !!val
    (eset @, 'form.valid.team', ok)
    return ok

  validateGame: ->
    val = (eget @, 'form.values.game')
    ok  = !!val
    (eset @, 'form.valid.game', ok)
    return ok

  validatePerson: ->
    val = (eget @, 'form.values.person')
    ok  = !!val
    (eset @, 'form.valid.person', ok)
    return ok

  validateDemerits: ->
    val = (eget @, 'form.values.demerits')
    ok  = (isInteger (readInt val))
    (eset @, 'form.valid.demerits', ok)
    return ok

  validateScope: ->
    val = (eget @, 'form.values.scope')
    ok  = (includes [ 'league', 'season', 'team' ], val)
    (eset @, 'form.valid.scope', ok)
    return ok

  validateFee: ->
    val = (eget @, 'form.values.fee')
    ok  = (isCurrency val, { require_decimal: true })
    (eset @, 'form.valid.fee', ok)
    return ok

  formValueChanged: (action ->
    if arguments.length == 2
      [ field, e ] = arguments
      (eset @, "form.values.#{field}", e.target.value)
    if arguments.length == 3
      [ field, selection, e ] = arguments
      (eset @, "form.values.#{field}", selection)

    switch field
      when 'demerits' then @.validateDemerits()
      when 'fee'      then @.validateFee()
      when 'game'     then @.validateGame()
      when 'person'   then @.validatePerson()
      when 'scope'    then @.validateScope()
      when 'team'     then @.validateTeam()

    @.validateForm()
    return
  )

  toggleHelp: (action (field) ->
    (eset @, "form.help.#{field}", !(eget @, "form.help.#{field}"))
    return
  )

  create: (action ->
    (eset @, 'form.submitted', true)

    if !@.validateForm()
      return

    form = (eget @, 'form')
    
    league_id = @.model.league.meta.id
    season_id = @.model.season.meta.id
    
    _d = form.values.demerits
    demerits = if (isInteger (readInt _d)) then _d else null

    obj = {}
    (set obj, 'rel.game',     form.values.game.meta.id)
    (set obj, 'rel.league',   league_id)
    (set obj, 'rel.person',   form.values.person.meta.id)
    (set obj, 'rel.season',   season_id)
    (set obj, 'rel.team',     form.values.team.meta.id)
    (set obj, 'val.demerits', demerits)
    (set obj, 'val.fee',      (trim form.values.fee))
    (set obj, 'val.scope',    form.values.scope)

    reply = await (@.api.echo {
      data: obj
      path: "/v2/season/misconducts/create"
    })

    q = { queryParams: { league_id, season_id }}
    @.router.transitionTo('app.league.season.misconducts', q)
    return
  )

  selectTeam: (action (e) ->
    tid = e.target.value
    team = (find (eget @, 'model.teams'), { meta: { id: tid }}) ? null
    (eset @, 'form.values.team', team)

    [ games, people ] = await (all [
      (@.LSTGames.sync {
        season_id: @.model.season.meta.id,
        team_id:   tid
      })
      (@.LSTPeople.sync {
        season_id: @.model.season.meta.id,
        team_id:   tid
      })
    ])

    (eset @, 'games', games)
    (eset @, 'people', people)

    @.validateTeam()
    @.validateForm()
    return
  )

  selectGame: (action (e) ->
    game = (find (eget @, 'games'), { meta: { id: e.target.value }}) ? null
    (eset @, 'form.values.game', game)
    @.validateGame()
    @.validateForm()
    return
  )

  selectPerson: (action (e) ->
    person = (find (eget @, 'people'), { meta: { id: e.target.value }}) ? null
    (eset @, 'form.values.person', person)
    @.validatePerson()
    @.validateForm()
    return
  )

})

