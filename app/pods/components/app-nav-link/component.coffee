import Component from '@ember/component'
import replace from 'lodash/replace'
import { computed, get } from '@ember/object'
import { inject } from '@ember/service'

export default Component.extend({

  router: inject('router')

  isActive: computed('router.currentRouteName', ->
    crn = get(this, 'router.currentRouteName')
    rn = get(this, 'route')
    return crn == rn || crn == "#{rn}.index" || crn == replace(rn, '.', '/') || crn == replace("#{rn}.index", '.', '/')
  )

  tagName: 'li'

})

