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

  _load: ({ player_id, season_id, team_id }) ->
    reply = (await @.api.echo {
      data: { player_id, season_id, team_id }
      path: '/v2/season/team/player/retrieve'
    })
    return reply.player

  sync: (opts) ->
    { force, player_id, season_id, team_id } = (opts ? {})
    @._debounce_load() if force
    return await (@.load { player_id, season_id, team_id })

})