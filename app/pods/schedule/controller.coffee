import Controller from '@ember/controller'
import { action, computed, get, } from '@ember/object'
import { inject as I } from '@ember/service'

export default Controller.extend({

  router:  I('router')

  end_at: null
  end_before: null
  filters: null
  league_id: ''
  limit: null
  limit_to_last: null
  order_by: null
  search_at: null
  season_id: ''
  start_after: null
  start_at: null
  queryParams: [ 'end_at', 'end_before', 'filters', 'league_id', 'limit', 'limit_to_last', 'order_by', 'season_id', 'start_after', 'start_at', ]

  search_text: ''

  searchGo: action(->
    this.router.transitionTo('schedule', {
      queryParams:
        end_before: null
        search_at:  get(this, 'search_text')
        season_id:  this.model.schedule.season.meta.id
        start_after: null
    })
    return
  )

  title_string: computed('model.schedule.league.val.name', 'model.schedule.season.val.name', ->
    league_name = get(this, 'model.schedule.league.val.name')
    season_name = get(this, 'model.schedule.season.val.name')
    title = (league_name || 'League') + ' → ' + (season_name || 'Season') + ' → Games - Mutambo'
    return title
  )


})

