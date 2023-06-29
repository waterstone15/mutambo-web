import capitalize from 'lodash/capitalize'
import env from 'mutambo-web/config/environment'
import isEmpty from 'lodash/isEmpty'
import join from 'lodash/join'
import map from 'lodash/map'
import merge from 'lodash/merge'
import replace from 'lodash/replace'
import Service, { inject } from '@ember/service'
import sortBy from 'lodash/sortBy'
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

  _load: ({ season_id }) ->
    [ fb, uid ] = await all([ this.fb.get(), this.auth.getUid() ])

    token   = await fb.auth().currentUser.getIdToken()
    headers = { 'Content-Type': 'application/json', 'firebase-auth-token': token }
    try
      res = await fetch("#{env.app.apiUrl}/v1/seasons/#{season_id}", { headers })
      data = await res.json()
      season = merge(data.season, {
        val:
          roles_formatted: replace(join(map(data.season.val.roles, capitalize), ' • '), 'Captain', 'Manager')
      })

      LSFA_invite_link = data.LSFA_invite_link
      LST_invite_link  = data.LST_invite_link
      if !!LSFA_invite_link
        LSFA_invite_link.val.link = "#{window.location.origin}/register/league-season-free-agent?id=#{LSFA_invite_link.val.code}"
        season.rel.LSFA_invite_link = LSFA_invite_link
      if !!LST_invite_link
        LST_invite_link.val.link = "#{window.location.origin}/register/league-season-team?id=#{LST_invite_link.val.code}"
        season.rel.LST_invite_link = LST_invite_link

    catch e
      console.log e
    return season

  sync: (opts) ->
    { force, season_id } = (opts ? {})
    this._debounce_load() if force
    return await this.load({ season_id })

})