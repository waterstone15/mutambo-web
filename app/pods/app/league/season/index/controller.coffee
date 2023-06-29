import Controller from '@ember/controller'
import copy from 'copy-to-clipboard'
import split from 'lodash/split'
import { A } from '@ember/array'
import { action, computed, get } from '@ember/object'
import { DateTime } from 'luxon'
import { Notyf } from 'notyf'

export default Controller.extend({

  league_id: ''
  season_id: ''
  queryParams: [ 'league_id', 'season_id', ]

  notyf: undefined

  title_string: computed('model.league.val.name', 'model.season.val.name', ->
    ln = get(@, 'model.league.val.name')
    sn = get(@, 'model.season.val.name')
    return (ln || 'League') + ' → ' + (sn || 'Season')  + ' - Mutambo'
  )

  willDestroy: ->
    @.notyf = null

  copy: action((path)->
    if !@.notyf
      @.notyf = new Notyf({
        types: [
          {
            type: 'info'
            position: { x: 'center', y: 'bottom' }
            ripple: false
            icon: false
            dismissable: false
          }
        ]
      })

    copy(@.model[path].ui.link)

    @.notyf.open({
      className: 'info-toast'
      type: 'info'
      message: 'Link Copied'
      duration: 2500
    })

    return
  )

})

