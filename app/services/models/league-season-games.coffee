import Service, { inject as I } from '@ember/service'
import throttle from 'lodash/throttle'
import { all } from 'rsvp'

export default Service.extend({

  api:  I('api')
  auth: I('auth')
  fb:   I('fb-init')

  init: ->
    this._super(...arguments)
    this._debounce_load()
    return

  _debounce_load: ->
    func      = this._load.bind(this)
    wait      = 1000
    options   = { leading: true, trailing: false }
    this.load = throttle(func, wait, options)

  _load: ({ end_before, search_at, season_id, start_after }) ->
    [ fb, uid ] = await all([ this.fb.get(), this.auth.getUid() ])

    obj = { end_before, search_at, season_id, start_after }
    reply = await this.api.echo({ path: '/v1/leagues/seasons/games/list', data: obj })

    { start, end, first, last, games, } = reply
    return { start, end, first, last, games, }

  sync: (opts) ->
    { end_before, force, search_at, season_id, start_after, } = (opts ? {})
    this._debounce_load() if force
    return await this.load({ end_before, search_at,  season_id, start_after, })

})