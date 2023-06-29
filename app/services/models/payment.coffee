import Service  from '@ember/service'
import throttle from 'lodash/throttle'
import { inject as I } from '@ember/service'

export default Service.extend({

  api: I('api')

  init: ->
    @_super(...arguments)
    @_debounce_load()
    return

  _debounce_load: ->
    func      = @_load.bind(@)
    wait      = 1000
    options   = { leading: true, trailing: false }
    @load = throttle(func, wait, options)

  _load: ({ code }) ->
    obj = { code }
    reply = await @api.echo({
      data: obj
      path: '/v2/payment/retrieve'
    })
    return reply.payment ? null

  sync: (opts) ->
    { force, code } = (opts ? {})
    @_debounce_load() if force
    return await @load({ code })

})