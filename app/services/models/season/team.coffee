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

  _load: ({ team_id, season_id }) ->
    reply = (await @.api.echo {
      data: { team_id, season_id }
      path: '/v2/season/team/retrieve'
    })
    return reply.team

  sync: (opts) ->
    { force, team_id, season_id } = (opts ? {})
    @._debounce_load() if force
    return await (@.load { team_id, season_id })

})