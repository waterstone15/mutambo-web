import Controller from '@ember/controller'
import { action  } from '@ember/object'
import { inject as I } from '@ember/service'

export default Controller.extend({

  api:    I('api')
  router: I('router')

  accept: action(->
    obj = { code: @model.code }

    reply = await @api.echo({
      data: obj
      path: "/v2/invite/season-admin/accept"
    })

    if reply?
      @router.transitionTo('app.league.season.index', {
        queryParams: 
          league_id: @model.league.meta.id
          season_id: @model.season.meta.id
      })
    else
      @router.transitionTo('app.hello')
    return
  )

  ignore: action(->
    @router.transitionTo('app.hello')
  )


})