= page-title (get this 'title_string') replace=true separator=' → '

.min-w-screen.min-h-screen
  .flex.flex-col.justify-between.w-screen.min-h-screen

    % TopNav @isLoggedIn=model.isLoggedIn @compact=true

    .flex.w-full.bg-white.border-b.border-neutral-200
      .flex.flex-col.p-8.w-full

        .flex.justify-center.items-center.pb-20
          = if model.schedule.league.val.logo_url
            .text-2xl.flex.items-center.h-16.w-16.rounded-lg.mr-2.border.border-neutral-200.overflow-hidden.shadow-xs
              img.object-contain src='{{model.schedule.league.val.logo_url}}' alt='League Logo'
          .h-6.text-2xl.flex.items-center.font-medium
            = or model.schedule.league.val.name 'League'
            |  →{{' '}}
            = or model.schedule.season.val.name 'Season'
            |  → Games

        = if (not model.schedule.games.length)
          p.pb-2.italic.text-neutral-500 This season doesn't have any games.
          p.pb-2.italic.text-neutral-500 All of this season's games will show up here.

        = if (not (not model.schedule.games.length))
          .flex.mb-7
            = if (not (eq model.schedule.start.meta.id model.schedule.first.meta.id))
              % LinkTo [
                @route='schedule'
                @query={hash season_id=model.schedule.season.meta.id end_before=model.schedule.start.meta.id search_at=null start_after=null}
                class='bg-white border border-neutral-300 flex h-[37px] hover:pointer hover:text-neutral-700 hover:bg-neutral-100 items-center justify-center mutambo-focus-sky no-underline rounded-md shadow-sm text-neutral-600 w-[37px]'
                role='link'
                tabindex='0'
              ]
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-left'
            = else
              div class='bg-white border border-neutral-200 flex h-[37px] items-center justify-center no-underline rounded-md shadow-sm text-neutral-300 w-[37px]'
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-left'

            = if (not (eq model.schedule.end.meta.id model.schedule.last.meta.id))
              % LinkTo [
                @route='schedule'
                @query={hash season_id=model.schedule.season.meta.id end_before=null search_at=null start_after=model.schedule.end.meta.id}
                class='bg-white border border-neutral-300 flex h-[37px] hover:pointer hover:text-neutral-700 hover:bg-neutral-100 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-md shadow-sm text-neutral-600 w-[37px]'
                role='link'
                tabindex='0'
              ]
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-right'
            = else
              div class='bg-white border border-neutral-200 flex h-[37px] items-center justify-center no-underline rounded-md shadow-sm ml-2 text-neutral-300 w-[37px]'
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-right'

            .ml-2
              .flex.rounded-md.shadow-sm
                .relative.flex.items-stretch.flex-grow class='focus-within:z-10'
                  % Input @type='text' @value=search_text class='form-input block w-full rounded-none rounded-l-md border border-neutral-300 mutambo-focus-sky' placeholder='YYYY-MM-DD'
                button{on 'click' (fn this.searchGo game.meta.id)} class='-ml-px relative inline-flex items-center space-x-2 px-4 py-2 border border-neutral-300 font-medium rounded-r-md text-neutral-700 bg-neutral-50' class='hover:bg-neutral-100 mutambo-focus-sky' role='button' tabindex='0'
                  span Go



          div [
            class='border border-neutral-200'
            class='overflow-x-auto'
            class='w-full'
            class='mb-7'
          ]
            div [
              class='grid grid-cols-[auto_auto_auto_auto_auto_auto_1fr_auto]'
              class='sm:rounded-sm'
            ]
              div.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3.py-3 Date
              div.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3.py-3 Time
              div.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3.py-3 Home
              div.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3.py-3 Score
              div.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3.py-3 Away
              div.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3.py-3 Division
              div.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3.py-3 Location
              div.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3.py-3 Ext. ID

              = each model.schedule.games as |game index|
                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center'
                  class='relative'
                  class='whitespace-nowrap'
                ]
                  div class='relative px-3 py-3 w-full'
                    span class='relative' {{get game 'ui.date_formatted'}}

                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center'
                  class='relative'
                  class='whitespace-nowrap'
                ]
                  div class='relative px-3 py-3 w-full'
                    span class='relative' {{get game 'ui.time_formatted'}}

                / .flex.justify-center.items-center.px-3 class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                /   = if (eq (get game 'val.canceled') true)
                /     span class='inline-flex items-center items-center px-2 py-1 rounded-sm text-sm font-medium bg-red-100 border border-red-200 uppercase'
                /       % FaIcon @icon='exclamation-triangle' @prefix='fas' @size='1x' @transform='grow-2' class='text-red-700'
                /       span.ml-2.text-red-700 Canceled
                /   = else
                /     button [
                /       class='bg-white border border-neutral-200 flex h-[30px] hover:bg-neutral-100 hover:pointer hover:text-neutral-700 items-center justify-center mutambo-focus-sky no-underline rounded-full shadow-sm text-neutral-500 w-[30px]' role='button' tabindex='0'
                /     ]
                /       .flex.justify-center.items-center
                /         % FaIcon @prefix='fas' @size='1x' @transform='shrink-1' @icon='exclamation-triangle' class='relative top-[-1px]'

                .flex.px-3.items-center.py-3.border-r.border-dotted.whitespace-nowrap class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}" = get game 'val.home_team.val.name'


                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center'
                  class='relative'
                  class='whitespace-nowrap'
                ]
                  div class='flex relative w-full'

                    .flex.font-black.justify-end.items-center.py-3 class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}" class='w-[26px] mr-[3px] ml-[2px]'
                      = get game 'val.score.home'

                    .flex.justify-start.items-center.pt-px class='w-[8px]' class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                      .text-neutral-900 class="{{if (lte (get game 'val.score.home') (get game 'val.score.away')) 'opacity-0'}}"
                        % FaIcon @prefix='fas' @size='1x' @icon='caret-left' @transform='shrink-0'

                    .flex.justify-end.items-center.pt-px class='w-[8px]' class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                      .text-neutral-900 class="{{if (gte (get game 'val.score.home') (get game 'val.score.away')) 'opacity-0'}}"
                        % FaIcon @prefix='fas' @size='1x' @icon='caret-right' @transform='shrink-0'

                    .flex.font-black.justify-start.items-center.py-3 class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}" class='w-[26px] ml-[3px] mr-[2px]'
                      = get game 'val.score.away'

                .flex.px-3.py-3.items-center.border-l.border-dotted.whitespace-nowrap class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}" = get game 'val.away_team.val.name'

                .flex.px-3.py-3.items-center.whitespace-nowrap class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}" = get game 'val.division.val.name'

                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center'
                  class='relative'
                  class='whitespace-nowrap'
                ]
                  div class='relative px-3 py-3 w-full'
                    span class='relative' {{get game 'val.location_text'}}

                .flex.px-3.py-3.items-center.whitespace-nowrap class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}" = get game 'ext.gameofficials'



          .flex
            = if (not (eq model.schedule.start.meta.id model.schedule.first.meta.id))
              % LinkTo [
                @route='schedule'
                @query={hash season_id=model.schedule.season.meta.id end_before=model.schedule.start.meta.id search_at=null start_after=null}
                class='bg-white border border-neutral-300 flex h-[37px] hover:pointer hover:text-neutral-700 hover:bg-neutral-100 items-center justify-center mutambo-focus-sky no-underline rounded-md shadow-sm text-neutral-600 w-[37px]'
                role='link'
                tabindex='0'
              ]
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-left'
            = else
              div class='bg-white border border-neutral-200 flex h-[37px] items-center justify-center no-underline rounded-md shadow-sm text-neutral-300 w-[37px]'
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-left'

            = if (not (eq model.schedule.end.meta.id model.schedule.last.meta.id))
              % LinkTo [
                @route='schedule'
                @query={hash season_id=model.schedule.season.meta.id end_before=null search_at=null start_after=model.schedule.end.meta.id}
                class='bg-white border border-neutral-300 flex h-[37px] hover:pointer hover:text-neutral-700 hover:bg-neutral-100 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-md shadow-sm text-neutral-600 w-[37px]'
                role='link'
                tabindex='0'
              ]
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-right'
            = else
              div class='bg-white border border-neutral-200 flex h-[37px] items-center justify-center no-underline rounded-md shadow-sm ml-2 text-neutral-300 w-[37px]'
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-right'




    div

  % Footer






