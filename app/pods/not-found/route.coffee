import Route from '@ember/routing/route'
import { inject } from '@ember/service'

export default Route.extend({

  router: inject('router')

  beforeModel: -> this.router.transitionTo('index')

})