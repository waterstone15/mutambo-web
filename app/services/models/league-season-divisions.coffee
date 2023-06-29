import * as qs from 'query-string'
import env from 'mutambo-web/config/environment'
import map from 'lodash/map'
import Service, { inject as I } from '@ember/service'
import throttle from 'lodash/throttle'
import { all } from 'rsvp'

export default Service.extend({

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

  _load: ({ season_id }) ->
    [ fb, uid ] = await all([ this.fb.get(), this.auth.getUid() ])

    token   = await fb.auth().currentUser.getIdToken()
    headers = { 'Content-Type': 'application/json', 'firebase-auth-token': token }
    try
      query = qs.stringify({ season_id })
      res = await fetch("#{env.app.apiUrl}/v1/league/season/divisions?#{query}", { headers })
      data = await res.json()
      { divisions } = data
    catch e
      console.log e
    return divisions

  sync: (opts) ->
    { force, season_id } = (opts ? {})
    this._debounce_load() if force
    return await this.load({ season_id })

})