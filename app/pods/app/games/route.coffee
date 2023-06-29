import Route from '@ember/routing/route'
import { all } from 'rsvp'
import includes from 'lodash/includes'
import reduce from 'lodash/reduce'
import { inject as I } from '@ember/service'

export default (Route.extend {

  queryParams:
    c: { refreshModel: true, replace: true }
    p: { refreshModel: true, replace: true }

  auth:   I()

  Games:   (I 'models/games')
  Leagues: (I 'models/leagues')
  User:    (I 'models/user')

  beforeModel: ->
    await @.auth.waypoint()
    return

  model: (params) ->
    { c, p } = params

    [ games, leagues, user, ] = await (all [
      @.Games.sync({ c, p })
      @.Leagues.sync()
      @.User.sync()
    ])

    return { games, leagues, user, }

  setupController: (controller, model) ->
    (@._super controller, model)

    (controller.setProperties {
      is_manager: (reduce model.games, ((_acc, _g) ->
        return (_g.val.is_manager || _acc)
      ), false)
    })
    return

})
