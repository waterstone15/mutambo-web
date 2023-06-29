= page-title title_string replace=true separator=' → '

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
            @goto={hash route='app.league.season.teams' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @icon={hash transform='grow-2' icon='users' class='text-emerald-400'}
            @text='Teams'
          ]
          % Breadcrumb [
            @goto={hash route='app.league.season.teams' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @text={or model.team.val.name 'Team'}
          ]

      .p-8.flex.flex-col
        .flex.flex-col [
          class="max-w-4xl"
          class="md:w-full"
          class="2xl:w-8/12"
        ]

          .inline-flex.items-center.pb-1
            .font-medium.text-neutral-900 Managers

          .flex.pb-6.flex-col
            = if (not model.team.val.managers.length)
              p.pb-2.italic.text-neutral-500: | This team does not have any managers yet.
              p.pb-2.italic.text-neutral-500: | Managers of this team will show up here.
            = else
              .grid.border.border-neutral-100.rounded-md class='grid-cols-[auto_auto_1fr_auto] overflow-x-auto'
                .inline-flex.items-center.justify-center.h-10.bg-neutral-100.border-r.border-neutral-200.border-dashed {{model.team.val.managers.length}}
                .inline-flex.items-center.h-10.bg-neutral-100.font-medium.px-2.py-px: | Display Name
                .inline-flex.items-center.h-10.bg-neutral-100.font-medium.px-2.py-px: | Full Name
                .inline-flex.items-center.h-10.bg-neutral-100.font-medium.px-2.py-px Email

                = each (get model 'team.val.managers') as |_manager _index|
                  .contents.group
                    .inline-flex.items-center.justify-center.h-10.text-right.px-2.border-r.border-neutral-200.border-dashed class='group-hover:bg-amber-100' {{add _index 1}}
                    .inline-flex.items-center.h-10.px-2.whitespace-nowrap class='group-hover:bg-amber-100' {{_manager.val.display_name}}
                    .inline-flex.items-center.h-10.px-2.whitespace-nowrap class='group-hover:bg-amber-100' {{_manager.val.full_name}}
                    .inline-flex.items-center.h-10.px-2.whitespace-nowrap.break-all.text-neutral-400 class='group-hover:bg-amber-100' class='min-w-[220px]' {{_manager.val.email}}


          .inline-flex.items-center.pb-1
            .font-medium.text-neutral-900: | Players
          
          .flex.pb-6.flex-col
            = if (not model.team.val.players.length)
              p.pb-2.italic.text-neutral-500: | This team does not have any players yet.
              p.pb-2.italic.text-neutral-500: | Players on this team will show up here.
            = else
              .grid.border.border-neutral-100.rounded-md class='grid-cols-[auto_auto_1fr_auto_auto] overflow-x-auto'
                .inline-flex.items-center.justify-center.py-1.h-10.bg-neutral-100.border-r.border-neutral-200.border-dashed {{model.team.val.players.length}}
                .inline-flex.items-center.py-1.h-10.bg-neutral-100.font-medium.px-2.py-px: | Display Name
                .inline-flex.items-center.py-1.h-10.bg-neutral-100.font-medium.px-2.py-px: | Full Name
                .inline-flex.items-center.py-1.h-10.bg-neutral-100.font-medium.px-2.py-px: | Email
                .inline-flex.items-center.py-1.h-10.bg-neutral-100

                = each (get model 'team.val.players') as |_player _index|
                  .contents.group
                    .inline-flex.h-10.items-center.justify-center.px-2.border-r.border-neutral-200.border-dashed class='group-hover:bg-amber-100' {{add _index 1}}
                    .inline-flex.h-10.items-center.px-2.whitespace-nowrap class='group-hover:bg-amber-100' {{_player.val.display_name}}
                    .inline-flex.h-10.items-center.px-2.whitespace-nowrap class='group-hover:bg-amber-100' {{_player.val.full_name}}
                    .inline-flex.h-10.items-center.px-2.whitespace-nowrap.break-all.text-neutral-400 class='min-w-[220px]' class='group-hover:bg-amber-100' {{_player.val.email}}
                    .flex.items-center.justify-center class='group-hover:bg-amber-100 px-1'
                      / % LinkTo [
                      /   @route='app.league.season.team.remove-player'
                      /   @query={hash league_id=model.league.meta.id player_id=_player.meta.id season_id=model.season.meta.id team_id=model.team.meta.id }
                      /   class='border border-neutral-700/0 h-8 w-8 hover:bg-white focus:hover:bg-white hover:cursor-pointer hover:shadow-sm inline-flex items-center justify-center mutambo-focus-sky overflow-hidden rounded-md'
                      /   role='link'
                      /   tabindex='0'
                      / ]
                      /   % FaIcon [
                      /     @prefix='fas'
                      /     @size='1x'
                      /     @transform=''
                      /     @icon='user-minus'
                      /     class='text-neutral-900'
                      /   ]


          = if model.team.val.players_rm.length
            .inline-flex.items-center.pb-1
              .font-medium.text-neutral-900: | Removed Players
            
            .flex.pb-6.flex-col
              .grid.border.border-neutral-100.rounded-md class='grid-cols-[auto_auto_1fr_auto_auto] overflow-x-auto'
                .inline-flex.items-center.justify-center.py-1.h-10.bg-neutral-100.border-r.border-neutral-200.border-dashed {{model.team.val.players_rm.length}}
                .inline-flex.items-center.py-1.h-10.bg-neutral-100.font-medium.px-2.py-px: | Display Name
                .inline-flex.items-center.py-1.h-10.bg-neutral-100.font-medium.px-2.py-px: | Full Name
                .inline-flex.items-center.py-1.h-10.bg-neutral-100.font-medium.px-2.py-px: | Email
                .inline-flex.items-center.py-1.h-10.bg-neutral-100

                = each (get model 'team.val.players_rm') as |_player _index|
                  .contents.group
                    .inline-flex.h-10.items-center.justify-center.px-2.border-r.border-neutral-200.border-dashed class='group-hover:bg-amber-100' {{add _index 1}}
                    .inline-flex.h-10.items-center.px-2.whitespace-nowrap class='group-hover:bg-amber-100' {{_player.val.display_name}}
                    .inline-flex.h-10.items-center.px-2.whitespace-nowrap class='group-hover:bg-amber-100' {{_player.val.full_name}}
                    .inline-flex.h-10.items-center.px-2.whitespace-nowrap.break-all.text-neutral-400 class='min-w-[220px]' class='group-hover:bg-amber-100' {{_player.val.email}}
                    .flex.items-center.justify-center class='group-hover:bg-amber-100 px-1'