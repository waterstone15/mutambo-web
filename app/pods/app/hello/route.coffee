import Route from '@ember/routing/route'
import { inject as I } from '@ember/service'

export default Route.extend({

  beforeModel: (transition) ->
    { queryParams } = transition.to
    @.replaceWith('app.account', { queryParams })
    return

})