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
            @goto={hash route='app.league.season.divisions' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @icon='divisions'
            @text='Divisions'
          ]

        .inline-flex.items-center.justify-end.flex-wrap class='md:h-[48px] py-4 md:py-0 ml-4'
          % LinkTo [
            @query={hash season_id=this.season_id}
            @route='global.divisions'
            class='bg-neutral-50 border border-neutral-200 h-10 hover:bg-neutral-100 hover:cursor-pointer hover:shadow-sm inline-flex items-center mutambo-focus-sky overflow-hidden px-3 rounded-md m-2'
            role='link'
            tabindex='0'
          ]
            .inline-flex
              % FaIcon [
                @prefix='fas'
                @size='1x'
                @transform='grow-0'
                @icon='earth-americas'
                class='text-neutral-900'
              ]

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
        = if (not model.divisions.length)
          p.pb-2.italic.text-neutral-500: | This season doesn't have any divisions yet.
          p.pb-2.italic.text-neutral-500: | All divisions will show up here.

        = else
          .player-card-grid.grid.gap-2
            = each model.divisions as |_d|
              .flex.flex-col.border.border-neutral-200.rounded-md.shadow-sm.overflow-hidden
                .flex.items-center.border-b.border-neutral-200.bg-neutral-100
                  .flex.font-bold.my-2.mx-4: | {{_d.val.name}}
                .about-box.flex.px-2.py-2.flex-grow.flex-col.justify-between
                  ul
                    = each _d.val.teams as |_t|
                      li.px-2.py-1.rounded.flex.flex-row.justify-between class='hover:bg-neutral-50'
                        .inline-flex.items-center.font-medium: | {{_t.val.name}}
                        .infline-flex.items-center.justify-center class='pl-1.5'
                          button [
                            class='border border-neutral-700/0 h-8 w-8 hover:bg-white focus:hover:bg-white hover:cursor-pointer hover:shadow-sm inline-flex items-center justify-center mutambo-focus-sky overflow-hidden rounded-md'
                            role='button'
                            tabindex='0'
                            onclick={action toggleChangeDivisionBox _t.meta.id _d.meta.id}
                          ]
                            % FaIcon [
                              @prefix='fas'
                              @size='1x'
                              @transform='shrink-1'
                              @icon='right-left'
                              class='text-neutral-900'
                            ]

  = if show_change_division_box
    .fixed.flex.justify-center.items-center.w-screen.h-screen.bg-opacity-75.bg-neutral-500.z-10.top-0.left-0.p-8 class='md:p-0'
      .p-8.bg-white.border.border-neutral-100.shadow-lg.rounded-lg.w-full class='md:w-96 md:m-0'

        .flex.items-center.justify-between.pb-6.border-b.border-neutral-100.mb-7
          .flex.flex-col.items-start.mr-2
            .inline-flex.font-bold: | {{form.values.team.val.name}}

          .flex.items-center.justify-center
            button [
              onclick={action toggleChangeDivisionBox}
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
                  = each model.divisions as |_d|
                    label.inline-flex.items-center class='cursor-pointer mb-2'
                      input{on 'input' (fn formValueChanged 'division' _d)} checked={eq form.values.division.meta.id _d.meta.id} type='radio' name='radio-direct' class='form-radio border-neutral-300 text-sky-600 shadow-sm focus:border-sky-300 focus:ring focus:ring-offset-0 focus:ring-sky-200 focus:ring-opacity-50' value=form.values.division.meta.id
                      span.ml-2: | {{_d.val.name}}
                    div

          div.pt-8
            button [
              onclick={action setDivision}
              class='w-full flex justify-center py-2 px-4 border border-transparent rounded-md font-medium mutambo-focus-sky-dark shadow-sm text-white bg-sky-600 hover:bg-sky-700'
              role='button'
              tabindex='0'
            ]
              | Confirm