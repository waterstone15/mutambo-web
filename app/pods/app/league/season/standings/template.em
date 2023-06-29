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
            @goto={hash route='app.league.season.standings' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @icon={hash transform='grow-1' icon='chart-simple' class='text-pink-400'}
            @text='Standings'
          ]

        .inline-flex.items-center.justify-end.flex-wrap class='md:h-[48px] py-4 md:py-0 ml-4'
          % LinkTo [
            @query={hash league_id=this.league_id season_id=this.season_id}
            @route='global.standings'
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

      .p-8
        = if (not model.standings.length)
          p.pb-2.italic.text-neutral-500: | This season doesn't have any standings yet.
          p.pb-2.italic.text-neutral-500: | All standings will show up here.

        = else
          .grid.mb-7.gap-6 class='grid-cols-auto-fill-300'
            = each model.standings as |standing|
              div [
                class='border border-neutral-200'
                class='h-full'
                class='rounded-md shadow-sm'
                class='overflow-hidden'
              ]
                div [
                  class='w-full'
                  class="grid grid-cols-[auto_auto_auto_auto_auto_auto_auto_auto_auto_1fr]"
                ]

                  h3.col-span-10.bg-neutral-100.px-3.py-2.border-b.border-neutral-200.font-medium {{standing.val.division.val.name}}

                  span.flex.font-medium class='pl-3 pr-[4px] py-[1px]' Pts
                  span.flex.font-medium class='px-[4px] py-[1px]'
                  span.flex.font-medium class='px-[4px] py-[1px]' W
                  span.flex.font-medium class='px-[4px] py-[1px]' L
                  span.flex.font-medium class='px-[4px] py-[1px]' T
                  span.flex.font-medium class='px-[4px] py-[1px]'
                  span.flex.font-medium class='px-[4px] py-[1px]' GF
                  span.flex.font-medium class='px-[4px] py-[1px]' GA
                  span.flex.font-medium class='px-[4px] py-[1px]'
                  span.flex.font-medium class='pr-3 pl-[4px] py-[1px]' Team

                  = each standing.val.teams as |team index|
                    span.flex.justify-center class='pl-2 pr-[4px] py-[1px]' class="{{if (eq (mod index 2) 0) 'bg-neutral-50'}}" {{team.val.points}}
                    span.flex class="{{if (eq (mod index 2) 0) 'bg-neutral-50'}}"
                    span.flex.justify-center class='px-[4px] py-[1px]' class="{{if (eq (mod index 2) 0) 'bg-neutral-50'}}" {{team.val.wins}}
                    span.flex.justify-center class='px-[4px] py-[1px]' class="{{if (eq (mod index 2) 0) 'bg-neutral-50'}}" {{team.val.losses}}
                    span.flex.justify-center class='px-[4px] py-[1px]' class="{{if (eq (mod index 2) 0) 'bg-neutral-50'}}" {{team.val.ties}}
                    span.flex class="{{if (eq (mod index 2) 0) 'bg-neutral-50'}}"
                    span.flex.justify-center class='px-[4px] py-[1px]' class="{{if (eq (mod index 2) 0) 'bg-neutral-50'}}" {{team.val.gf}}
                    span.flex.justify-center class='px-[4px] py-[1px]' class="{{if (eq (mod index 2) 0) 'bg-neutral-50'}}" {{team.val.ga}}
                    span.flex class="{{if (eq (mod index 2) 0) 'bg-neutral-50'}}"
                    span.flex.whitespace-nowrap.overflow-hidden.text-ellipsis class='pr-3 pl-[4px] py-[1px]' class="{{if (eq (mod index 2) 0) 'bg-neutral-50'}}" {{team.val.name}}

