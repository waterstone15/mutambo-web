import Controller from '@ember/controller'
import split from 'lodash/split'
import { A } from '@ember/array'
import { computed, get } from '@ember/object'
import { DateTime } from 'luxon'

export default Controller.extend({

  bday_display: computed('model.user.val.birthday', ->
    clock = get(this, 'model.user.val.birthday')
    return DateTime.fromISO(clock).toFormat('MMMM dd, yyyy') if !!clock
  )

  address_lines: computed('model.user.val.address', ->
    return A(split(get(this, 'model.user.val.address') ? '', '\n'))
  )

})
