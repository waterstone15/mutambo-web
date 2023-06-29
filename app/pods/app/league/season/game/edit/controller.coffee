import Controller from '@ember/controller'
import every from 'lodash/every'
import isEmpty from 'lodash/isEmpty'
import isNull from 'lodash/isNull'
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

  api:    I()
  router: I()

  game_id:   ''
  league_id: ''
  season_id: ''
  queryParams: [ 'game_id', 'league_id', 'season_id' ]

  title_string: (computed 'model.league.val.name', 'model.season.val.name', ->
    ln = @.model.league?.val?.name ? 'League'
    sn = @.model.season?.val?.name ? 'Season'
    return "#{ln} → #{sn} → Games → Edit Game - Mutambo"
  )

  validateForm: ->
    ok = (every (values (eget @, 'form.valid')))
    (eset @, 'form.ok', ok)
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

  save: (action ->
    (eset @, 'form.submitted', true)

    if !@.validateForm()
      return

    form = (eget @, 'form')
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

    sc =
      away: form.values.score.away
      home: form.values.score.home
    score = 
      away: if (!(isEmpty sc.away) || sc.away == '0') then (toInteger sc.away) else null
      home: if (!(isEmpty sc.home) || sc.home == '0') then (toInteger sc.home) else null

    obj = {}
    (set obj, 'meta.id',              @.model.game.meta.id)
    (set obj, 'rel.season',           season_id)
    (set obj, 'val.location_text',    (trim form.values.location_text))
    (set obj, 'val.score',            score)
    (set obj, 'val.start_clock_time', if dt.isValid then (dt.toFormat "yyyy-MM-dd'T'HH:mm:ss") else null)
    (set obj, 'val.start_timezone',   if dt.isValid then (dt.toFormat "z") else null)

    reply = await (@.api.echo {
      data: obj
      path: "/v2/season/game/update"
    })

    q = { queryParams: { league_id, season_id }}
    @.router.transitionTo('app.league.season.games', q)
    return
  )

  toggleMeridiem: (action ->
    m = (eget @, "form.values.meridiem")
    (eset @, "form.values.meridiem", if (m == 'AM') then 'PM' else 'AM')
    @.validateDateTime()
    return
  )

})
