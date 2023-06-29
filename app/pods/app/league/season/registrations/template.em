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
            @goto={hash route='app.league.season.registrations' query=(hash c=null f_type=null p=null league_id=model.league.meta.id season_id=model.season.meta.id)}
            @icon={hash transform='grow-2' icon='clipboard-list' class='text-stone-400'}
            @text='Registrations'
          ]
        
        / .inline-flex.items-center.justify-end.flex-wrap class='md:h-[48px] py-4 md:py-0 ml-4'
        /   % LinkTo [
        /     @query={hash c=this.c p=this.p fs='type:team,team:team-sdfji234jalsdkf='}
        /     @route='app.league.season.registrations'
        /     class='bg-neutral-50 border border-neutral-200 h-10 hover:bg-neutral-100 hover:cursor-pointer hover:shadow-sm inline-flex items-center mutambo-focus-sky overflow-hidden px-3 rounded-md m-2'
        /     role='link'
        /     tabindex='0'
        /   ]
        /     .inline-flex
        /       % FaIcon [
        /         @prefix='fas'
        /         @size='1x'
        /         @transform='grow-0'
        /         @icon='sliders'
        /         class='text-neutral-900'
        /       ]

        /   % LinkTo [
        /     @query={hash c=this.c p=this.p fs='type:team,team:team-sdfji234jalsdkf='}
        /     @route='app.league.season.registrations'
        /     class='bg-neutral-50 border border-neutral-200 h-10 hover:bg-neutral-100 hover:cursor-pointer hover:shadow-sm inline-flex items-center mutambo-focus-sky overflow-hidden px-3 rounded-md m-2'
        /     role='link'
        /     tabindex='0'
        /   ]
        /     .inline-flex
        /       % FaIcon [
        /         @prefix='fas'
        /         @size='1x'
        /         @transform='grow-0'
        /         @icon='magnifying-glass'
        /         class='text-neutral-900'
        /       ]

        /   % LinkTo [
        /     @query={hash c=this.c p=this.p fs='type:team,team:team-sdfji234jalsdkf='}
        /     @route='app.league.season.registrations'
        /     class='bg-neutral-50 border border-neutral-200 h-10 hover:bg-neutral-100 hover:cursor-pointer hover:shadow-sm inline-flex items-center mutambo-focus-sky overflow-hidden px-3 rounded-md m-2'
        /     role='link'
        /     tabindex='0'
        /   ]
        /     .inline-flex
        /       % FaIcon [
        /         @prefix='fas'
        /         @size='1x'
        /         @transform='grow-0'
        /         @icon='arrow-up-from-bracket'
        /         class='text-neutral-900'
        /       ]



      .p-8
        / .border.border-neutral-100.mb-8.bg-neutral-50
        /   h4.font-bold: | Filters
        /   p: | The quick brown fox jumped over a lazy dog. The quick brown fox jumped over a lazy dog. The quick brown fox jumped over a lazy dog. The quick brown fox jumped over a lazy dog. The quick brown fox jumped over a lazy dog. The quick brown fox jumped over a lazy dog. The quick brown fox jumped over a lazy dog. The quick brown fox jumped over a lazy dog. The quick brown fox jumped over a lazy dog. 


        = if (not model.registrations.page.items.length)
          p.pb-2.italic.text-neutral-500: | You don't have any registrations.
          p.pb-2.italic.text-neutral-500: | All of your registrations will show up here.

        = else
          div [
            class='border border-neutral-200'
            class='overflow-x-auto'
            class='w-full'
            class='mb-7'
          ]
            div [
              class="grid grid-cols-[auto_auto_auto_auto_1fr_auto_auto_auto]"
              class='sm:rounded-sm'
            ]
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium class='h-[40px]'
                span class='h-[40px] w-full border-r border-neutral-200 border-dashed inline-flex items-center justify-center font-normal px-2'
                  | {{model.registrations.counts.total}}
              .inline-flex.items-center.justify-between.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]'
                .inline-flex: | Type
                .infline-flex.items-center.justify-center class='pl-1.5'
                  button [
                    onclick={action this.toggleTypeFilterBox}
                    class='border border-neutral-700/0 h-8 w-8 hover:bg-white focus:hover:bg-white hover:cursor-pointer hover:shadow-sm inline-flex items-center justify-center mutambo-focus-sky overflow-hidden rounded-md'
                    role='button'
                    tabindex='0'
                  ]
                    % FaIcon [
                      @prefix='fas'
                      @size='1x'
                      @transform='grow-0'
                      @icon='filter'
                      class='text-neutral-900'
                    ]

              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | Team
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | Registrant
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | Notes
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium class='h-[40px]'
              .inline-flex.justify-end.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | Fee
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | Payment



              = each model.registrations.page.items as |_r index|
                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center justify-center'
                  class='border-r border-neutral-200 border-dashed'
                ]
                  div class='px-2 py-2'
                    span: | {{sub model.registrations.counts.total model.registrations.counts.before index}}

                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='inline-flex items-center justify-center'
                  class='whitespace-nowrap'
                  class=''
                ]
                  div class='flex flex-col items-center justify-center px-3 w-full'
                    = if (eq _r.meta.type 'league-season-team')
                      span.inline-flex.justify-center: span class='px-1.5 py-0.5 rounded-sm text-xs font-medium bg-stone-300 uppercase': | Team
                    = if (eq _r.meta.type 'registration/season-team')
                      span.inline-flex.justify-center: span class='px-1.5 py-0.5 rounded-sm text-xs font-medium bg-stone-300 uppercase': | Team
                    = if (eq _r.meta.type 'registration-league-season-team-manager')
                      span.inline-flex.justify-center: span class='px-1.5 py-0.5 rounded-sm text-xs font-medium bg-stone-300 uppercase': | Manager
                    = if (eq _r.meta.type 'registration/team-manager')
                      span.inline-flex.justify-center: span class='px-1.5 py-0.5 rounded-sm text-xs font-medium bg-stone-200 uppercase': | Manager
                    = if (eq _r.meta.type 'registration-league-season-team-player')
                      span.inline-flex.justify-center: span class='px-1.5 py-0.5 rounded-sm text-xs font-medium bg-stone-200 uppercase': | Player
                    = if (eq _r.meta.type 'registration/team-player')
                      span.inline-flex.justify-center: span class='px-1.5 py-0.5 rounded-sm text-xs font-medium bg-stone-200 uppercase': | Player
                    = if (eq _r.val.status 'canceled')
                      span.inline-flex.justify-center.mt-1: span class='px-1.5 py-0.5 rounded-sm text-xs font-medium bg-red-100 uppercase': | Canceled

                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center'
                  class='py-1'
                  class='max-w-[200px]'
                ]
                  div class='px-3 w-full'
                    span: | {{_r.val.team.val.name}}

                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center'
                  class='overflow-x-auto'
                  class='w-[300px] py-1'
                ]
                  div class='inline-flex px-3 w-full flex-col justify-start items-start'
                    span: | {{_r.val.registrant.val.full_name}}
                    span.text-neutral-400.font-light.italic: | {{_r.val.registrant.val.email}}
                    / a [
                    /   class='justify-center items-center bg-white border border-neutral-200 font-medium hover:border-neutral-300 hover:pointer inline-flex mutambo-focus-sky h-[32px] w-[32px] rounded-full shadow-sm text-neutral-600 hover:text-neutral-900'
                    /   href='mailto:{{_r.val.registrant.val.email}}'
                    /   role='link'
                    /   tabindex='0'
                    / ]
                    /   % FaIcon @prefix='fas' @size='1x' @icon='envelope' @transform='grow-0'

                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center'
                  class='overflow-x-auto'
                  class='min-w-[300px] py-1'
                ]
                  div class='px-3 w-full space-y-.5'
                    = each _r.ui.notes as |line|
                      p = line

                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='inline-flex items-center'
                  class='whitespace-nowrap'
                  class=''
                ]
                  div class='inline-flex pl-3 w-full justify-center'
                    span.rounded-sm.font-medium.text-sm class='px-2 py-0.5 bg-[#c0c3a1]/50'
                      | {{_r.ui.currency}}

                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center'
                  class='whitespace-nowrap'
                  class=''
                ]
                  div class='inline-flex px-3 w-full justify-end'
                    span.font-mono.font-medium: | {{_r.ui.total}}

                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center'
                  class='whitespace-nowrap'
                  class=''
                ]
                  div class='px-3 py-1.5 w-full'
                    = if (not _r.val.payment.val.total)
                      % FaIcon @prefix='fas' @size='1x' @icon='minus' @transform='grow-0' class='text-neutral-300'
                    = else
                      = if (eq _r.val.payment.val.status 'paid')
                        a [
                          class='w-full justify-center border font-medium border-green-500 hover:bg-green-50 hover:pointer inline-flex mutambo-focus-sky px-2 py-1 rounded-md shadow-sm text-sm text-green-700 items-center h-8'
                          href='{{_r.ui.link}}'
                          role='link'
                          tabindex='0'
                        ]
                          % FaIcon @prefix='fas' @size='1x' @icon='check' @transform='grow-0' class='text-green-500'
                          span.ml-1.mr-1: | Paid
                      = else if (eq _r.val.payment.val.status 'refunded')
                        a [
                          class='w-full justify-center border font-medium border-red-500 hover:bg-red-50 hover:pointer inline-flex mutambo-focus-sky px-2 py-1 rounded-md shadow-sm text-sm text-red-700 items-center h-8'
                          href='{{_r.ui.link}}'
                          role='link'
                          tabindex='0'
                        ]
                          % FaIcon @prefix='fas' @size='1x' @icon='rotate-left' @transform='grow-0' class='text-red-500'
                          span.ml-1.mr-1: | Refunded
                      = else
                        a [
                          class='w-full justify-center bg-green-500 border border-transparent font-medium hover:border-green-600 hover:pointer inline-flex mutambo-focus-sky px-2 py-1 rounded-md shadow-sm text-sm text-white h-8'
                          href='{{_r.ui.link}}'
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
                /   = if (eq _r.meta.type 'registration/season-team')
                /     div class='pr-3 py-1.5 w-full'
                /       a [
                /         class='w-full justify-center border font-medium border-red-500 hover:bg-red-50 hover:pointer inline-flex mutambo-focus-sky px-2 py-1 rounded-md shadow-sm text-sm text-red-700 items-center h-8 w-8'
                /         href='{{_r.ui.link}}'
                /         role='link'
                /         tabindex='0'
                /       ]
                /         % FaIcon @prefix='fas' @size='lg' @icon='xmark' @transform='grow-0' class='text-red-700'
                        

                      


          .flex
            = if model.registrations.prev
              % LinkTo [
                @route='app.league.season.registrations'
                @query={hash league_id=model.league.meta.id season_id=model.season.meta.id c=model.registrations.prev.meta.id p='page-end' }
                class='bg-white border border-neutral-300 flex h-[37px] hover:pointer hover:text-neutral-700 hover:bg-neutral-100 items-center justify-center mutambo-focus-sky no-underline rounded-md shadow-sm text-neutral-600 w-[37px]'
                role='link'
                tabindex='0'
              ]
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-left'
            = else
              div class='bg-white border border-neutral-200 flex h-[37px] items-center justify-center no-underline rounded-md shadow-sm text-neutral-300 w-[37px]'
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-left'

            = if model.registrations.next
              % LinkTo [
                @route='app.league.season.registrations'
                @query={hash league_id=model.league.meta.id season_id=model.season.meta.id c=model.registrations.next.meta.id p='page-start' }
                class='bg-white border border-neutral-300 flex h-[37px] hover:pointer hover:text-neutral-700 hover:bg-neutral-100 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-md shadow-sm text-neutral-600 w-[37px]'
                role='link'
                tabindex='0'
              ]
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-right'
            = else
              div class='bg-white border border-neutral-200 flex h-[37px] items-center justify-center no-underline rounded-md shadow-sm ml-2 text-neutral-300 w-[37px]'
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-right'

  = if this.show_type_filter_box
    .fixed.flex.justify-center.items-center.w-screen.h-screen.bg-opacity-75.bg-neutral-500.z-10.top-0.left-0.p-8 class='md:p-0'
      .p-8.bg-white.border.border-neutral-100.shadow-lg.rounded-lg.w-full class='md:w-96 md:m-0'

        .flex.items-center.justify-between.pb-6.border-b.border-neutral-100.mb-7
          .inline-flex.items-start.mr-2.space-x-2
            .inline: | Filter:
            .inline.font-bold: | Type

          .flex.items-center.justify-center
            button [
              onclick={action this.toggleTypeFilterBox}
              class='flex justify-center items-center'
              class='hover:bg-neutral-50 text-neutral-900 hover:text-black'
              class='border border-neutral-700/20 h-8 w-8 focus:hover:bg-white hover:cursor-pointer shadow-sm inline-flex items-center justify-center mutambo-focus-sky rounded-md'
              class='w-8 h-8'
              type='button'
            ]
              % FaIcon @fixedWidth=true @icon='times' @prefix='fas' @size='1x' @transform='shrink-0'

        .space-y-6
          div
            / label.flex.items-center.justify-between.font-medium for='filter-type': | Show
            / .mt-1.relative.rounded-md
            /   div
            .mt-1.block.w-full.rounded-md.border-neutral-300
              .mt-2
                div
                  label.inline-flex.items-center class='cursor-pointer mb-2'
                    input{on 'input' (fn this.formValueChanged 'filter_type' 'all')} checked={eq this.form.values.filter_type 'all'} type='radio' name='radio-direct' class='form-radio border-neutral-300 text-sky-600 shadow-sm focus:border-sky-300 focus:ring focus:ring-offset-0 focus:ring-sky-200 focus:ring-opacity-50' value=form.values.filter_type
                    span.ml-2: | All
                  div
                  label.inline-flex.items-center class='cursor-pointer mb-2'
                    input{on 'input' (fn formValueChanged 'filter_type' 'registration/season-team')} checked={eq form.values.filter_type 'registration/season-team'} type='radio' name='radio-direct' class='form-radio border-neutral-300 text-sky-600 shadow-sm focus:border-sky-300 focus:ring focus:ring-offset-0 focus:ring-sky-200 focus:ring-opacity-50' value=form.values.filter_type
                    span.ml-2: | Team
                  div
                  label.inline-flex.items-center class='cursor-pointer mb-2'
                    input{on 'input' (fn formValueChanged 'filter_type' 'registration/team-manager')} checked={eq form.values.filter_type 'registration/team-manager'} type='radio' name='radio-direct' class='form-radio border-neutral-300 text-sky-600 shadow-sm focus:border-sky-300 focus:ring focus:ring-offset-0 focus:ring-sky-200 focus:ring-opacity-50' value=form.values.filter_type
                    span.ml-2: | Manager
                  div
                  label.inline-flex.items-center class='cursor-pointer mb-2'
                    input{on 'input' (fn formValueChanged 'filter_type' 'registration/team-player')} checked={eq form.values.filter_type 'registration/team-player'} type='radio' name='radio-direct' class='form-radio border-neutral-300 text-sky-600 shadow-sm focus:border-sky-300 focus:ring focus:ring-offset-0 focus:ring-sky-200 focus:ring-opacity-50' value=form.values.filter_type
                    span.ml-2: | Player

          div.pt-8
            button [
              onclick={action setFilterType}
              class='w-full flex justify-center py-2 px-4 border border-transparent rounded-md font-medium mutambo-focus-sky-dark shadow-sm text-white bg-sky-600 hover:bg-sky-700'
              role='button'
              tabindex='0'
            ]
              | Confirm