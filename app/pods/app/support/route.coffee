import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'


export default (Route.extend {

  auth:   I()
  router: I()
  
  Leagues: (I 'models/leagues')
  User:    (I 'models/user')

  beforeModel: ->
    await this.auth.waypoint()
    return

  model: ->
    [ user, leagues ] = await (all [
      @User.sync()
      @Leagues.sync()
    ])
    return { user, leagues }
})
