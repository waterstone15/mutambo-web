import Controller from '@ember/controller'
import { computed } from '@ember/object'
import { get as eget } from '@ember/object'
import { inject as I } from '@ember/service'


export default (Controller.extend {

  game_id:   ''
  league_id: ''
  season_id: ''
  queryParams: [ 'game_id', 'league_id', 'season_id' ]

  red: [0..10000]

  title_string: (computed 'model.team.val.name', ->
    ln  = (eget @, 'model.league.val.name') ? 'League'
    sn  = (eget @, 'model.season.val.name') ? 'Season'
    return "#{ln} → #{sn} → Games → Game Sheet - Mutambo"
  )


})