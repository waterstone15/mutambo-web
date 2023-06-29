import get from 'lodash/get'
import isEmpty from 'lodash/isEmpty'
import isString from 'lodash/isString'
import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default (Route.extend {

  queryParams:
    card_id: { refreshModel: true }

  auth:   I()
  router: I()
  
  Card:    (I 'models/card')
  Leagues: (I 'models/leagues')
  User:    (I 'models/user')

  beforeModel: ->
    await @.auth.waypoint()
    return

  model: (params) ->
    { card_id } = params

    [ card, leagues, user, ] = await (all [
      (@.Card.sync { card_id })
      @.Leagues.sync()
      @.User.sync()
    ])

    return { card, leagues, user, }

  setupController: (controller, model) ->
    (@._super controller, model)

    about  = (get model, 'card.val.about')
    status = (get model, 'card.val.status')

    (controller.setProperties {
      form:
        errors: { about: [] }
        help: { about: false, status: false }
        ok: false
        submitted: false
        valid:
          about:  (!(isEmpty about) && (isString about))
          status: true
        values:
          about: about ? ''
          status: status ? 'show'
    })

})
