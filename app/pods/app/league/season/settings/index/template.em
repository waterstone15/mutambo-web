= page-title (get this 'title_string') replace=true separator=' → '

div class='min-h-screen flex flex-col md:flex-row'

  % AppNav [
    @league=model.league
    @leagues=model.leagues
    @season=model.season
    @seasons=model.seasons
    @user=model.user
  ]

  .flex.w-full
    .flex.flex-col.w-full
      .px-8.flex.justify-between.items-center.border-b.border-neutral-100 class='min-h-[80px]'
        .inline-flex.items-center.flex-wrap class='md:h-[48px] py-4 md:py-0'
          % Breadcrumb [
            @arrow=false
            @goto={hash route='app.league.index' query=(hash league_id=model.league.meta.id)}
            @image={hash src=model.league.val.logo_url alt='League Logo'}
            @icon={hash transform='grow-0' icon='trophy' class='text-amber-400'}
            @text={or model.league.val.name 'League'}
          ]
          % Breadcrumb [
            @goto={hash route='app.league.season.index' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @icon={hash transform='grow-1' icon='sun' class='text-yellow-400'}
            @text={or model.season.val.name 'Season'}
          ]
          % Breadcrumb [
            @goto={hash route='app.league.season.settings' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @icon={hash transform='grow-2' icon='cogs' class='text-slate-400'}
            @text='Settings'
          ]

      .p-8
        .flex.flex-col.max-w-sm class='w-full sm:w-8/12 md:w-7/12 lg:w-5/12 xl:w-4/12 2xl:w-3/12'

          .flex.w-full.justify-between.items-center.pb-1
            .font-medium.text-neutral-900 Team Registration
            % LinkTo [
              @route='app.league.season.settings.edit-team-registration-status'
              @query={hash league_id=model.league.meta.id season_id=model.season.meta.id}
              class='bg-white border border-neutral-200 flex h-[30px] hover:pointer hover:text-neutral-700 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-full shadow-sm text-neutral-500 w-[30px]'
              role='link'
              tabindex='0'
            ]
              % FaIcon @prefix='fas' @size='1x' @transform='shrink-2' @icon='pen'
          .flex.pb-6
            = if (eq (get model 'season_settings.val.registration_status.team_season') 'open')
              | Open
            = else
              | Closed

          .flex.w-full.justify-between.items-center.pb-1
            .font-medium.text-neutral-900 Player Registration
            % LinkTo [
              @route='app.league.season.settings.edit-player-registration-status'
              @query={hash league_id=model.league.meta.id season_id=model.season.meta.id}
              class='bg-white border border-neutral-200 flex h-[30px] hover:pointer hover:text-neutral-700 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-full shadow-sm text-neutral-500 w-[30px]'
              role='link'
              tabindex='0'
            ]
              % FaIcon @prefix='fas' @size='1x' @transform='shrink-2' @icon='pen'
          .flex.pb-6
            p.pb-2.text-neutral-800
              = if (eq (get model 'season_settings.val.registration_status.player_team') 'open')
                | Open
              = else
                | Closed

          .flex.w-full.justify-between.items-center.pb-1
            .font-medium.text-neutral-900 Team Manager Limit
            % LinkTo [
              @route='app.league.season.settings.edit-team-manager-limit'
              @query={hash league_id=model.league.meta.id season_id=model.season.meta.id}
              class='bg-white border border-neutral-200 flex h-[30px] hover:pointer hover:text-neutral-700 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-full shadow-sm text-neutral-500 w-[30px]'
              role='link'
              tabindex='0'
            ]
              % FaIcon @prefix='fas' @size='1x' @transform='shrink-2' @icon='pen'
          .flex.pb-6
            p.pb-2.text-neutral-800.font-mono {{or (get model 'season_settings.val.team_limits.team_managers') '1'}}
            
          .flex.w-full.justify-between.items-center.pb-1
            .font-medium.text-neutral-900 Team Player Limit
            % LinkTo [
              @route='app.league.season.settings.edit-team-player-limit'
              @query={hash league_id=model.league.meta.id season_id=model.season.meta.id}
              class='bg-white border border-neutral-200 flex h-[30px] hover:pointer hover:text-neutral-700 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-full shadow-sm text-neutral-500 w-[30px]'
              role='link'
              tabindex='0'
            ]
              % FaIcon @prefix='fas' @size='1x' @transform='shrink-2' @icon='pen'
          .flex.pb-6
            p.pb-2.text-neutral-800.font-mono {{or (get model 'season_settings.val.team_limits.team_players') '1'}}

          .flex.w-full.justify-between.items-center.pb-1
            .font-medium.text-neutral-900: | Player Limit
            % LinkTo [
              @route='app.league.season.settings.edit-roster-player-limit'
              @query={hash league_id=model.league.meta.id season_id=model.season.meta.id}
              class='bg-white border border-neutral-200 flex h-[30px] hover:pointer hover:text-neutral-700 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-full shadow-sm text-neutral-500 w-[30px]'
              role='link'
              tabindex='0'
            ]
              % FaIcon @prefix='fas' @size='1x' @transform='shrink-2' @icon='pen'
          .flex.pb-6
            p.pb-2.text-neutral-800.font-mono {{or (get model 'season_settings.val.team_limits.rostered_players') '1'}}

          .flex.w-full.justify-between.items-center.pb-2
            .font-medium.text-neutral-900 Required Information
            % LinkTo [
              @route='app.league.season.settings.edit-required-info'
              @query={hash league_id=model.league.meta.id season_id=model.season.meta.id}
              class='bg-white border border-neutral-200 flex h-[30px] hover:pointer hover:text-neutral-700 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-full shadow-sm text-neutral-500 w-[30px]'
              role='link'
              tabindex='0'
            ]
              % FaIcon @prefix='fas' @size='1x' @transform='shrink-2' @icon='pen'
          .inline-flex.pb-8
            table.table-auto.border-separate.w-full
              thead
                tr.border-b-1.border-t-1.border-neutral-200.rounded.overflow-hidden
                  th.bg-neutral-100.rounded-l: .pr-2.py-1.px-2.uppercase.text-neutral-800.text-sm.flex.items-start
                  / th.bg-neutral-100: .px-2.py-1.px-2.uppercase.text-neutral-800.text-sm Admins
                  th.bg-neutral-100: .px-2.py-1.px-2.uppercase.text-neutral-800.text-sm Managers
                  th.bg-neutral-100.rounded-r: .pl-2.py-1.px-2.uppercase.text-neutral-800.text-sm Players
              tbody
                tr
                  td: .pt-1.px-2.flex Address
                  / td: .pt-1.px-2.flex.items-center.justify-center
                  /   = if (get model 'season_settings.val.required_info.admin.address')
                  /     % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                  /   = else
                  /     % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .pt-1.px-2.flex.items-center.justify-center
                    = if (get model 'season_settings.val.required_info.manager.address')
                      % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                    = else
                      % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .pt-1.px-2.pl-2.flex.items-center.justify-center
                    = if (get model 'season_settings.val.required_info.player.address')
                      % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                    = else
                      % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                tr
                  td: .pt-1.px-2.flex Birthday
                  / td: .pt-1.px-2.flex.items-center.justify-center
                  /   = if (get model 'season_settings.val.required_info.admin.birthday')
                  /     % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                  /   = else
                  /     % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .pt-1.px-2.flex.items-center.justify-center
                    = if (get model 'season_settings.val.required_info.manager.birthday')
                      % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                    = else
                      % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .pt-1.px-2.pl-2.flex.items-center.justify-center
                    = if (get model 'season_settings.val.required_info.player.birthday')
                      % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                    = else
                      % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                tr
                  td: .pt-1.px-2.flex Display Name
                  / td: .pt-1.px-2.flex.items-center.justify-center
                  /   = if (get model 'season_settings.val.required_info.admin.display_name')
                  /     % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                  /   = else
                  /     % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .pt-1.px-2.flex.items-center.justify-center
                    = if (get model 'season_settings.val.required_info.manager.display_name')
                      % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                    = else
                      % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .pt-1.px-2.pl-2.flex.items-center.justify-center
                    = if (get model 'season_settings.val.required_info.player.display_name')
                      % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                    = else
                      % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                tr
                  td: .pt-1.px-2.flex
                    .inline
                      span Email
                      span.text-xs.font-normal.text-neutral-400.ml-1 {{' '}}Mandatory
                  / td: .pt-1.px-2.flex.items-center.justify-center
                  /   = if (get model 'season_settings.val.required_info.admin.email')
                  /     % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                  /   = else
                  /     % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .pt-1.px-2.flex.items-center.justify-center
                    = if (get model 'season_settings.val.required_info.manager.email')
                      % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-800'
                    = else
                      % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .pt-1.px-2.pl-2.flex.items-center.justify-center
                    = if (get model 'season_settings.val.required_info.player.email')
                      % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-800'
                    = else
                      % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'
                
                tr
                  td: .pt-1.px-2.flex Full Name
                  / td: .pt-1.px-2.flex.items-center.justify-center
                  /   = if (get model 'season_settings.val.required_info.admin.full_name')
                  /     % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                  /   = else
                  /     % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .pt-1.px-2.flex.items-center.justify-center
                    = if (get model 'season_settings.val.required_info.manager.full_name')
                      % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                    = else
                      % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .pt-1.px-2.pl-2.flex.items-center.justify-center
                    = if (get model 'season_settings.val.required_info.player.full_name')
                      % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                    = else
                      % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                tr
                  td: .pt-1.px-2.flex Gender
                  / td: .pt-1.px-2.flex.items-center.justify-center
                  /   = if (get model 'season_settings.val.required_info.admin.gender')
                  /     % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                  /   = else
                  /     % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .pt-1.px-2.flex.items-center.justify-center
                    = if (get model 'season_settings.val.required_info.manager.gender')
                      % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                    = else
                      % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .pt-1.px-2.pl-2.flex.items-center.justify-center
                    = if (get model 'season_settings.val.required_info.player.gender')
                      % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                    = else
                      % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                tr
                  td: .pt-1.px-2.flex Phone
                  / td: .pt-1.px-2.flex.items-center.justify-center
                  /   = if (get model 'season_settings.val.required_info.admin.phone')
                  /     % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                  /   = else
                  /     % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .pt-1.px-2.flex.items-center.justify-center
                    = if (get model 'season_settings.val.required_info.manager.phone')
                      % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                    = else
                      % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .pt-1.px-2.pl-2.flex.items-center.justify-center
                    = if (get model 'season_settings.val.required_info.player.phone')
                      % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                    = else
                      % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

          .flex.w-full.justify-between.items-center.pb-2
            .font-medium.text-neutral-900 Fees
            % LinkTo [
              @route='app.league.season.settings.edit-prices'
              @query={hash league_id=model.league.meta.id season_id=model.season.meta.id}
              class='bg-white border border-neutral-200 flex h-[30px] hover:pointer hover:text-neutral-700 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-full shadow-sm text-neutral-500 w-[30px]'
              role='link'
              tabindex='0'
            ]
              % FaIcon @prefix='fas' @size='1x' @transform='shrink-2' @icon='pen'
          .inline-flex.pb-8
            table.table-auto.border-separate.w-full
              thead
                tr.border-b-1.border-t-1.border-neutral-200.rounded.overflow-hidden
                  th.bg-neutral-100.rounded-l: .pr-2.py-1.px-2.uppercase.text-neutral-800.text-sm.flex.items-start
                  th.bg-neutral-100: .flex.pl-2.py-1.px-2.uppercase.text-neutral-800.text-sm.justify-end Standard
                  th.bg-neutral-100.rounded-r: .flex.pl-2.py-1.px-2.uppercase.text-neutral-800.text-sm.justify-end Returning
              tbody
                tr
                  td: .pt-1.px-2.flex style='min-width: 85px;' Team × Season
                  td: .pt-1.px-2.flex.items-center.justify-end
                    = get model 'season_settings.ui.prices.team_per_season.default'
                  td: .pt-1.px-2.flex.items-center.justify-end
                    = get model 'season_settings.ui.prices.team_per_season.returning'

                tr
                  td: .pt-1.px-2.flex Player × Season
                  td: .pt-1.px-2.flex.items-center.justify-end
                    = get model 'season_settings.ui.prices.player_per_season.default'
                  td: .pt-1.px-2.flex.items-center.justify-end
                    = get model 'season_settings.ui.prices.player_per_season.returning'





