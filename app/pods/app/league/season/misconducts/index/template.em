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
            @goto={hash route='app.league.season.misconducts' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @icon={hash transform='grow-2' icon='gavel' class='text-brown-600'}
            @text='Misconduct'
          ]
        .inline-flex.items-center.justify-end.flex-wrap class='md:h-[48px] ml-4 md:py-0 ml-4'
          % LinkTo [
            @query={hash league_id=model.league.meta.id season_id=model.season.meta.id }
            @route='app.league.season.misconducts.create'
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

      .p-8
        = if (not model.misconducts.page.items.length)
          p.pb-2.italic.text-neutral-500: | This season doesn't have any misconducts yet.
          p.pb-2.italic.text-neutral-500: | All misconducts will show up here.

        = else
          div [
            class='border border-neutral-200'
            class='overflow-x-auto'
            class='w-full'
            class='mb-7'
          ]
            table.table-auto.w-full
              tr.font-medium.w-full
                th.py-0.bg-neutral-100.align-middle.text-center.font-normal.border-r.border-neutral-200.border-dashed.px-3 class='w-[1%]' rowspan='2'
                  .inline-flex.items-center class='min-h-[40px]' {{model.misconducts.page.items.length}}
                th.py-0.bg-neutral-100.align-middle.text-left.px-2.w-50 class='w-[15%]' rowspan='2': | Name
                th.py-px.align-middle.text-center.px-2.border-r.border-l.border-b.border-neutral-200.font-normal.text-neutral-800.text-xs.tracking-widest class='bg-neutral-200/60' colspan='8': | SUSPENSION
                th.py-0.bg-neutral-100.align-middle.text-left.px-3 class='w-[5%]' rowspan='2': | Demerits
                th.py-0.bg-neutral-100.align-middle.text-left.px-2 class='w-[5%]' rowspan='2' colspan='3': | Payment
                th.py-0.bg-neutral-100.align-middle.text-left.px-3 class='w-[1%]' rowspan='2': | Status
                th.py-0.bg-neutral-100.align-middle.text-left.px-0 class='w-[1%]' rowspan='2'
              tr.font-medium.w-full
                th.py-2.bg-neutral-100.align-middle.text-center.px-2.border-l.border-neutral-200 class='w-[1%]': | Suspend
                th.py-2.bg-neutral-100.align-middle.text-left.px-2 class='w-[10%]': | Scope
                th.py-2.bg-neutral-100.align-middle.text-left.px-2 class='w-[1%]' colspan='3': | Start
                th.py-2.bg-neutral-100.align-middle.text-left.pr-3.pl-2.border-r.border-neutral-200 class='w-[1%]' colspan='3': | End
              = each model.misconducts.page.items as |_m index|
                tr.w-full class="group/row hover:bg-amber-100 {{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  td.py-0.align-middle.text-center.border-r.border-neutral-200.border-dashed.px-2
                    .inline-flex.items-center class='min-h-[40px]' {{add index 1}}
                  td.py-0.align-middle.text-left.px-2
                    .inline-flex {{_m.val.user.val.full_name}}
                  td.py-0.align-middle.text-center.px-2.border-l.border-neutral-200
                    = if _m.val.suspend
                      | Yes
                    = else
                      | No
                  td.py-1.align-middle.text-left.px-2
                    .grid class='grid-cols-[auto_1fr]'
                      = if _m.ui.scope_leagues
                        .flex.items-center.mr-1
                          % FaIcon @prefix='fas' @size='xs' @transform='shrink-0' @icon='trophy'class='text-amber-400'
                        div {{_m.ui.scope_leagues}}
                      = if _m.ui.scope_seasons
                        .flex.items-center.mr-1
                          % FaIcon @prefix='fas' @size='xs' @transform='shrink-0' @icon='sun' class='text-yellow-400'
                        div {{_m.ui.scope_seasons}}
                      = if _m.ui.scope_teams
                        .flex.items-center.mr-1
                          % FaIcon @prefix='fas' @size='xs' @transform='shrink-1' @icon='users' class='text-emerald-400'
                        div {{_m.ui.scope_teams}}
                  td.py-0.align-middle.text-left.px-2
                    span.font-mono.text-sm.whitespace-nowrap {{_m.ui.start_date}}
                  td.py-0.align-middle.text-left.px-2
                    span.font-mono.text-sm.whitespace-nowrap {{_m.ui.start_time}}
                  td.py-0.align-middle.text-left.pl-2.pr-4
                    span.font-mono.text-sm.text-neutral-400.whitespace-nowrap {{_m.ui.start_zone}}
                  
                  = if _m.ui.end_date
                    td.py-0.align-middle.text-left.px-2
                      span.font-mono.text-sm.whitespace-nowrap {{_m.ui.end_date}}
                    td.py-0.align-middle.text-left.px-2
                      span.font-mono.text-sm.whitespace-nowrap {{_m.ui.end_time}}
                    td.py-0.align-middle.text-left.pr-3.pl-2.border-r.border-neutral-200
                      span.font-mono.text-sm.text-neutral-400.whitespace-nowrap {{_m.ui.end_zone}}
                  = else
                    td.border-r.border-neutral-200 colspan='3'

                  td.py-0.align-middle.text-left.px-3 {{_m.val.demerits}}
                  = if _m.val.payment
                    td.py-0.pl-2.align-middle.text-center
                        span.rounded-sm.font-medium.text-sm class='px-2 py-0.5 bg-[#c0c3a1]/50'
                          | {{_m.ui.currency}}
                    td.py-0.align-middle.text-right
                      span.font-mono.font-medium: | {{_m.ui.total}}
                    td.py-0.align-middle.text-center.px-2
                      = if (eq _m.val.payment.val.status 'paid')
                        a [
                          class='bg-white'
                          class='w-full justify-center border font-medium border-green-500 hover:bg-green-50 hover:pointer inline-flex mutambo-focus-sky px-2 py-1 rounded-md shadow-sm text-sm text-green-700 items-center'
                          href='{{_m.ui.link}}'
                          role='link'
                          tabindex='0'
                        ]
                          % FaIcon @prefix='fas' @size='1x' @icon='check' @transform='grow-0' class='text-green-500'
                          span.ml-1.mr-1: | Paid
                      = else if (eq _m..val.payment.val.status 'refunded')
                        a [
                          class='w-full justify-center border font-medium border-red-500 hover:bg-red-50 hover:pointer inline-flex mutambo-focus-sky px-2 py-1 rounded-md shadow-sm text-sm text-red-700 items-center'
                          href='{{_m.ui.link}}'
                          role='link'
                          tabindex='0'
                        ]
                          % FaIcon @prefix='fas' @size='1x' @icon='rotate-left' @transform='grow-0' class='text-red-500'
                          span.ml-1.mr-1: | Refunded
                      = else
                        a [
                          class='w-full justify-center bg-green-500 border border-transparent font-medium hover:border-green-600 hover:pointer inline-flex mutambo-focus-sky px-2 py-1 rounded-md shadow-sm text-sm text-white'
                          href='{{_m.ui.link}}'
                          role='link'
                          tabindex='0'
                        ]
                          span.mr-1.ml-1: | View
                  = else
                    td.py-0.align-middle.text-center
                    td.py-0.align-middle.text-right
                    td.py-0.align-middle.text-center
                  td.py-0.align-middle.text-left.px-3 class="{{if (eq _m.ui.status 'Resolved') 'text-green-700' 'text-brown-800'}}"
                    span.whitespace-nowrap
                      span.mr-2
                        = if (eq _m.ui.status 'Resolved')
                          % FaIcon @fixedWidth=true @prefix='fas' @size='sm' @transform='shrink-0' @icon='check'
                        = else
                          % FaIcon @fixedWidth=true @prefix='fas' @size='sm' @transform='shrink-0' @icon='gavel'
                      span {{_m.ui.status}}

                  td.py-0.align-middle.text-left.px-3
                    = if (eq _m.ui.status 'Suspended')
                      % LinkTo [
                        @route='app.league.season.misconduct.edit'
                        @query={hash league_id=model.league.meta.id season_id=model.season.meta.id misconduct_id=_m.meta.id}
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

          .flex
            = if model.misconducts.prev
              % LinkTo [
                @route='app.league.season.misconducts'
                @query={hash league_id=model.league.meta.id season_id=model.season.meta.id c=model.misconducts.prev.meta.id p='page-end' }
                class='bg-white border border-neutral-300 flex h-[37px] hover:pointer hover:text-neutral-700 hover:bg-neutral-100 items-center justify-center mutambo-focus-sky no-underline rounded-md shadow-sm text-neutral-600 w-[37px]'
                role='link'
                tabindex='0'
              ]
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-left'
            = else
              div class='bg-white border border-neutral-200 flex h-[37px] items-center justify-center no-underline rounded-md shadow-sm text-neutral-300 w-[37px]'
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-left'

            = if model.misconducts.next
              % LinkTo [
                @route='app.league.season.misconducts'
                @query={hash league_id=model.league.meta.id season_id=model.season.meta.id c=model.misconducts.next.meta.id p='page-start' }
                class='bg-white border border-neutral-300 flex h-[37px] hover:pointer hover:text-neutral-700 hover:bg-neutral-100 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-md shadow-sm text-neutral-600 w-[37px]'
                role='link'
                tabindex='0'
              ]
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-right'
            = else
              div class='bg-white border border-neutral-200 flex h-[37px] items-center justify-center no-underline rounded-md shadow-sm ml-2 text-neutral-300 w-[37px]'
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-right'

