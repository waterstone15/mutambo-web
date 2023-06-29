import Route from '@ember/routing/route'
import { inject } from '@ember/service'

export default Route.extend({

  auth: inject('auth')

  model: ->
    isLoggedIn = await this.auth.isLoggedIn()
    return { isLoggedIn }

})