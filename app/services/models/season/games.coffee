import Service from '@ember/service'
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
    wait    = 10
    options = { leading: true, trailing: false }
    @.load  = (throttle func, wait, options)

  _load: ({ c, p, season_id }) ->
    reply = (await @.api.echo {
      data: { c, p, season_id }
      path: '/v2/season/games/list'
    })
    return reply.games 

  sync: (opts) ->
    { force, c, p, season_id } = (opts ? {})
    @._debounce_load() if force
    return await (@.load { c, p, season_id })

})