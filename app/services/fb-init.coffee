import Service from '@ember/service'
import env from 'mutambo-web/config/environment'
import firebase from 'firebase/app'
import 'firebase/auth'

export default Service.extend({

  get: (name) ->
    if !firebase.apps.length
      opts = env.app.firebase
      if name
        await firebase.initializeApp(opts, name)
      else
        await firebase.initializeApp(opts)

    return firebase

})