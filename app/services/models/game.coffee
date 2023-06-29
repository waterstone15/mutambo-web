import Service, { inject as I } from '@ember/service'
import throttle from 'lodash/throttle'

export default Service.extend({

  api: I()

  init: ->
    this._super(...arguments)
    this._debounce_load()
    return

  _debounce_load: ->
    func      = this._load.bind(this)
    wait      = 1000
    options   = { leading: true, trailing: false }
    this.load = throttle(func, wait, options)

  _load: ({ game_id }) ->
    obj = { game_id }
    reply = await this.api.echo({ path: '/v1/games/retrieve', data: obj })
    { game } = reply
    return game

  sync: (opts) ->
    { force, game_id } = (opts ? {})
    this._debounce_load() if force
    return await this.load({ game_id })

})