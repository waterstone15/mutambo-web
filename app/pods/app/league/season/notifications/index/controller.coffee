import cloneDeep from 'lodash/cloneDeep'
import Controller from '@ember/controller'
import env from 'mutambo-web/config/environment'
import fetch from 'fetch'
import findIndex from 'lodash/findIndex'
import isEmpty from 'lodash/isEmpty'
import isInteger from 'lodash/isInteger'
import split from 'lodash/split'
import toNumber from 'lodash/toNumber'
import { A } from '@ember/array'
import { action, computed, get, set, setProperties } from '@ember/object'
import { DateTime } from 'luxon'
import { inject as I } from '@ember/service'
import { Notyf } from 'notyf'

export default Controller.extend({

  api:    I('api')
  fb:     I('fb-init')
  router: I('router')
  wait:   I('wait')

  league_id: ''
  season_id: ''
  queryParams: [ 'league_id', 'season_id' ]

  notyf: undefined
  notyf_defaults: {
    types: [
      {
        type: 'info'
        position: { x: 'right', y: 'top' }
        ripple: false
        icon: false
        dismissable: false
      }
    ]
  }

  willDestroy: ->
    this.notyf = null

  title_string: computed('model.league.val.name', 'model.season.val.name', ->
    league_name = get(this, 'model.league.val.name')
    season_name = get(this, 'model.season.val.name')
    title = (league_name || 'League') + ' → ' + (season_name || 'Season')  + ' →  Notifications - Mutambo'
    return title
  )

  reject: action((notification) ->
    obj = { notification_id: notification.meta.id}
    reply = await this.api.echo({ path: "/v1/leagues/seasons/notifications/reject-remove-player-request", data: obj })
    this.send('reload')
    return
  )

  accept: action((notification) ->
    obj = { notification_id: notification.meta.id, response: 'accept' }
    reply = await this.api.echo({ path: "/v1/leagues/seasons/notifications/accept-remove-player-request", data: obj })

    if !this.notyf
      this.notyf = new Notyf(this.notyf_defaults)
    this.notyf.open({
      className: 'info-toast'
      type: 'info'
      message: 'Player Removed'
      duration: 2500
    })

    this.send('reload')
    return
  )

})

