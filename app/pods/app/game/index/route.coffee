import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default (Route.extend {

  queryParams:
    game_id: { refreshModel: true, replace: false }

  auth:   I()
  router: I()

  Game:    (I 'models/game')
  Leagues: (I 'models/leagues')
  User:    (I 'models/user')

  beforeModel: ->
    await this.auth.waypoint()
    return

  model: (params) ->
    game_id = params.game_id
    [ game, leagues, user, ] = await (all [
      @Game.sync({ game_id })
      @Leagues.sync()
      @User.sync()
    ])
    return { game, leagues, user }
})
