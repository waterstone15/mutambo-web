import compact from 'lodash/compact'
import config from 'mutambo-web/config/environment'
import EmberRouter from '@ember/routing/router'
import filter from 'lodash/filter'
import get from 'lodash/get'
import join from 'lodash/join'
import keys from 'lodash/keys'
import reduce from 'lodash/reduce'
import set from 'lodash/set'
import split from 'lodash/split'

Router = (EmberRouter.extend {
  location: config.locationType
  rootURL: config.rootURL
})

rs = [
  [ '/app' ]
  [ '/app/account' ]
  [ '/app/account/edit-address' ]
  [ '/app/account/edit-birthday' ]
  [ '/app/account/edit-display-name' ]
  [ '/app/account/edit-full-name' ]
  [ '/app/account/edit-gender' ]
  [ '/app/game' ]
  [ '/app/game/sheet' ]
  [ '/app/games' ]
  [ '/app/hello' ]
  [ '/app/league' ]
  [ '/app/league/free-agents' ]
  [ '/app/league/season' ]
  [ '/app/league/season/divisions' ]
  [ '/app/league/season/divisions/create' ]
  [ '/app/league/season/facilities' ]
  [ '/app/league/season/facilities/create' ]
  [ '/app/league/season/game' ]
  [ '/app/league/season/game/cancel' ]
  [ '/app/league/season/game/delete' ]
  [ '/app/league/season/game/edit' ]
  [ '/app/league/season/game/sheet' ]
  [ '/app/league/season/games' ]
  [ '/app/league/season/games/create' ]
  [ '/app/league/season/misconduct' ]
  [ '/app/league/season/misconduct/edit' ]
  [ '/app/league/season/misconducts' ]
  [ '/app/league/season/misconducts/create' ]
  [ '/app/league/season/notifications' ]
  [ '/app/league/season/payments' ]
  [ '/app/league/season/payments/create' ]
  [ '/app/league/season/people' ]
  [ '/app/league/season/registrations' ]
  [ '/app/league/season/settings' ]
  [ '/app/league/season/settings/edit-name' ]
  [ '/app/league/season/settings/edit-player-registration-status' ]
  [ '/app/league/season/settings/edit-prices' ]
  [ '/app/league/season/settings/edit-required-info' ]
  [ '/app/league/season/settings/edit-roster-player-limit' ]
  [ '/app/league/season/settings/edit-team-manager-limit' ]
  [ '/app/league/season/settings/edit-team-player-limit' ]
  [ '/app/league/season/settings/edit-team-registration-status' ]
  [ '/app/league/season/standings' ]
  [ '/app/league/season/standings/create' ]
  [ '/app/league/season/team' ]
  [ '/app/league/season/team/remove-player' ]
  [ '/app/league/season/teams' ]
  [ '/app/league/seasons' ]
  [ '/app/league/seasons/create' ]
  [ '/app/leagues' ]
  [ '/app/payments' ]
  [ '/app/player-card' ]
  [ '/app/player-card/edit' ]
  [ '/app/player-cards' ]
  [ '/app/registration' ]
  [ '/app/registrations' ]
  [ '/app/season' ]
  [ '/app/seasons' ]
  [ '/app/settings' ]
  [ '/app/support' ]
  [ '/app/team' ]
  [ '/app/team/edit-players' ]
  [ '/app/team/remove-players' ]
  [ '/app/teams' ]
  [ '/auth' ]
  [ '/auth/auth-code-link' ]
  [ '/global' ]
  [ '/global/divisions' ]
  [ '/global/games' ]
  [ '/global/standings' ]
  [ '/help' ]
  [ '/invite' ]
  [ '/invite/league-free-agent' ]
  [ '/invite/season-admin ' ]
  [ '/invite/season-team' ]
  [ '/invite/team-manager' ]
  [ '/invite/team-player' ]
  [ '/log-out' ]
  [ '/pay' ]
  [ '/pay/failure' ]
  [ '/pay/success' ]
  [ '/print' ]
  [ '/print/roster' ]
  [ '/privacy' ]
  [ '/register' ]
  [ '/register/failure' ]
  [ '/register/league-free-agent' ]
  [ '/register/season-team' ]
  [ '/register/success' ]
  [ '/register/team-manager' ]
  [ '/register/team-player' ]
  [ '/schedule' ]
  [ '/sign-in' ]
  [ '/sign-in-await' ]
  [ '/standings' ]
  [ '/terms' ]
]

route_tree = (reduce rs, (_tree, _route) ->
  parts = (compact (split _route[0], '/'))
  (set _tree, (join parts, '.'), { _opts: (_route[1] ? {}) })
  return _tree
, { _opts: {} })

generate = (_tree, _self) ->
  pks = (filter (keys _tree), (_k) -> !/^_/.test(_k))
  for k in pks
    fn = -> (generate (get _tree, k ), @)
    (_self.route k, _tree[k]._opts, fn)
  return

Router.map ->
  (generate route_tree, @)
  @.route 'not-found', { path: '/*' }


export default Router
