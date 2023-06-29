import Route from '@ember/routing/route'
import { inject } from '@ember/service'

export default Route.extend({

  auth: inject('auth')
  router: inject('router')

  model: (params) ->
    await this.auth.logOut()
    this.router.transitionTo('index')
    return {}

})