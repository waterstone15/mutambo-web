import Controller from '@ember/controller'
import { action } from '@ember/object'
import { computed } from '@ember/object'
import { get } from '@ember/object'
import { inject as I } from '@ember/service'

export default Controller.extend({

  c: ''
  p: ''
  league_id: ''
  queryParams: [ 'c', 'p', 'league_id' ]

  title_string: computed('model.league.val.name', ->
    league_name = get(this, 'model.league.val.name')
    title = (league_name || 'League') + ' → Free Agents - Mutambo'
    return title
  )

})

