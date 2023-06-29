import * as qs from 'query-string'
import base64 from '@stablelib/base64'
import env from 'mutambo-web/config/environment'
import fetch from 'fetch'
import isEmpty from 'lodash/isEmpty'
import trim from 'lodash/trim'
import Route from '@ember/routing/route'
import utf8 from '@stablelib/utf8'
import { inject } from '@ember/service'


export default Route.extend({

  fb: inject('fb-init')
  router: inject('router')

  model: (params) ->
    { code, next } = params

    _qs = qs.stringify({ code })
    _qs = "?#{_qs}" if !isEmpty(_qs)

    try
      res = await fetch("#{env.app.apiUrl}/v1/auth/fb-token#{_qs}")
      data = await res.json()

      fb = await this.fb.get()
      await fb.auth().signInWithCustomToken(data.token)
      if next
        window.location.assign(utf8.decode(base64.decodeURLSafe(next)))
      else
        this.router.transitionTo('app.hello')
    catch e
      console.log e
      this.router.transitionTo('index')

    return {}

})



