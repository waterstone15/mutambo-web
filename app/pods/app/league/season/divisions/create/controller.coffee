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
import { inject } from '@ember/service'

export default Controller.extend({

  fb: inject('fb-init')

  league_id: ''
  season_id: ''
  queryParams: [ 'league_id', 'season_id' ]

  title_string: computed('model.league.val.name', 'model.season.val.name', ->
    league_name = get(this, 'model.league.val.name')
    season_name = get(this, 'model.season.val.name')
    title = (league_name || 'League') + ' → ' + (season_name || 'Season')  + ' →  Divisions - Mutambo'
    return title
  )

})

