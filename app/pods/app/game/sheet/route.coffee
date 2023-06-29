import * as lz from 'lz-string'
import capitalize from 'lodash/capitalize'
import isEmpty from 'lodash/isEmpty'
import join from 'lodash/join'
import map from 'lodash/map'
import merge from 'lodash/merge'
import Route from '@ember/routing/route'
import set from 'lodash/set'
import { action } from '@ember/object'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default (Route.extend {

  queryParams:
    game_id: { refreshModel: true }

  auth:    I()
  router:  I()

  Leagues: (I 'models/leagues')
  Sheet:   (I 'models/game/sheet')
  User:    (I 'models/user')


  reload: (action ->
    @.refresh()
    return
  )

  beforeModel: ->
    await @.auth.waypoint()
    return


  model: (params) ->
    { game_id } = params
    
    [ leagues, sheet, user ] = await (all [
      (@.Leagues.sync())
      (@.Sheet.sync { game_id })
      (@.User.sync())
    ])

    return { leagues, sheet, user }


  setupController: (controller, model) ->
    (@._super controller, model)

    props = {}
    (controller.setProperties props)
    return

})
