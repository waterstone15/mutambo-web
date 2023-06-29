import * as lz from 'lz-string'
import capitalize from 'lodash/fp/capitalize'
import flow from 'lodash/fp/flow'
import identity from 'lodash/fp/identity'
import isEmpty from 'lodash/isEmpty'
import join from 'lodash/fp/join'
import map from 'lodash/fp/map'
import merge from 'lodash/merge'
import mergeAll from 'lodash/fp/mergeAll'
import Route from '@ember/routing/route'
import set from 'lodash/set'
import without from 'lodash/fp/without'
import { action } from '@ember/object'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default (Route.extend {

  queryParams:
    team_id: { refreshModel: true }

  auth:    I()
  router:  I()

  ICTM:    (I 'models/invite-code/team-manager')
  ICTP:    (I 'models/invite-code/team-player')
  Leagues: (I 'models/leagues')
  Team:    (I 'models/team')
  User:    (I 'models/user')


  reload: (action ->
    @.refresh()
    return
  )

  beforeModel: ->
    await @.auth.waypoint()
    return


  model: (params) ->
    { team_id } = params
    
    [ ictm, ictp, leagues, team, user ] = await (all [
      @.ICTM    .sync({ team_id })
      @.ICTP    .sync({ team_id })
      @.Leagues .sync()
      @.Team    .sync({ team_id })
      @.User    .sync()
    ])

    roles = ((flow [
      (without [ 'primary-manager' ])
      (map capitalize)
      (join ' • ')
    ]) team.val.roles)

    team = (mergeAll {}, team, { ui: { roles }})

    if !(isEmpty ictm)
      data = { code: ictm.val.code }
      data = (JSON.stringify data)
      data = (lz.compressToEncodedURIComponent data)
      (set ictm, 'ui.link', "#{window.location.origin}/invite/team-manager##{data}")

    if !(isEmpty ictp)
      data = { code: ictp.val.code }
      data = (JSON.stringify data)
      data = (lz.compressToEncodedURIComponent data)
      (set ictp, 'ui.link', "#{window.location.origin}/invite/team-player##{data}")

    return { ictm, ictp, leagues, team, user }


  setupController: (controller, model) ->
    (@._super controller, model)

    props = {
      form:
        ok:        false
        submitted: false
        errors: {}
        help: {}
        valid:
          confirm_text: false
        values:
          player: null
          confirm_text: ''
    }
    (controller.setProperties props)
    return

})
