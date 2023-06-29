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
            @goto={hash route='app.league.season.payments' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @icon={hash transform='grow-1' icon='university' class='text-green-500'}
            @text='Payments'
          ]

        .inline-flex.items-center.justify-end.flex-wrap class='md:h-[48px] ml-4 md:py-0 ml-4'
          % LinkTo [
            @query={hash league_id=model.league.meta.id season_id=model.season.meta.id }
            @route='app.league.season.payments.create'
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
        = if (not model.payments.page.items.length)
          p.pb-2.italic.text-neutral-500: | You don't have any payments.
          p.pb-2.italic.text-neutral-500: | All of your payments will show up here.

        = else
          div [
            class='border border-neutral-200'
            class='overflow-x-auto'
            class='w-full'
            class='mb-7'
          ]
            div [
              class="grid grid-cols-[auto_auto_auto_1fr_auto_auto_auto_auto_auto]"
              class='sm:rounded-sm'
            ]
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium class='h-[40px]'
                span class='h-[40px] w-full border-r border-neutral-200 border-dashed inline-flex items-center justify-center font-normal px-2'
                  | {{model.payments.counts.total}}
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | Type
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | Created
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | Description
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | Team
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | Assignee / Payer
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium class='h-[40px]'
              .inline-flex.justify-end.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | Total
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | Payment
              / .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium class='h-[40px]'


              = each model.payments.page.items as |_p index|
                .contents.group
                  div [
                    class="group-hover:bg-amber-100"
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='flex items-center justify-center'
                    class='border-r border-neutral-200 border-dashed'
                  ]
                    div class='px-2 py-2'
                      span: | {{sub model.payments.counts.total model.payments.counts.before index}}

                  div [
                    class="group-hover:bg-amber-100"
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='inline-flex items-center justify-center'
                    class='whitespace-nowrap'
                    class=''
                  ]
                    div class='inline-flex justify-center px-3 w-full'
                      = if (eq _p.meta.type 'payment/season-team-registration')
                        span class='inline-flex items-center justify-center px-1.5 py-0.5 rounded-sm text-xs font-medium bg-stone-400/30 uppercase'
                          span: | Team Registration
                      = if (eq _p.meta.type 'payment')
                        span class='px-1.5 py-0.5 rounded-sm text-xs font-medium bg-green-700/20 uppercase': | Payment
                      = if (eq _p.meta.type 'payment/misconduct')
                        span class='px-1.5 py-0.5 rounded-sm text-xs font-medium bg-brown-600/30 uppercase': | Misconduct

                  div [
                    class="group-hover:bg-amber-100"
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='flex items-center'
                    class='py-1'
                    class=''
                  ]
                    div class='px-3 w-full'
                      span class='font-mono text-sm': | {{_p.ui.created_at}}

                  div [
                    class="group-hover:bg-amber-100"
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='flex items-center'
                    class='py-1'
                    class='min-w-[300px]'
                  ]
                    div class='px-3 w-full'
                      span: | {{_p.val.description}}

                  div [
                    class="group-hover:bg-amber-100"
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='inline-flex items-center'
                    class='py-1'
                    class=''
                  ]
                    div class='px-3 max-w-[300px] min-w-[200px]'
                      = if (not (not _p.val.team.val.name))
                        span: | {{_p.val.team.val.name}}
                      = else
                        span: | {{'—'}}

                  div [
                    class="group-hover:bg-amber-100"
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='flex items-center'
                    class='overflow-x-auto'
                    class='min-w-[250px] py-1'
                  ]
                    div class='inline-flex px-3 w-full flex-col justify-start items-start'
                      = if (not (not _p.val.payer.val.email))
                        span: | {{_p.val.payer.val.full_name}}
                        span.text-neutral-400.font-light.italic: | {{_p.val.payer.val.email}}
                      = else
                        span: | {{_p.val.assignee.val.full_name}}
                        span.text-neutral-400.font-light.italic: | {{_p.val.assignee.val.email}}
                      
                  div [
                    class="group-hover:bg-amber-100"
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='inline-flex items-center'
                    class='whitespace-nowrap'
                    class=''
                  ]
                    div class='inline-flex pl-3 w-full justify-center'
                      span.rounded-sm.font-medium.text-sm class='px-2 py-0.5 bg-[#c0c3a1]/50'
                        | {{_p.ui.currency}}

                  div [
                    class="group-hover:bg-amber-100"
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='flex items-center'
                    class='whitespace-nowrap'
                    class=''
                  ]
                    div class='inline-flex px-3 w-full justify-end'
                      span.font-mono.font-medium: | {{_p.ui.total}}

                  div [
                    class="group-hover:bg-amber-100"
                    class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                    class='flex items-center'
                    class='whitespace-nowrap'
                    class=''
                  ]
                    div class='px-3 py-1.5 w-full'
                      = if (not _p.val.total)
                        % FaIcon @prefix='fas' @size='1x' @icon='minus' @transform='grow-0' class='text-neutral-300'
                      = else
                        = if (eq _p.val.status 'paid')
                          a [
                            class='bg-white'
                            class='w-full justify-center border font-medium border-green-500 hover:bg-green-50 hover:pointer inline-flex mutambo-focus-sky px-2 py-1 rounded-md shadow-sm text-sm text-green-700 items-center'
                            href='{{_p.ui.link}}'
                            role='link'
                            tabindex='0'
                          ]
                            % FaIcon @prefix='fas' @size='1x' @icon='check' @transform='grow-0' class='text-green-500'
                            span.ml-1.mr-1: | Paid
                        = else if (eq _p.val.status 'refunded')
                          a [
                            class='w-full justify-center border font-medium border-red-500 hover:bg-red-50 hover:pointer inline-flex mutambo-focus-sky px-2 py-1 rounded-md shadow-sm text-sm text-red-700 items-center'
                            href='{{_p.ui.link}}'
                            role='link'
                            tabindex='0'
                          ]
                            % FaIcon @prefix='fas' @size='1x' @icon='rotate-left' @transform='grow-0' class='text-red-500'
                            span.ml-1.mr-1: | Refunded
                        = else
                          a [
                            class='w-full justify-center bg-green-500 border border-transparent font-medium hover:border-green-600 hover:pointer inline-flex mutambo-focus-sky px-2 py-1 rounded-md shadow-sm text-sm text-white'
                            href='{{_p.ui.link}}'
                            role='link'
                            tabindex='0'
                          ]
                            span.mr-1.ml-1: | View

                  / div [
                  /   class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  /   class='flex items-center'
                  /   class='whitespace-nowrap'
                  /   class=''
                  / ]
                  /   = if (eq _p.val.status 'paid')
                  /     div class='pr-3 py-1.5 w-full'
                  /       a [
                  /         class='w-full justify-center border font-medium border-red-500 hover:bg-red-50 hover:pointer inline-flex mutambo-focus-sky px-2 py-1 rounded-md shadow-sm text-sm text-red-700 items-center h-8 w-8'
                  /         href='{{_p.ui.link}}'
                  /         role='link'
                  /         tabindex='0'
                  /       ]
                  /         % FaIcon @prefix='fas' @size='lg' @icon='rotate-left' @transform='grow-0' class='text-red-700'

          .flex
            = if model.payments.prev
              % LinkTo [
                @route='app.league.season.payments'
                @query={hash league_id=model.league.meta.id season_id=model.season.meta.id c=model.payments.prev.meta.id p='page-end' }
                class='bg-white border border-neutral-300 flex h-[37px] hover:pointer hover:text-neutral-700 hover:bg-neutral-100 items-center justify-center mutambo-focus-sky no-underline rounded-md shadow-sm text-neutral-600 w-[37px]'
                role='link'
                tabindex='0'
              ]
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-left'
            = else
              div class='bg-white border border-neutral-200 flex h-[37px] items-center justify-center no-underline rounded-md shadow-sm text-neutral-300 w-[37px]'
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-left'

            = if model.payments.next
              % LinkTo [
                @route='app.league.season.payments'
                @query={hash league_id=model.league.meta.id season_id=model.season.meta.id c=model.payments.next.meta.id p='page-start' }
                class='bg-white border border-neutral-300 flex h-[37px] hover:pointer hover:text-neutral-700 hover:bg-neutral-100 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-md shadow-sm text-neutral-600 w-[37px]'
                role='link'
                tabindex='0'
              ]
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-right'
            = else
              div class='bg-white border border-neutral-200 flex h-[37px] items-center justify-center no-underline rounded-md shadow-sm ml-2 text-neutral-300 w-[37px]'
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-right'

