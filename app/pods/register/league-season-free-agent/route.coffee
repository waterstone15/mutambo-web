import * as qs from 'query-string'
import base64 from '@stablelib/base64'
import find from 'lodash/find'
import hex from '@stablelib/hex'
import merge from 'lodash/merge'
import Route from '@ember/routing/route'
import utf8 from '@stablelib/utf8'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default Route.extend({

  auth:   I('auth')
  router: I('router')

  ILLFA:       I('models/invite-link-league-free-agent')
  PlayerCards: I('models/player-cards')
  User:        I('models/user')

  model: (params) ->
    { id } = params

    isLoggedIn = await @auth.isLoggedIn()

    if !isLoggedIn
      @router.transitionTo('sign-in', { queryParams:
        next: base64.encodeURLSafe(utf8.encode(window.location.href))
        notice: 'register-free-agent'
      })
      return

    [ player_cards, { invite_link, league }, user ] = await all([
      @PlayerCards.sync()
      @ILLFA.sync({ invite_link_id: id })
      @User.sync()
    ])

    card = { val: { sport: '' } }
    card = find(player_cards, { val: { sport: league.val.sport } })
    card = merge(card, { val: { sport: league.val.sport }})

    return { card, invite_link, league, user, isLoggedIn }


  setupController: (controller, model) ->
    this._super(controller, model)

    controller.setProperties({
      form:
        errors:
          about: []
          sport: []
          display_name: []
        help:
          about: false
          sport: false
          display_name: false
        ok: false
        submitted: false
        valid:
          about: false
          sport: true
          display_name: false
        values:
          about: model.card.val.about ? ''
          sport: model.card.val.sport ? 'Any'
          display_name: model.user.val.display_name ? ''
    })

})