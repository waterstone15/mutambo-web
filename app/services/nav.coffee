import includes from 'lodash/includes'
import Service from '@ember/service'
import { get } from '@ember/object'
import { inject as I } from '@ember/service'
import { observer } from '@ember/object'
import { set } from '@ember/object'

export default (Service.extend {

  purl: null
  show: false

  router: I()

  init: ->
    (@._super ...arguments)
    (get @, 'router')

  close: ->
    (set @, 'show', false)
    (set @, 'purl', null)
    return

  toggle: ->
    (set @, 'show', !(get @, 'show'))
    return
    
  fn: (observer 'router.currentRouteName', ->
    purl = @.purl
    curl = @.router.currentURL

    crn   = @.router.currentRouteName
    keeps = [ 'app.account.index', 'app.league.index', 'app.league.season.index', ]

    sn = (purl != null && purl != curl && (includes keeps, crn))
    (set @, 'show', sn)

    (set @, 'purl', @.router.currentURL)
    return
  )

})