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

      .p-8
        = if (not model.teams.page.items.length)
          p.pb-2.italic.text-neutral-500: | This season doesn't have any teams yet.
          p.pb-2.italic.text-neutral-500: | All registered teams will show up here.

        = else
          div [
            class='border border-neutral-200'
            class='overflow-x-auto'
            class='w-full'
            class='mb-7'
          ]
            div [
              class="grid grid-cols-[auto_auto_1fr_auto_auto_auto]"
              class='sm:rounded-sm'
            ]
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium class='h-[40px]'
                span class='h-[40px] w-full border-r border-neutral-200 border-dashed inline-flex items-center justify-center font-normal px-2'
                  | {{model.teams.counts.total}}
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-0 class='h-[40px]'
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.pr-3 class='h-[40px]': span: | Team
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | Division
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | Managers
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | Players

              = each model.teams.page.items as |_t index|
                .contents class='group/row'
                  div [
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='flex items-center justify-center'
                    class='border-r border-neutral-200 border-dashed'
                    class='group-hover/row:bg-amber-100'
                  ]
                    div class='px-2 py-2'
                      span: | {{add model.teams.counts.before index 1}}

                  div [
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='flex items-center justify-center'
                    class='group-hover/row:bg-amber-100'
                    class='px-1.5'
                  ]
                    % LinkTo [
                      @route='app.league.season.team'
                      @query={hash league_id=model.league.meta.id season_id=model.season.meta.id team_id=_t.meta.id}
                      class='flex items-center justify-center'
                      class='border border-transparent rounded-md'
                      class='mutambo-focus-sky hover:pointer hover:text-white hover:shadow-sm group-hover/row:bg-white group-hover/row:hover:bg-neutral-50'
                      class='h-8 w-8'
                      class='group/t-btn'
                      role='link'
                      tabindex='0'
                    ]
                      .flex.justify-center.items-center.rounded-full.bg-neutral-900 class='w-[14px] h-[14px]'
                        % FaIcon [
                          @icon='arrow-alt-circle-right'
                          @prefix='fas'
                          @size='1x'
                          @transform='grow-10'
                          class='relative group-hover/row:text-white group-hover/row:group-hover/t-btn:text-neutral-50'
                          class="{{if (eq (mod index 2) 1) 'text-neutral-50' 'text-white'}}"
                        ]

                  div [
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='flex items-center'
                    class='py-1'
                    class=''
                    class='group-hover/row:bg-amber-100'
                  ]
                    div class='pr-3 w-full'
                      span: | {{_t.val.name}}

                  div [
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='flex items-center justify-start'
                    class='py-1'
                    class=''
                    class='group-hover/row:bg-amber-100'
                  ]
                    div class='px-3'
                      span: | {{or _t.val.division.val.name '–'}}

                  div [
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='flex items-center justify-end'
                    class='py-1'
                    class=''
                    class='group-hover/row:bg-amber-100'
                  ]
                    div class='px-3'
                      span: | {{_t.val.manager_count}}

                  div [
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='flex items-center justify-end'
                    class='py-1'
                    class=''
                    class='group-hover/row:bg-amber-100'
                  ]
                    div class='px-3'
                      span: | {{_t.val.player_count}}




          .flex
            = if model.teams.prev
              % LinkTo [
                @route='app.league.season.teams'
                @query={hash league_id=model.league.meta.id season_id=model.season.meta.id c=model.teams.prev.meta.id p='page-end' }
                class='bg-white border border-neutral-300 flex h-[37px] hover:pointer hover:text-neutral-700 hover:bg-neutral-100 items-center justify-center mutambo-focus-sky no-underline rounded-md shadow-sm text-neutral-600 w-[37px]'
                role='link'
                tabindex='0'
              ]
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-left'
            = else
              div class='bg-white border border-neutral-200 flex h-[37px] items-center justify-center no-underline rounded-md shadow-sm text-neutral-300 w-[37px]'
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-left'

            = if model.teams.next
              % LinkTo [
                @route='app.league.season.teams'
                @query={hash league_id=model.league.meta.id season_id=model.season.meta.id c=model.teams.next.meta.id p='page-start' }
                class='bg-white border border-neutral-300 flex h-[37px] hover:pointer hover:text-neutral-700 hover:bg-neutral-100 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-md shadow-sm text-neutral-600 w-[37px]'
                role='link'
                tabindex='0'
              ]
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-right'
            = else
              div class='bg-white border border-neutral-200 flex h-[37px] items-center justify-center no-underline rounded-md shadow-sm ml-2 text-neutral-300 w-[37px]'
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-right'