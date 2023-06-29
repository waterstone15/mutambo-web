import Controller from '@ember/controller'
import { computed } from '@ember/object'
import { get as eget } from '@ember/object'
import { inject as I } from '@ember/service'


export default (Controller.extend {

  game_id: ''
  queryParams: [ 'game_id' ]

  red: [0..10000]

  title_string: (computed 'model.team.val.name', ->
    tn = (eget @, 'model.team.val.name')
    return (tn || 'Games → Game Sheet (Preview)')  + ' - Mutambo'
  )

})