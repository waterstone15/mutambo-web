import capitalize from 'lodash/fp/capitalize'
import flow from 'lodash/fp/flow'
import identity from 'lodash/fp/identity'
import join from 'lodash/fp/join'
import map from 'lodash/fp/map'
import mergeAll from 'lodash/fp/mergeAll'
import Route from '@ember/routing/route'
import without from 'lodash/fp/without'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default (Route.extend {

  auth:    I()
  router:  I()
  
  Leagues: (I 'models/leagues')
  Teams:   (I 'models/teams')
  User:    (I 'models/user')

  beforeModel: ->
    await @.auth.waypoint()
    return

  model: ->
    [ leagues, teams, user ] = await (all [
      @.Leagues.sync()
      @.Teams.sync()
      @.User.sync()
    ])

    teams = ((map (_t) ->
      roles = ((flow [
        (without [ 'primary-manager' ])
        (map capitalize)
        (join ' • ')
      ]) _t.val.roles)

      return (mergeAll {}, _t, { ui: { roles }})
    ) teams)

    return { leagues, teams, user, }
})
