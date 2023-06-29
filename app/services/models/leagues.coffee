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

  _load: ->
    reply = await @.api.echo({ path: '/v2/leagues/list' })

    leagues = map(reply.leagues, (_l) ->
      return merge(_l, { ui: { roles: join(map(_l.val.roles, capitalize), ' • ') }})
    )
    
    return leagues

  sync: (opts) ->
    { force } = (opts ? {})
    @._debounce_load() if force
    return await @.load()

})