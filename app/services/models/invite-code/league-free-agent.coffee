import Service  from '@ember/service'
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

  _load: ({ code, league_id }) ->
    reply = await @.api.echo({
      data: { code, league_id }
      path: '/v2/invite-code/league-free-agent/retrieve'
    })
    return reply?.invite_code

  sync: (opts) ->
    { force, code, league_id } = (opts ? {})
    @._debounce_load() if force
    return await @.load({ code, league_id })

})