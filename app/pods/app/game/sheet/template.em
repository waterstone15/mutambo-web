= page-title (get this 'title_string') replace=true separator=' → '

div class='min-h-screen flex flex-col md:flex-row min-w-full'

  % AppNav [
    @isLoggedIn=this.model.isLoggedIn
    @leagues=this.model.leagues
    @user=this.model.user
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
          % Breadcrumb [
            @goto={hash route='app.game.sheet' query=(hash game_id=model.sheet.game.meta.id)}
            @icon={hash transform='grow-1' icon='file' prefix='far' class='text-neutral-900'}
            @text={or model.team.val.name 'Game Sheet'}
          ]


      .p-8.flex.flex-col
        .flex.flex-col [
          class="max-w-4xl"
          class="md:w-full"
          class="2xl:w-8/12"
        ]

          .flex.w-full.flex-col

            .border-2.rounded-lg.px-4.grid.mb-4.border-yellow-400.bg-yellow-50 class='grid-cols-[auto_1fr]'
              .flex.p-2.justify-center.items-center
                % FaIcon @prefix='fas' @size='2xl' @icon='triangle-exclamation' class='text-yellow-400'
              .flex.p-4.flex-col
                span.text-lg.font-medium: | This is a preview, do not print.
                span
                  | 48 hours before each game, the official game sheet (PDF) will lock and become avaliable on your games page.

            
            .relative.top-0.left-0.p-4.w-full.border-2.border-black.rounded-lg
              .absolute.top-0.left-0.block.w-full.h-full.z-0
                .relative.flex.flex-col.justify-center.items-center.overflow-hidden.max-w-full.max-h-full
                  .relative.flex.justify-center.items-center class='w-[4000px] h-[4000px]' 
                    h1.-rotate-45.text-xl.font-black.select-none class='text-neutral-400/10 print:text-neutral-400/50'
                      = each red
                        | PREVIEW{{' '}}

              .relative.z-1.mb-10
                h1.mb-px.text-lg
                  span.font-black {{model.sheet.league.val.name}}
                  span {{', '}}
                  span.font-bold {{model.sheet.season.val.name}}
                h2.mb-4.text-lg
                  span.font-medium {{model.sheet.home.val.name}}
                  span.font-light {{' '}}vs.{{' '}}
                  span.font-medium {{model.sheet.away.val.name}}
                h3.mb-1
                  .inline-flex.items-center
                    span.inline-flex.items-center.justify-center.w-8
                      % FaIcon @prefix='fas' @size='' @icon='location-dot'
                    div
                      span {{' '}}
                      span.font-medium {{model.sheet.game.val.location_text}}
                h3.mb-1
                  .inline-flex.items-center
                    span.inline-flex.items-center.justify-center.w-8
                      % FaIcon @prefix='fas' @size='sm' @icon='clock'
                    div
                      span {{' '}}
                      span.font-mono {{model.sheet.game.ui.date}}
                      span {{' — '}}
                      span.font-mono {{model.sheet.game.ui.time}}
                      span {{' '}}
                      span.font-mono.text-sm {{model.sheet.game.ui.zone}}

              .relative.z-1.space-x-4.mb-2 class="grid grid-cols-[1fr_1fr]"
                div.text-center
                  .inline-flex.justify-center.items-center.mb-1
                    h4.font-bold.mr-1 {{model.sheet.home.val.name}}
                    h4 {{' '}}• Home Team
                  div.mb-1
                    = each model.sheet.home.val.managers as |manager|
                      div
                        span.inline-flex {{manager.val.full_name}}
                        span {{' — '}}
                        span.inline-flex.text-neutral-900 {{manager.val.email}}
                div.text-center
                  .inline-flex.justify-center.items-center.mb-1
                    h4.font-bold.mr-1 {{model.sheet.away.val.name}}
                    h4 {{' '}}• Away Team
                  div.mb-1
                    = each model.sheet.away.val.managers as |manager|
                      div
                        span.inline-flex {{manager.val.full_name}}
                        span {{' — '}}
                        span.inline-flex.text-neutral-900 {{manager.val.email}}

              .relative.z-1.relative
                div.space-x-4 class="grid grid-cols-[1fr_1fr]"
                  div
                    table.table-auto.border-t.border-l.border-black.w-full
                      thead
                        tr.border-b.border-black
                          th.w-10.px-2.py-2.text-center.border-r.border-black
                          th.w-10.px-2.py-2.text-center.border-r.border-black: | #
                          th.w-10.px-2.py-2.text-center.border-r.border-black: | ✓
                          th.px-2.py-2.text-start.border-r.border-black
                            span.inline.font-bold: | Player
                            span.inline.pl-1.font-normal.text-sm: | (Full Name)
                      tbody
                        = each model.sheet.home.val.players as |player index|
                          tr.border-b.border-black
                            td.w-10.px-1.py-2.text-center.border-r.border-black.text-xs {{add index 1}}
                            td.w-10.px-2.py-2.text-center.border-r.border-black
                            td.w-10.px-2.py-2.text-center.border-r.border-black
                            td.px-2.text-start.border-r.border-black
                              .flex.items-center.justify-between.flex-row
                                span.py-2 {{player.val.full_name}}
                                = if player.val.suspended
                                  span.border.border-red-500.px-2.py-px.bg-red-50.rounded: | Suspended
                                = if player.val.late
                                  span.border.border-yellow-400.px-2.py-px.bg-yellow-50.rounded: | Late Registration


                  div
                    table.table-auto.border-t.border-l.border-black.w-full
                      thead
                        tr.border-b.border-black
                          th.w-10.px-2.py-2.text-center.border-r.border-black
                          th.w-10.px-2.py-2.text-center.border-r.border-black: | #
                          th.w-10.px-2.py-2.text-center.border-r.border-black: | ✓
                          th.px-2.py-2.text-start.border-r.border-black
                            span.inline.font-bold: | Player
                            span.inline.pl-1.font-normal.text-sm: | (Full Name)
                      tbody
                        = each model.sheet.away.val.players as |player index|
                          tr.border-b.border-black
                            td.w-10.px-1.py-2.text-center.border-r.border-black.text-xs {{add index 1}}
                            td.w-10.px-2.py-2.text-center.border-r.border-black
                            td.w-10.px-2.py-2.text-center.border-r.border-black
                            td.px-2.text-start.border-r.border-black
                              .flex.items-center.justify-between.flex-row
                                span.py-2 {{player.val.full_name}}
                                = if player.val.suspended
                                  span.border.border-red-500.px-2.py-px.bg-red-50.rounded: | Suspended
                                = if player.val.late
                                  span.border.border-yellow-400.px-2.py-px.bg-yellow-50.rounded: | Late Registration





              
