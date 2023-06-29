import Service, { inject as I } from '@ember/service'
import throttle from 'lodash/throttle'
import { all } from 'rsvp'

export default Service.extend({

  api:  I('api')

  init: ->
    this._super(...arguments)
    this._debounce_load()
    return

  _debounce_load: ->
    func      = this._load.bind(this)
    wait      = 1000
    options   = { leading: true, trailing: false }
    this.load = throttle(func, wait, options)

  _load: ({ season_id }) ->
    obj = { season_id }
    reply = await this.api.echo({ path: '/v1/-/standings/retrieve', data: obj, auth: false })

    { standings, league, season } = reply
    return { standings, league, season }

  sync: (opts) ->
    { force, season_id } = (opts ? {})
    this._debounce_load() if force
    return await this.load({ season_id })

})