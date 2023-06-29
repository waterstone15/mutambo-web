import * as lz from 'lz-string'
import get from 'lodash/get'
import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { DateTime } from 'luxon'
import { inject as I } from '@ember/service'

export default (Route.extend {

  auth:   I()
  router: I()

  ITP:  (I 'models/invite/team-player')
  User: (I 'models/user')

  beforeModel: ->
    await (@.auth.waypoint { notice: 'register/team-player'})
    return

  model: ->
    isLoggedIn = await @.auth.isLoggedIn()

    hash = window.location.hash
    data = (lz.decompressFromEncodedURIComponent hash[1..])
    { code } = (JSON.parse data)

    [ itp, user ] = await (all [
      (@.ITP.sync { code })
      (@.User.sync())
    ])

    return { code, itp, isLoggedIn, user }


  setupController: (controller, model) ->
    (@._super controller, model)

    bct = (get model, 'user.val.birthday')
    birthday = {}
    if bct
      birthday =
        day:   (parseInt DateTime.fromISO(bct).toFormat('d'))
        month: (parseInt DateTime.fromISO(bct).toFormat('M'))
        year:  (parseInt DateTime.fromISO(bct).toFormat('yyyy'))

    address      = (get model, 'user.val.address') ? ''
    gender       = (get model, 'user.val.gender') ? ''
    phone        = (get model, 'user.val.phone') ? ''
    display_name = (get model, 'user.val.display_name') ? ''
    full_name    = (get model, 'user.val.full_name') ? ''

    rq = (get model, 'itp.val.settings.val.required_info.player') ? {}

    props = {
      form:
        ok:        false
        submitted: false
        errors: {
          ...(if rq.address      then { address:      [] } else {})
          ...(if rq.birthday     then { birthday:     [] } else {})
          ...(if rq.gender       then { gender:       [] } else {})
          ...(if rq.phone        then { phone:        [] } else {})
          ...(if rq.display_name then { display_name: [] } else {})
          ...(if rq.full_name    then { full_name:    [] } else {})
        }
        help: {
          ...(if rq.address      then { address:      false } else {})
          ...(if rq.birthday     then { birthday:     false } else {})
          ...(if rq.gender       then { gender:       false } else {})
          ...(if rq.phone        then { phone:        false } else {})
          ...(if rq.display_name then { display_name: false } else {})
          ...(if rq.full_name    then { full_name:    false } else {})
        }
        valid: {
          ...(if rq.address      then { address:      (@.User.ok.address address) }          else {})
          ...(if rq.birthday     then { birthday:     (@.User.ok.birthday birthday, 18) }    else {})
          ...(if rq.gender       then { gender:       (@.User.ok.gender gender) }            else {})
          ...(if rq.phone        then { phone:        (@.User.ok.phone phone) }              else {})
          ...(if rq.display_name then { display_name: (@.User.ok.displayName display_name) } else {})
          ...(if rq.full_name    then { full_name:    (@.User.ok.fullName full_name) }       else {})
        }
        values: {
          ...(if rq.address      then { address:      address }      else {})
          ...(if rq.birthday     then { birthday:     birthday }     else {})
          ...(if rq.gender       then { gender:       gender }       else {})
          ...(if rq.phone        then { phone:        phone }        else {})
          ...(if rq.display_name then { display_name: display_name } else {})
          ...(if rq.full_name    then { full_name:    full_name }    else {})
        }
    }
    (controller.setProperties props)
    return

})