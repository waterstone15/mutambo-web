import Route from '@ember/routing/route'
import { inject as I } from '@ember/service'

export default Route.extend({

  auth:   I()

  beforeModel: ->
    return

  model: ->
    isLoggedIn = await this.auth.isLoggedIn()
    return { isLoggedIn }

})