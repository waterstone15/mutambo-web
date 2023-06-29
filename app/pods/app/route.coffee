import Route from '@ember/routing/route'
import { inject as I } from '@ember/service'

export default (Route.extend {

  nav: I()

  init: ->
    (@._super ...arguments)
    (@.get 'nav')

})
