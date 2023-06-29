import * as qs from 'query-string'
import base64 from '@stablelib/base64'
import find from 'lodash/find'
import hex from '@stablelib/hex'
import includes from 'lodash/includes'
import map from 'lodash/map'
import merge from 'lodash/merge'
import Route from '@ember/routing/route'
import utf8 from '@stablelib/utf8'
import { all } from 'rsvp'
import { DateTime } from 'luxon'
import { get } from '@ember/object'
import { inject as I } from '@ember/service'

export default Route.extend({

  auth:   I('auth')
  router: I('router')

  ILLSTP: I('models/invite-link-league-season-team-player')
  User:   I('models/user')
  Teams:  I('models/teams')

  model: (params) ->
    { id } = params

    isLoggedIn = await @auth.isLoggedIn()

    if !isLoggedIn
      @router.transitionTo('sign-in', {
        queryParams:
          next: base64.encodeURLSafe(utf8.encode(window.location.href))
          notice: 'register-player'
      })
      return

    [ illstp, teams, user ] = await all([
      @ILLSTP.sync({ invite_link_id: id })
      @Teams.sync()
      @User.sync()
    ])

    team = find(teams, { meta: { id: illstp.rel.team }})
    if team && includes(team.val.roles, 'player')
      @router.transitionTo('app.teams')
      return

    return { illstp, user, isLoggedIn }


  setupController: (controller, model) ->
    this._super(controller, model)

    bct = get(model, 'user.val.birthday')
    birthday = {}
    if bct
      birthday =
        day: parseInt(DateTime.fromISO(bct).toFormat('d'))
        month: parseInt(DateTime.fromISO(bct).toFormat('M'))
        year: parseInt(DateTime.fromISO(bct).toFormat('yyyy'))

    address      = get(model, 'user.val.address') ? ''
    gender       = get(model, 'user.val.gender') ? ''
    phone        = get(model, 'user.val.phone') ? ''
    display_name = get(model, 'user.val.display_name') ? ''
    full_name    = get(model, 'user.val.full_name') ? ''

    controller.setProperties({
      form:
        ok:            false
        submitted:     false
        errors:
          address:      []
          birthday:     []
          gender:       []
          phone:        []
          display_name: []
          full_name:    []
        help:
          address:      false
          birthday:     false
          gender:       false
          phone:        false
          display_name: false
          full_name:    false
        valid:
          address:      @User.ok.address(address)
          birthday:     @User.ok.birthday(birthday)
          gender:       @User.ok.gender(gender)
          phone:        @User.ok.phone(phone)
          display_name: @User.ok.displayName(display_name)
          full_name:    @User.ok.fullName(full_name)
        values:
          address:      address
          birthday:     birthday
          gender:       gender
          phone:        phone
          display_name: display_name
          full_name:    full_name
    })

})