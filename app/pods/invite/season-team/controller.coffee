import Controller from '@ember/controller'
import { action } from '@ember/object'
import { inject as I } from '@ember/service'

export default (Controller.extend {

  router: I()

  ignore: (action ->
    (@.router.transitionTo 'app.hello')
    return
  )


})