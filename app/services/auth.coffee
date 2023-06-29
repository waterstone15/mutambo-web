import base64 from '@stablelib/base64'
import Service from '@ember/service'
import utf8 from '@stablelib/utf8'
import { inject as I } from '@ember/service'

export default Service.extend({

  fb:     I('fb-init')
  router: I('router')


  getUid: ->
    fb = await this.fb.get()
    stop = undefined
    fbUser = await (->
      new Promise((resolve) ->
        stop = fb.auth().onAuthStateChanged((_fbu) -> resolve(_fbu))
      )
    )()
    stop()
    stop = undefined
    return fbUser?.uid ? null


  isLoggedIn: ->
    fb = await this.fb.get()
    stop = undefined
    fbUser = await (->
      new Promise((resolve) ->
        stop = fb.auth().onAuthStateChanged((_fbu) -> resolve(_fbu))
      )
    )()
    stop()
    stop = undefined
    return (true && !!fbUser && !!fbUser.uid)


  waypoint: (opts = {}) ->
    logged_in = await this.isLoggedIn()
    if !logged_in
      this.router.transitionTo('sign-in', {
        queryParams: {
          next: base64.encodeURLSafe(utf8.encode((opts.next ? window.location.href)))
          notice: opts.notice ? ''
        }
      })
    return


  logOut: ->
    fb = await this.fb.get()
    try
      await fb.auth().signOut().then(-> ).catch(-> )
    catch e
      (->)()
    return

})