import Service from '@ember/service'

export default Service.extend({

  ms: (delay = 0) ->
    new Promise((resolve) => setTimeout(resolve, delay))

})