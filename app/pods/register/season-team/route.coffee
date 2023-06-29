import * as lz from 'lz-string'
import get from 'lodash/get'
import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { DateTime } from 'luxon'
import { inject as I } from '@ember/service'

export default Route.extend({

  auth:   I('auth')
  router: I('router')

  InviteST: I('models/invite/season-team')
  User:     I('models/user')

  beforeModel: ->
    await @auth.waypoint({ notice: 'register/season-team'})
    return

  model: ->
    isLoggedIn = await @auth.isLoggedIn()

    hash = window.location.hash
    data = lz.decompressFromEncodedURIComponent(hash[1..])
    { code } = JSON.parse(data)

    [{ league, season, settings }, user ] = await all([
      @InviteST.sync({ code })
      @User.sync()
    ])

    return { code, isLoggedIn, league, season, settings, user }


  setupController: (controller, model) ->
    this._super(controller, model)

    bct = get(model, 'user.val.birthday')
    birthday = {}
    if bct
      birthday =
        day:   parseInt(DateTime.fromISO(bct).toFormat('d'))
        month: parseInt(DateTime.fromISO(bct).toFormat('M'))
        year:  parseInt(DateTime.fromISO(bct).toFormat('yyyy'))

    address      = get(model, 'user.val.address') ? ''
    gender       = get(model, 'user.val.gender') ? ''
    phone        = get(model, 'user.val.phone') ? ''
    display_name = get(model, 'user.val.display_name') ? ''
    full_name    = get(model, 'user.val.full_name') ? ''

    rq =  model.settings.val.required_info.manager

    props = {
      form:
        ok:            false
        submitted:     false
        errors: {
          ...(if rq.address      then { address:      [] } else {})
          ...(if rq.birthday     then { birthday:     [] } else {})
          ...(if rq.gender       then { gender:       [] } else {})
          ...(if rq.phone        then { phone:        [] } else {})
          ...(if rq.display_name then { display_name: [] } else {})
          ...(if rq.full_name    then { full_name:    [] } else {})
          team_name:    []
          team_notes:   []
        }
        help: {
          ...(if rq.address      then { address:      false } else {})
          ...(if rq.birthday     then { birthday:     false } else {})
          ...(if rq.gender       then { gender:       false } else {})
          ...(if rq.phone        then { phone:        false } else {})
          ...(if rq.display_name then { display_name: true } else {})
          ...(if rq.full_name    then { full_name:    true } else {})
          team_name:    false
          team_notes:   false
        }
        valid: {
          ...(if rq.address      then { address:      @User.ok.address(address) }          else {})
          ...(if rq.birthday     then { birthday:     @User.ok.birthday(birthday, 18) }    else {})
          ...(if rq.gender       then { gender:       @User.ok.gender(gender) }            else {})
          ...(if rq.phone        then { phone:        @User.ok.phone(phone) }              else {})
          ...(if rq.display_name then { display_name: @User.ok.displayName(display_name) } else {})
          ...(if rq.full_name    then { full_name:    @User.ok.fullName(full_name) }       else {})
          team_name:    false
          team_notes:   true
        }
        values: {
          ...(if rq.address      then { address:      address }      else {})
          ...(if rq.birthday     then { birthday:     birthday }     else {})
          ...(if rq.gender       then { gender:       gender }       else {})
          ...(if rq.phone        then { phone:        phone }        else {})
          ...(if rq.display_name then { display_name: display_name } else {})
          ...(if rq.full_name    then { full_name:    full_name }    else {})
          team_name:  ''
          team_notes: "Division Request:\nHome Field Plan:\nHome Field Blackout Dates:\nOther:"
        }
    }
    controller.setProperties(props)
    return

})