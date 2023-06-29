import Route from '@ember/routing/route'
import { inject } from '@ember/service'

export default Route.extend({

  auth: inject('auth')

  model: (params) ->
    isLoggedIn = await this.auth.isLoggedIn()

    return {
      isLoggedIn: isLoggedIn
      next:       params.next ? null
      notice:     params.notice
    }

  setupController: (controller, model) ->
    this._super(controller, model)

    { notice } = model 
    msg = switch
      when (/^invite\//.test(notice))       then 'Please sign in to view the invite.'
      when (/^register\//.test(notice))     then 'Please sign in to register.'
      when (notice == 'league/free-agents') then 'Please sign in to view free agents.'
      when (notice == 'payment')            then 'Please sign in to view the payment.'
      else null

    controller.setProperties({
      form:
        errors: email: []
        help: email: false
        ok: false
        submitted: false
        valid: email: false
        values: email: model.email ? ''
      msg: msg
    })

})
