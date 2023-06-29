import capitalize from 'lodash/capitalize'
import join from 'lodash/join'
import map from 'lodash/map'
import merge from 'lodash/merge'
import Service from '@ember/service'
import throttle from 'lodash/throttle'
import { inject as I } from '@ember/service'

export default Service.extend({

  api: I()

  init: ->
    @._super(...arguments)
    @._debounce_load()
    return

  _debounce_load: ->
    func    = @._load.bind(@)
    wait    = 1000
    options = { leading: true, trailing: false }
    @.load  = throttle(func, wait, options)

  _load: ({ league_id}) ->

    obj = { league_id }
    reply = await @.api.echo({
      data: obj
      path: '/v2/league/retrieve'
    })

    league = reply.league ? {}
    league = merge(league, { ui: { roles: join(map(league.val.roles, capitalize), ' • ') }})
    
    return league

  sync: (opts) ->
    { force, league_id } = (opts ? {})
    @._debounce_load() if force
    return await @.load({ league_id })

})