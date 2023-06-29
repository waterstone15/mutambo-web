import Controller from '@ember/controller'
import env from 'mutambo-web/config/environment'
import { action, get } from '@ember/object'
import { inject as I } from '@ember/service'
import { loadStripe } from '@stripe/stripe-js'


export default Controller.extend({

  router: I('router')

  code: ''
  queryParams: [ 'code' ]

  pay: action(->
    stripe   = await loadStripe('' || env.app.stripe_key)
    payment  = get(@, 'model.payment')
    user     = get(@, 'model.user')

    price    = payment.ext.stripe_price || payment.ext.stripe_sku

    checkout = await stripe.redirectToCheckout({
      lineItems: [{ price: price, quantity: 1 }]
      mode: 'payment'
      clientReferenceId: payment.meta.id
      customerEmail: user.val.email
      successUrl: "#{window.location.origin}/pay/success"
      cancelUrl: "#{window.location.origin}/pay/failure"
    })

    if checkout.error
      @.router.transitionTo('pay.failure')

    return
  )

})

