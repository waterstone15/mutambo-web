import * as currency from 'currency.js'
import * as lz from 'lz-string'
import isEmpty from 'lodash/isEmpty'
import map from 'lodash/map'
import merge from 'lodash/merge'
import Route from '@ember/routing/route'
import { all } from 'rsvp'
import { inject as I } from '@ember/service'

export default Route.extend({

  api:    I()
  auth:   I()
  router: I()

  Payment: I('models/payment')
  User:    I('models/user')


  queryParams: { code: { refreshModel: true }}

  beforeModel: ->
    await @auth.waypoint({ notice: 'payment' })
    return

  model: (params) ->
    { code } = params
    hash = window.location.hash
    if !!hash
      data = lz.decompressFromEncodedURIComponent(hash[1..])
      ({ code } = JSON.parse(data)) if !isEmpty(data)
    
    [ payment, user ] = await all([
      @Payment.sync({ code })
      @User.sync()
    ])

    payment.ui = {}
    payment.ui.items = map(payment.val.items, (_i) -> merge(_i, { amount: currency(_i.amount).format() }))
    payment.ui.total = currency(payment.val.total).format()

    return { isLoggedIn: true, payment, user }

})