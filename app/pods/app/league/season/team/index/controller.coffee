import Controller from '@ember/controller'
import { computed } from '@ember/object'
import { get as eget } from '@ember/object'

export default (Controller.extend {

  league_id: ''
  season_id: ''
  team_id:   ''
  queryParams: [ 'league_id', 'season_id', 'team_id' ]

  title_string: (computed 'model.league.val.name', 'model.season.val.name', 'model.team.val.name', ->
    ln = @.model.league?.val?.name ? 'League'
    sn = @.model.season?.val?.name ? 'Season'
    tn = @.model.team?.val?.name ? 'Team'
    title = ln + ' → ' + sn + ' → ' + tn + ' - Mutambo'
    return title
  )

})

