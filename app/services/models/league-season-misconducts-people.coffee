import env from 'mutambo-web/config/environment'
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

  _load: ({ end_before, search_at, season_id, start_after }) ->
    [ fb, uid ] = await all([ this.fb.get(), this.auth.getUid() ])

    token   = await fb.auth().currentUser.getIdToken()
    headers = { 'Content-Type': 'application/json', 'firebase-auth-token': token }
    try
      res = await fetch("#{env.app.apiUrl}/v1/leagues/seasons/misconducts/people/list", {
        body: JSON.stringify({ end_before, search_at, season_id, start_after, })
        headers: headers
        method: 'POST'
      })
      data = await res.json()
      { start, end, first, last, people, } = data
    catch e
      console.log e
    return { start, end, first, last, people, }

  sync: (opts) ->
    { end_before, force, search_at, season_id, start_after, } = (opts ? {})
    this._debounce_load() if force
    return await this.load({ end_before, search_at,  season_id, start_after, })

})