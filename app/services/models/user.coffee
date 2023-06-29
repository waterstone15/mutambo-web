import cloneDeep from 'lodash/cloneDeep'
import includes from 'lodash/includes'
import isEmpty from 'lodash/isEmpty'
import isString from 'lodash/isString'
import padStart from 'lodash/padStart'
import Service from '@ember/service'
import throttle from 'lodash/throttle'
import { DateTime } from 'luxon'
import { inject as I } from '@ember/service'

export default Service.extend({

  api:  I()
  auth: I()

  init: ->
    (@._super ...arguments)
    (@._throttle_load())
    return

  _throttle_load: ->
    func    = (@._load.bind @)
    wait    = 1000
    options = { leading: true, trailing: false }
    @.load  = (throttle func, wait, options)

  _load: ->
    data = await (@.api.echo { path: '/v1/user/retrieve' })
    return data.user ? null

  sync: (opts) ->
    { force } = (opts ? {})
    (@._throttle_load()) if force
    return await @.load()

  ok:
    address: (ad) ->
      return (isString ad) && !(isEmpty ad)

    birthday: (_bd, min_age) ->
      bd  = (cloneDeep _bd)
      now = DateTime.local().setZone('utc')

      day   = (padStart "#{bd.day}", 2, '0')
      month = (padStart "#{bd.month}", 2, '0')
      year  = (padStart "#{bd.year}", 4, '0')
      bday  = DateTime.fromISO("#{year}-#{month}-#{day}", { zone: 'utc' })

      if !bday.isValid
        return false

      leeway   = 36
      max_age  = 150
      min_age  = min_age ? 0
      is_alive = now < (bday.plus { years: max_age })
      is_born  = now > bday
      is_old   = now > bday.plus({ years: min_age }).minus({ hours: leeway })
      return (is_born && is_alive && is_old)

    displayName: (dn) ->
      return (isString dn) && !(isEmpty dn)

    fullName: (fn) ->
      return (isString fn) && !(isEmpty fn)

    gender: (g) ->
      return (includes [ 'female', 'male', 'other' ], g)

    phone: (p) ->
      return (isString p) && !(isEmpty p)

})






