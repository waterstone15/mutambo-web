import Service from '@ember/service'
import throttle from 'lodash/throttle'
import { inject as I } from '@ember/service'

export default (Service.extend {

  api: I()

  init: ->
    (@._super ...arguments)
    @._debounce_load()
    return

  _debounce_load: ->
    func    = (@._load.bind @)
    wait    = 10
    options = { leading: true, trailing: false }
    @.load  = (throttle func, wait, options)

  _load: ({ card_id, sport }) ->
    reply = await (@.api.echo {
      data: { card_id, sport }
      path: '/v2/card/retrieve'
    })
    return reply.card 

  sync: (opts) ->
    { force, card_id, sport,} = (opts ? {})
    @._debounce_load() if force
    return await (@.load { card_id, sport })

})