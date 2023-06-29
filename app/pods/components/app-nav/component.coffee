import Component from '@ember/component'
import { action } from '@ember/object'
import { computed } from '@ember/object'
import { get } from '@ember/object'
import { inject as I } from '@ember/service'
import { set } from '@ember/object'

export default (Component.extend {

  classNames: [ 'app-nav', ' p-6', 'border-r-0', 'border-b', 'border-neutral-100', 'bg-neutral-50', 'md:border-r', 'md:border-b-0' ]
  tagName: 'nav'

  nav:    I()
  router: I()

  showNav:            false
  showMainSwitcher:   false
  showSeasonSwitcher: false

  closeNav: (action ->
    @.nav.close()
    return
  )

  toggleNav: (action ->
    @.nav.toggle()
    return
  )

  toggleSeasonSwitcher: (action ->
    (set @, 'showSeasonSwitcher', !(get @, 'showSeasonSwitcher'))
    return
  )

  toggleSwitcher: (action ->
    (set @, 'showMainSwitcher', !(get @, 'showMainSwitcher'))
    return
  )

  league_id: (computed 'router.currentRoute.queryParams.league_id', ->
    return (get @, 'router.currentRoute.queryParams.league_id')
  )

  season_id: (computed 'router.currentRoute.queryParams.season_id', ->
    return (get @, 'router.currentRoute.queryParams.season_id')
  )

})

