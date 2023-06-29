import Service  from '@ember/service'
import throttle from 'lodash/throttle'
import { inject as I } from '@ember/service'

export default (Service.extend {

  api: I()

  init: ->
    (@._super ...arguments)
    (@._debounce_load())
    return

  _debounce_load: ->
    func    = (@._load.bind @)
    wait    = 100
    options = { leading: true, trailing: false }
    @.load  = (throttle func, wait, options)

  _load: ({ code }) ->
    reply = await (@.api.echo {
      data: { code }
      path: '/v2/invite/team-manager/retrieve'
    })
    return reply.itm ? null

  sync: (opts) ->
    { force, code } = (opts ? {})
    (@._debounce_load()) if force
    return await (@.load { code })

})