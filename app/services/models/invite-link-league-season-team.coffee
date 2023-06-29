import * as qs from 'query-string'
import EmberObject from '@ember/object'
import env from 'mutambo-web/config/environment'
import map from 'lodash/map'
import merge from 'lodash/merge'
import Service, { inject as I } from '@ember/service'
import sortBy from 'lodash/sortBy'
import throttle from 'lodash/throttle'
import { A } from '@ember/array'
import { all } from 'rsvp'
import { DateTime } from 'luxon'
import { set, setProperties, get } from '@ember/object'

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

  _load: ({ invite_link_id }) ->
    [ fb, uid ] = await all([ this.fb.get(), this.auth.getUid() ])

    token   = await fb.auth().currentUser.getIdToken()
    headers = { 'Content-Type': 'application/json', 'firebase-auth-token': token }
    try
      res  = await fetch("#{env.app.apiUrl}/v1/invite-links/league-season-team/#{invite_link_id}", { headers })
      data = await res.json()
      { invite_link } = data
    catch e
      console.log e
    return invite_link

  sync: (opts) ->
    { force, invite_link_id } = (opts ? {})
    this._debounce_load() if force
    return await this.load({ invite_link_id })

})