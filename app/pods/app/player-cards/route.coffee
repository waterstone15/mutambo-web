import Route from '@ember/routing/route'
import { inject as I } from '@ember/service'
import { all } from 'rsvp'

export default (Route.extend {

  auth:   I()
  router: I()
  
  Card:    (I 'models/card')
  Leagues: (I 'models/leagues')
  User:    (I 'models/user')

  beforeModel: ->
    await @.auth.waypoint()
    return

  model: ->
    [ card, leagues, user, ] = await (all [
      @.Card.sync({ sport: 'Football (Soccer)' })
      @.Leagues.sync()
      @.User.sync()
    ])

    return { user, cards: [ card ], leagues }

})
