import env from 'mutambo-web/config/environment'
import fetch from 'fetch'
import merge from 'lodash/merge'
import Service from '@ember/service'
import { inject as I } from '@ember/service'


export default Service.extend({

  fb: I('fb-init')

  echo: (opts = {}) ->
    auth    = opts.auth    ? 'fb'
    data    = opts.data    ? {}
    headers = opts.headers ? { 'Content-Type': 'application/json' }
    method  = opts.method  ? 'POST'
    origin  = opts.origin  ? env.app.apiUrl ? 'https://api.mutambo.com'
    path    = opts.path    ? '/v1/hello-world'

    if auth == 'fb'
      fb = await @fb.get()
      token = await fb.auth().currentUser.getIdToken()
      headers = merge(headers, { 'firebase-auth-token': token })

    try
      res = await fetch("#{origin}#{path}", {
        ...(if method == 'POST' then { body: JSON.stringify(data) })
        headers: headers
        method: method
      })
      obj = await res.json()
      return obj
    catch e
      console.log(e) if (env.app.isProd != true)
      return null

})