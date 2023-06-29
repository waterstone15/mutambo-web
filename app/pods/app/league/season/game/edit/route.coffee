import get from 'lodash/get'
import Route from '@ember/routing/route'
import toInteger from 'lodash/toInteger'
import isInteger from 'lodash/isInteger'
import { all } from 'rsvp'
import { DateTime } from 'luxon'
import { inject as I } from '@ember/service'

export default Route.extend({

  queryParams:
    game_id:   { refreshModel: true }
    league_id: { refreshModel: true }
    season_id: { refreshModel: true }

  auth:   I()
  router: I()

  League:   (I 'models/league')
  Leagues:  (I 'models/leagues')
  LSeasons: (I 'models/league-seasons')
  LSGame:   (I 'models/season/game')
  Season:   (I 'models/season')
  User:     (I 'models/user')

  beforeModel: ->
    await @.auth.waypoint()
    return

  model: (params) ->
    { game_id, league_id, season_id } = params

    [ game, league, leagues, seasons, season,  user, ] = await (all [
      @.LSGame   .sync({ game_id, season_id })
      @.League   .sync({ league_id })
      @.Leagues  .sync()
      @.LSeasons .sync({ league_id })
      @.Season   .sync({ season_id })
      @.User     .sync()
    ])

    return { game, league, leagues, seasons, season, user, }


  setupController: (controller, model) ->
    (@._super controller, model)

    _g = model.game ? null

    now = DateTime.local()
    date = null

    if (get model, 'game.val.start_utc')
      date = DateTime.fromFormat(_g.val.start_clock_time, "yyyy-MM-dd'T'HH:mm:ss", { zone: _g.val.start_timezone })

    (controller.setProperties {
      min_year: (toInteger (now.toFormat 'yyyy')) - 1
      max_year: (toInteger (now.toFormat 'yyyy')) + 20
      form:
        errors:
          location_text: []
          datetime: []
        help:
          location_text: false
          datetime: false
        ok: false
        submitted:  false
        valid:
          year:          true
          month:         true
          day:           true
          hour:          true
          minute:        true
          meridiem:      true
          timezone:      true
          datetime:      true
          location_text: true
          score:         true
          ext_id:        true
        values:
          year:     if date then (toInteger (date.toFormat 'y')) else ''
          month:    if date then (toInteger (date.toFormat 'L')) else ''
          day:      if date then (toInteger (date.toFormat 'd')) else ''
          hour:     if date then (toInteger (date.toFormat 'h')) else ''
          minute:   if date then (toInteger (date.toFormat 'm')) else ''
          meridiem: if date then (date.toFormat 'a')             else 'PM'
          timezone: if date then (date.toFormat 'z')             else 'America/Chicago'
          score:
            home:   if (isInteger (get _g, 'val.score.home')) then _g.val.score.home else ''
            away:   if (isInteger (get _g, 'val.score.away')) then _g.val.score.away else ''
          location_text: (get _g, 'val.location_text') ? null
        warnings:
          datetime: (!date || !date.isValid)
    })

})

