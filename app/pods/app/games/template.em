= page-title 'Games - Mutambo' replace=true separator=' → '

div class='min-h-screen flex flex-col md:flex-row'

  % AppNav [
    @leagues=model.leagues
    @user=model.user
  ]

  .flex.w-full
    .flex.flex-col.w-full
      .px-8.flex.justify-between.items-center.border-b.border-neutral-100 class='min-h-[80px]'
        .inline-flex.items-center.flex-wrap class='md:h-[48px] py-4 md:py-0'
          % Breadcrumb [
            @arrow=false
            @goto={hash route='app.hello'}
            @icon={hash transform='grow-1' icon='user' class='text-neutral-900'}
            @text={if model.user model.user.val.display_name 'Dashboard'}
          ]
          % Breadcrumb [
            @goto={hash route='app.games'}
            @icon={hash transform='grow-1' icon='futbol' class='text-red-400'}
            @text='Games'
          ]

      .p-8
        = if (not model.games.length)
          p.pb-2.italic.text-neutral-500: | You don't have any games yet.
          p.pb-2.italic.text-neutral-500: | All your games will show up here.

        = else
          div [
            class='border border-neutral-200'
            class='overflow-x-auto'
            class='w-full'
            class='mb-7'
          ]
            table.table-auto.w-full
              thead.font-medium.w-full
                th.py-0.bg-neutral-100.align-middle.text-center.font-normal.border-r.border-neutral-200.border-dashed.px-2
                  .inline-flex.items-center class='min-h-[40px]' {{model.games.length}}
                th.py-0.bg-neutral-100.align-middle.text-left.px-2: | Date
                th.py-0.bg-neutral-100.align-middle.text-left.px-2: | Time
                th.py-0.bg-neutral-100
                th.py-0.bg-neutral-100
                th.py-0.bg-neutral-100.align-middle.text-left.pr-2: | Home
                th.py-0.bg-neutral-100.align-middle.text-center.px-3 colspan='4': | Score
                th.py-0.bg-neutral-100
                th.py-0.bg-neutral-100.align-middle.text-left.pr-2: | Away
                th.py-0.bg-neutral-100.align-middle.text-left.px-2: | Location
                th.py-0.bg-neutral-100.align-middle.text-center.pl-2.pr-3.whitespace-nowrap colspan='2': | {{if is_manager 'Game Sheet'}}
              tbody
                = each model.games as |_g index|
                  tr.w-full class="hover:bg-amber-100 {{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    td.py-0.align-middle.text-center.border-r.border-neutral-200.border-dashed.px-2
                      .inline-flex.items-center class='min-h-[40px]' {{add index 1}}
                    

                    = if _g.val.canceled
                      td.py-0.align-middle.text-left.px-2 colspan='3'
                        .inline-flex.bg-white.rounded: span.border.border-red-600.rounded.font-medium.text-sm.px-2.py-1 class='bg-red-600/10': | CANCELED
                    = else
                      td.py-0.align-middle.text-center
                        span.font-mono.text-sm.whitespace-nowrap.px-2 {{_g.ui.date}}
                      td.py-0.align-middle.text-center
                        span.font-mono.text-sm.whitespace-nowrap.px-2 {{_g.ui.time}}
                      td.py-0.align-middle.text-center.text-neutral-400
                        span.font-mono.text-sm.whitespace-nowrap.pr-2 {{_g.ui.zone}}
                    
                    td.py-0.align-middle.text-right.pl-2.pr-px
                      = if _g.val.home_team.val.roles.length
                        % FaIcon @prefix='fas' @size='1x' @icon='diamond' @transform='shrink-8' class='text-neutral-900'
                    
                    td.py-0.align-middle.text-left.pr-3
                      .inline-flex.w-48 {{_g.val.home_team.val.name}}

                    td.py-0.align-middle.text-right.font-black.pl-3 class='pr-[2px]' {{get _g 'val.score.home'}}
                    td.py-0.align-middle.text-center
                      % FaIcon @prefix='fas' @size='1x' @icon='caret-left' @transform='shrink-0' class="{{if (lte (get _g 'val.score.home') (get _g 'val.score.away')) 'opacity-0'}}"
                    td.py-0.align-middle.text-center
                      % FaIcon @prefix='fas' @size='1x' @icon='caret-right' @transform='shrink-0' class="{{if (gte (get _g 'val.score.home') (get _g 'val.score.away')) 'opacity-0'}}"
                    td.py-0.align-middle.text-left.font-black.pr-3 class='pl-[2px]' {{get _g 'val.score.away'}}
                    
                    td.py-0.align-middle.text-right.pl-2.pr-px
                      = if _g.val.away_team.val.roles.length
                        % FaIcon @prefix='fas' @size='1x' @icon='diamond' @transform='shrink-8' class='text-neutral-900'
                    
                    td.py-0.align-middle.text-left.pr-3
                      .inline-flex.w-48 {{_g.val.away_team.val.name}}

                    td.py-0.align-middle.text-left.w-full.px-2 {{_g.val.location_text}}

                    td.py-0.align-middle.text-right
                      = if _g.val.is_manager
                        % LinkTo [
                          @query={hash game_id=_g.meta.id}
                          @route='app.game.sheet'
                          class='border border-neutral-700/0 h-8 px-2 hover:bg-white focus:hover:bg-white hover:cursor-pointer hover:shadow-sm inline-flex items-center justify-center mutambo-focus-sky overflow-hidden rounded-md'
                          role='link'
                          tabindex='0'
                        ]
                          % FaIcon @prefix='far' @size='1x' @transform='' @icon='file' class='text-neutral-900'

                    td.py-0.align-middle.text-center
                      = if _g.val.is_manager
                        = if _g.ui.gs
                          a href="{{env.app.gameSheetUrl}}/v2/game/sheet/{{_g.meta.id}}/game-sheet.pdf" class='border border-neutral-700/0 h-8 px-2 hover:bg-white focus:hover:bg-white hover:cursor-pointer hover:shadow-sm inline-flex items-center justify-center mutambo-focus-sky overflow-hidden rounded-md' role='link' tabindex='0' target='_blank'
                            % FaIcon [
                              @prefix='fas'
                              @size='1x'
                              @transform=''
                              @icon='file-lines'
                              class='text-neutral-900'
                            ]
                        = else
                          span.font-mono.text-sm.text-neutral-400 {{_g.ui.gs_wait}}

