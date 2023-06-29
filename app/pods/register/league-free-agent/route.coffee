import * as lz from 'lz-string'
import get from 'lodash/get'
import isEmpty from 'lodash/isEmpty'
import isString from 'lodash/isString'
import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { DateTime } from 'luxon'
import { inject as I } from '@ember/service'

export default Route.extend({

  auth:   I()
  router: I()

  InviteLFA: I('models/invite/league-free-agent')
  User:      I('models/user')
  Card:      I('models/card')

  beforeModel: ->
    await @.auth.waypoint({ notice: 'register/league-free-agent'})
    return

  model: ->
    hash = window.location.hash
    data = lz.decompressFromEncodedURIComponent(hash[1..])
    { code } = JSON.parse(data)

    [ card, { league }, user ] = await all([
      @.Card.sync({ sport: 'Football (Soccer)' })
      @.InviteLFA.sync({ code })
      @.User.sync()
    ])

    return { card, code, league, user }


  setupController: (controller, model) ->
    @._super(controller, model)

    about        = get(model, 'card.val.about') ? ''
    display_name = get(model, 'user.val.display_name') ? ''

    props =
      form:
        ok:            false
        submitted:     false
        errors:
          about:        []
          display_name: []
        help:
          about:        true
          display_name: false
        valid:
          about:        (isString(about) && !isEmpty(about))
          display_name: @.User.ok.displayName(display_name)
        values:
          about:        about
          display_name: display_name

    controller.setProperties(props)
    return

})