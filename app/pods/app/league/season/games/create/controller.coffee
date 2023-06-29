import Controller from '@ember/controller'
import every from 'lodash/every'
import find from 'lodash/find'
import findIndex from 'lodash/findIndex'
import get from 'lodash/get'
import isString from 'lodash/isString'
import set from 'lodash/set'
import toInteger from 'lodash/toInteger'
import toString from 'lodash/toString'
import trim from 'lodash/trim'
import values from 'lodash/values'
import { action } from '@ember/object'
import { computed } from '@ember/object'
import { DateTime } from 'luxon'
import { get as eget } from '@ember/object'
import { inject as I } from '@ember/service'
import { set as eset } from '@ember/object'

export default (Controller.extend {

  api:     I()
  router:  I()

  league_id: ''
  season_id: ''
  queryParams: [ 'league_id', 'season_id', ]

  title_string: computed('model.league.val.name', 'model.season.val.name', ->
    ln = @.model.league?.val?.name ? 'League'
    sn = @.model.season?.val?.name ? 'Season'
    return "#{ln} → #{sn} → Games → Create Game - Mutambo"
    return title
  )

  toggleMeridiem: (action ->
    m = (eget @, "form.values.meridiem")
    (eset @, "form.values.meridiem", if (m == 'AM') then 'PM' else 'AM')
    @.validateDateTime()
    return
  )

  validateForm: ->
    ok = (every (values (eget @, 'form.valid')))
    (eset @, 'form.ok', ok)
    return ok

  validateAwayTeam: ->
    at = (eget @, 'form.values.away_team')
    ht = (eget @, 'form.values.home_team')

    ok = !!at && (at?.meta?.id != ht?.meta?.id)
    (eset @, 'form.valid.away_team', ok)
    return ok

  validateHomeTeam: ->
    at = (eget @, 'form.values.away_team')
    ht = (eget @, 'form.values.home_team')

    ok = !!ht && (at?.meta?.id != ht?.meta?.id)
    (eset @, 'form.valid.home_team', ok)
    return ok

  validateDateTime: ->
    fmt = (_v) -> if (_v == '') then null else (toString (toInteger _v))
    
    yr  = (fmt (eget @, 'form.values.year'))
    mo  = (fmt (eget @, 'form.values.month'))
    day = (fmt (eget @, 'form.values.day'))
    hr  = (fmt (eget @, 'form.values.hour'))
    min = (fmt (eget @, 'form.values.minute'))
    mer = (eget @, 'form.values.meridiem')
    tz  = (eget @, 'form.values.timezone')

    dt = DateTime.fromFormat("#{yr}-#{mo}-#{day} #{hr}:#{min} #{mer}", 'y-L-d h:m a', { zone: tz })

    ok = dt.isValid
    (eset @, 'form.warnings.datetime', !ok)
    return ok

  validateLocationText: ->
    val = (eget @, 'form.values.location_text')
    ok = (isString val)
    (eset @, 'form.valid.location_text', ok)
    return ok

  formValueChanged: (action ->
    if arguments.length == 2
      [ field, e ] = arguments
      (eset @, "form.values.#{field}", e.target.value)
    if arguments.length == 3
      [ field, selection, e ] = arguments
      (eset @, "form.values.#{field}", selection)

    switch field
      when 'day' then @.validateDateTime()
      when 'hour' then @.validateDateTime()
      when 'location_text' then @.validateLocationText()
      when 'minute' then @.validateDateTime()
      when 'month' then @.validateDateTime()
      when 'year' then @.validateDateTime()

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

    form = eget(@, 'form')
    league_id = @.model.league.meta.id
    season_id = @.model.season.meta.id

    fmt = (_v) -> if (_v == '') then null else (toString (toInteger _v))

    yr  = (fmt (eget @, 'form.values.year'))
    mo  = (fmt (eget @, 'form.values.month'))
    day = (fmt (eget @, 'form.values.day'))
    hr  = (fmt (eget @, 'form.values.hour'))
    min = (fmt (eget @, 'form.values.minute'))
    mer = (eget @, 'form.values.meridiem')
    tz  = (eget @, 'form.values.timezone')

    dt = DateTime.fromFormat("#{yr}-#{mo}-#{day} #{hr}:#{min} #{mer}", 'y-L-d h:m a', { zone: tz })

    obj = {}
    (set obj, 'ext.gameofficials',    (trim form.values.ext_id))
    (set obj, 'rel.away_team',        form.values.away_team.meta.id)
    (set obj, 'rel.home_team',        form.values.home_team.meta.id)
    (set obj, 'rel.season',           season_id)
    (set obj, 'val.location_text',    (trim form.values.location_text))
    (set obj, 'val.start_clock_time', if dt.isValid then (dt.toFormat "yyyy-MM-dd'T'HH:mm:ss") else null)
    (set obj, 'val.start_timezone',   if dt.isValid then (dt.toFormat "z") else null)

    reply = await (@.api.echo {
      data: obj
      path: "/v2/season/games/create"
    })

    q = { queryParams: { league_id, season_id }}
    @.router.transitionTo('app.league.season.games', q)
    return
  )

  selectHomeTeam: (action (e) ->
    team = (find (eget @, 'model.teams'), { meta: { id: e.target.value }}) ? null
    (eset @, 'form.values.home_team', team)
    @.validateHomeTeam()
    @.validateAwayTeam()
    @.validateForm()
    return
  )

  selectAwayTeam: (action (e) ->
    team = (find (eget @, 'model.teams'), { meta: { id: e.target.value }}) ? null
    (eset @, 'form.values.away_team', team)
    @.validateAwayTeam()
    @.validateHomeTeam()
    @.validateForm()
    return
  )

})

