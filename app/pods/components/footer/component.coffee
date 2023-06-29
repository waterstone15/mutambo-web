import Component from '@ember/component'
import { DateTime } from 'luxon'

export default Component.extend({

  date: DateTime.local().toFormat('y-MM-dd')

})

