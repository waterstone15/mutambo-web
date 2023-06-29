import env from 'mutambo-web/config/environment'
import capitalize from 'lodash/capitalize'
import intersection from 'lodash/intersection'
import isEmpty from 'lodash/isEmpty'
import join from 'lodash/join'
import map from 'lodash/map'
import merge from 'lodash/merge'
import Service, { inject } from '@ember/service'
import throttle from 'lodash/throttle'
import { A } from '@ember/array'
import { all } from 'rsvp'
import { set, setProperties, get } from '@ember/object'

export default Service.extend({

  auth: inject('auth')
  fb: inject('fb-init')

  init: ->
    this._super(...arguments)
    this._debounce_load()
    return

  _debounce_load: ->
    func      = this._load.bind(this)
    wait      = 1000 * 60 * 60
    options   = { leading: true, trailing: false }
    this.load = throttle(func, wait, options)

  _load: ->
    [ fb, uid ] = await all([ this.fb.get(), this.auth.getUid() ])

    token   = await fb.auth().currentUser.getIdToken()
    headers = { 'Content-Type': 'application/json', 'firebase-auth-token': token }
    try
      res  = await fetch("#{env.app.apiUrl}/v1/player-cards", { headers })
      { player_cards } = (await res.json())
    catch e
      console.log e
    return A(player_cards)

  sync: (opts) ->
    { force } = (opts ? {})
    this._debounce_load() if force
    return await this.load()

})