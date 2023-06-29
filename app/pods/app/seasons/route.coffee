import Route from '@ember/routing/route'
import { inject as I } from '@ember/service'
import { all } from 'rsvp'

export default (Route.extend {

  auth:   I()
  router: I()
  
  Leagues: (I 'models/leagues')
  Seasons: (I 'models/seasons')
  User:    (I 'models/user')

  beforeModel: ->
    await this.auth.waypoint()
    return

  model: ->
    [ user, seasons, leagues ] = await (all [
      @User.sync()
      @Seasons.sync()
      @Leagues.sync()
    ])
    return { user, seasons, leagues }
})
