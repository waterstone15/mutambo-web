import Service  from '@ember/service'
import throttle from 'lodash/throttle'
import { inject as I } from '@ember/service'

export default Service.extend({

  api: I('api')

  init: ->
    this._super(...arguments)
    this._debounce_load()
    return

  _debounce_load: ->
    func      = this._load.bind(this)
    wait      = 10
    options   = { leading: true, trailing: false }
    this.load = throttle(func, wait, options)

  _load: ({ code, season_id }) ->
    obj = { code, season_id }
    reply = await this.api.echo({
      data: obj
      path: '/v2/invite-code/season-team/retrieve'
    })
    return reply?.invite_code

  sync: (opts) ->
    { force, code, season_id } = (opts ? {})
    this._debounce_load() if force
    return await this.load({ code, season_id })

})