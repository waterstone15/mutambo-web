import * as lz from 'lz-string'
import Route from '@ember/routing/route'
import { inject as I } from '@ember/service'
import { all } from 'rsvp'

export default Route.extend({

  auth: I()

  InviteLFA: I('models/invite/league-free-agent')

  beforeModel: ->
    await @auth.waypoint({ notice: 'invite/league-free-agent'})
    return

  model: ->
    hash = window.location.hash
    data = lz.decompressFromEncodedURIComponent(hash[1..])
    { code } = JSON.parse(data)

    { league } = await @.InviteLFA.sync({ code })

    return { code, hash, league }

})

