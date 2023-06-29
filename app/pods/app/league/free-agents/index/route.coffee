import map from 'lodash/map'
import merge from 'lodash/merge'
import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { DateTime } from 'luxon'
import { inject as I } from '@ember/service'

export default (Route.extend {

  queryParams:
    c:         { refreshModel: true, replace: true }
    p:         { refreshModel: false, replace: true }
    league_id: { refreshModel: true }
    
  auth: I()

  League:   (I 'models/league')
  Leagues:  (I 'models/leagues')
  LCards:   (I 'models/league/cards')
  router:   (I 'router')
  LSeasons: (I 'models/league-seasons')
  User:     (I 'models/user')

  beforeModel: ->
    await @.auth.waypoint({ notice: 'league/free-agents' })
    return

  model: (params) ->
    { c, p, league_id } = params

    [ league, leagues, cards, seasons, user ] = await (all [
      @.League.sync({ league_id })
      @.Leagues.sync()
      @.LCards.sync({ c, p, league_id })
      @.LSeasons.sync({ league_id })
      @.User.sync()
    ])

    cards.page.items = (map cards.page.items, (_c) ->
      return (merge _c, {
        ui:
          updated_at: DateTime.fromISO(_c.meta.updated_at).toFormat('yyyy.L.d')
      })
    )

    return { league, leagues, cards, seasons, user }

})
