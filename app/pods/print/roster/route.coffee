import Route from '@ember/routing/route'
import env from 'mutambo-web/config/environment'
import { DateTime } from 'luxon'

export default Route.extend({

  model: (params) ->
    { id } = params

    headers = { 'Content-Type': 'application/json' }
    res = await fetch("#{env.app.apiUrl}/v1/game-sheets/#{id}", { headers })
    data = await res.json()
    sheet = data.sheet

    clock = sheet.val.start_clock_time
    zone = sheet.val.start_timezone
    if clock
      sheet.val.date_formatted = DateTime.fromISO(clock, { zone }).toFormat('ccc, LLL d, yyyy')
      sheet.val.time_formatted = DateTime.fromISO(clock, { zone }).toFormat('t ZZZZ')

    return { sheet }

})