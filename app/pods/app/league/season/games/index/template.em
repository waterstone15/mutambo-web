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
            @goto={hash route='app.league.season.games' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @icon={hash transform='grow-2' icon='futbol' prefix='fa-regular' class='text-red-400'}
            @text='Games'
          ]

        .inline-flex.items-center.justify-end.flex-wrap class='md:h-[48px] ml-4 md:py-0 ml-4'
          % LinkTo [
            @query={hash league_id=model.league.meta.id season_id=model.season.meta.id }
            @route='app.league.season.games.create'
            class='bg-neutral-50 border border-neutral-200 h-10 w-10 hover:bg-neutral-100 hover:cursor-pointer hover:shadow-sm inline-flex items-center justify-center mutambo-focus-sky overflow-hidden ml-3 rounded-md my-2'
            role='link'
            tabindex='0'
          ]
            % FaIcon [
              @prefix='fas'
              @size='1x'
              @transform='grow-0'
              @icon='plus'
              class='text-neutral-900'
            ]
          % LinkTo [
            @query={hash c=null p=null season_id=this.season_id}
            @route='global.games'
            class='bg-neutral-50 border border-neutral-200 h-10 w-10 hover:bg-neutral-100 hover:cursor-pointer hover:shadow-sm inline-flex items-center justify-center mutambo-focus-sky overflow-hidden ml-3 rounded-md my-2'
            role='link'
            tabindex='0'
          ]
            % FaIcon [
              @prefix='fas'
              @size='1x'
              @transform='grow-0'
              @icon='earth-americas'
              class='text-neutral-900'
            ]

      .p-8
        = if (not model.games.page.items.length)
          p.pb-2.italic.text-neutral-500: | This season doesn't have any games yet.
          p.pb-2.italic.text-neutral-500: | All games will show up here.

        = else
          div [
            class='border border-neutral-200'
            class='overflow-x-auto'
            class='w-full'
            class='mb-7'
          ]
            div [
              class="grid grid-cols-[auto_auto_auto_auto_auto_auto_auto_auto_auto_auto_1fr_auto_auto_auto]"
              class='sm:rounded-sm'
            ]
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium class='h-[40px]'
                span class='h-[40px] w-full border-r border-neutral-200 border-dashed inline-flex items-center justify-center font-normal px-2'
                  | {{model.games.counts.total}}
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-2 class='h-[40px]': span: | Date
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-2 class='h-[40px]': span: | Time
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-2 class='h-[40px]'
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-2 class='h-[40px]': span: | Home
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3.col-start-6.col-end-10 class='h-[40px]': span: | Score
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-2 class='h-[40px]': span: | Away
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-2 class='h-[40px]': span: | Location
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-2 class='h-[40px]': span: | Game Sheet
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-2 class='h-[40px]': span: | Ext. ID
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-2 class='h-[40px]'

              = each model.games.page.items as |_g index|
                .contents class="group/row"
                  div [
                    class='group-hover/row:bg-amber-100'
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='flex items-center justify-center'
                    class='border-r border-neutral-200 border-dashed'
                  ]
                    div class='px-2 py-2'
                      span: | {{add model.games.counts.before index 1}}

                  = if _g.val.canceled
                    div [
                      class='group-hover/row:bg-amber-100'
                      class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                      class='flex items-center justify-center'
                      class='py-1'
                      class='col-start-2 col-end-5'
                    ]
                      div class='mx-2 rounded border border-red-600 bg-white'
                        .inline-flex.font-medium.text-sm class='px-2 py-1 bg-red-600/10': | CANCELED
                  = else
                    div [
                      class='group-hover/row:bg-amber-100'
                      class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                      class='flex items-center'
                      class='py-1'
                      class=''
                    ]
                      div class='px-2 font-mono text-sm'
                        span.whitespace-nowrap: | {{_g.ui.date}}

                    div [
                      class='group-hover/row:bg-amber-100'
                      class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                      class='flex items-center'
                      class='py-1'
                      class=''
                    ]
                      div class='px-2 font-mono text-sm'
                        span.whitespace-nowrap: | {{_g.ui.time}}

                    div [
                      class='group-hover/row:bg-amber-100'
                      class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                      class='flex items-center'
                      class='py-1'
                      class=''
                    ]
                      div class='px-2 font-mono text-sm'
                        span.text-neutral-400: | {{_g.ui.zone}}

                  div [
                    class='group-hover/row:bg-amber-100'
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='flex items-center'
                    class='py-1'
                    class=''
                  ]
                    div class='px-2 w-full'
                      span: | {{_g.val.home_team.val.name}}

                  div [
                    class='group-hover/row:bg-amber-100'
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='flex items-center justify-end'
                    class='py-1 '
                    class='font-black'
                    class='pl-3 pr-[2px]'
                  ]
                    | {{get _g 'val.score.home'}}

                  div [
                    class='group-hover/row:bg-amber-100'
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='flex items-center justify-end'
                    class='py-1 '
                    class='font-black'
                    class=''
                  ]
                    % FaIcon @prefix='fas' @size='1x' @icon='caret-left' @transform='shrink-0' class="{{if (lte (get _g 'val.score.home') (get _g 'val.score.away')) 'opacity-0'}}"

                  div [
                    class='group-hover/row:bg-amber-100'
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='flex items-center justify-end'
                    class='py-1 '
                    class='font-black'
                    class=''
                  ]
                    % FaIcon @prefix='fas' @size='1x' @icon='caret-right' @transform='shrink-0' class="{{if (gte (get _g 'val.score.home') (get _g 'val.score.away')) 'opacity-0'}}"

                  div [
                    class='group-hover/row:bg-amber-100'
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='flex items-center justify-start'
                    class='py-1 '
                    class='font-black'
                    class='pl-[2px] pr-3'
                  ]
                    | {{get _g 'val.score.away'}}

                  div [
                    class='group-hover/row:bg-amber-100'
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='flex items-center justify-start'
                    class='py-1'
                    class=''
                  ]
                    div class='px-2'
                      span: | {{_g.val.away_team.val.name}}

                  div [
                    class='group-hover/row:bg-amber-100'
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='flex items-center justify-start'
                    class='py-1'
                    class=''
                  ]
                    div class='px-2'
                      span: | {{_g.val.location_text}}

                  div [
                    class='group-hover/row:bg-amber-100'
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='flex items-center justify-center'
                    class='py-1'
                    class=''
                  ]
                    .flex.flex-row class='px-2'
                      .py-0.inline-flex.justify-center.items-center.text-right
                        % LinkTo [
                          @query={hash league_id=model.league.meta.id season_id=model.season.meta.id game_id=_g.meta.id}
                          @route='app.league.season.game.sheet'
                          class='border border-neutral-700/0 h-8 px-2 group-hover/row:bg-white focus:hover:bg-white hover:cursor-pointer group-hover/row:shadow-sm inline-flex items-center justify-center mutambo-focus-sky overflow-hidden rounded-md'
                          role='link'
                          tabindex='0'
                        ]
                          % FaIcon @prefix='far' @size='1x' @transform='' @icon='file' class='text-neutral-900'

                      .py-0.inline-flex.justify-center.items-center.text-center
                        = if _g.ui.gs
                          a href="{{env.app.gameSheetUrl}}/v2/game/sheet/{{_g.meta.id}}/game-sheet.pdf" class='border border-neutral-700/0 h-8 px-2 ml-1 group-hover/row:bg-white focus:hover:bg-white hover:cursor-pointer group-hover/row:shadow-sm inline-flex items-center justify-center mutambo-focus-sky overflow-hidden rounded-md' role='link' tabindex='0' target='_blank'
                            % FaIcon [
                              @prefix='fas'
                              @size='1x'
                              @transform=''
                              @icon='file-lines'
                              class='text-neutral-900'
                            ]
                        = else
                          span.font-mono.text-sm.text-neutral-400 {{_g.ui.gs_wait}}

                  div [
                    class='group-hover/row:bg-amber-100'
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='flex items-center justify-start'
                    class='py-1'
                    class=''
                  ]
                    div class='px-2'
                      span: | {{_g.ext.gameofficials}}

                  div [
                    class='group-hover/row:bg-amber-100'
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='flex items-center justify-center'
                    class='px-1 py-1'
                    class=''
                  ]
                    % LinkTo [
                      @route='app.league.season.game.edit'
                      @query={hash league_id=model.league.meta.id season_id=model.season.meta.id game_id=_g.meta.id }
                      class='border border-neutral-700/0 h-8 w-8 group-hover/row:bg-white focus:hover:bg-white hover:cursor-pointer group-hover/row:shadow-sm inline-flex items-center justify-center mutambo-focus-sky overflow-hidden rounded-md'
                      role='link'
                      tabindex='0'
                    ]
                      % FaIcon [
                        @prefix='fas'
                        @size='1x'
                        @transform=''
                        @icon='pen'
                        class='text-neutral-900'
                      ]
                    % LinkTo [
                      @route='app.league.season.game.cancel'
                      @query={hash league_id=model.league.meta.id season_id=model.season.meta.id game_id=_g.meta.id }
                      class='border border-neutral-700/0 h-8 w-8 ml-1 group-hover/row:bg-white focus:hover:bg-white hover:cursor-pointer group-hover/row:shadow-sm inline-flex items-center justify-center mutambo-focus-sky overflow-hidden rounded-md'
                      role='link'
                      tabindex='0'
                    ]
                      % FaIcon [
                        @prefix='fas'
                        @size='1x'
                        @transform='rotate-90'
                        @icon='ban'
                        class='text-neutral-900'
                      ]
                    % LinkTo [
                      @route='app.league.season.game.delete'
                      @query={hash league_id=model.league.meta.id season_id=model.season.meta.id game_id=_g.meta.id }
                      class='border border-neutral-700/0 h-8 w-8 ml-1 group-hover/row:bg-white focus:hover:bg-white hover:cursor-pointer group-hover/row:shadow-sm inline-flex items-center justify-center mutambo-focus-sky overflow-hidden rounded-md'
                      role='link'
                      tabindex='0'
                    ]
                      % FaIcon [
                        @prefix='fas'
                        @size='1x'
                        @transform=''
                        @icon='trash'
                        class='text-neutral-900'
                      ]

          .flex
            = if model.games.prev
              % LinkTo [
                @route='app.league.season.games'
                @query={hash league_id=model.league.meta.id season_id=model.season.meta.id c=model.games.prev.meta.id p='page-end' }
                class='bg-white border border-neutral-300 flex h-[37px] hover:pointer hover:text-neutral-700 hover:bg-neutral-100 items-center justify-center mutambo-focus-sky no-underline rounded-md shadow-sm text-neutral-600 w-[37px]'
                role='link'
                tabindex='0'
              ]
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-left'
            = else
              div class='bg-white border border-neutral-200 flex h-[37px] items-center justify-center no-underline rounded-md shadow-sm text-neutral-300 w-[37px]'
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-left'

            = if model.games.next
              % LinkTo [
                @route='app.league.season.games'
                @query={hash league_id=model.league.meta.id season_id=model.season.meta.id c=model.games.next.meta.id p='page-start' }
                class='bg-white border border-neutral-300 flex h-[37px] hover:pointer hover:text-neutral-700 hover:bg-neutral-100 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-md shadow-sm text-neutral-600 w-[37px]'
                role='link'
                tabindex='0'
              ]
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-right'
            = else
              div class='bg-white border border-neutral-200 flex h-[37px] items-center justify-center no-underline rounded-md shadow-sm ml-2 text-neutral-300 w-[37px]'
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-right'
