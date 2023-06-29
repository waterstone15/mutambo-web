= page-title title_string replace=true


div class='min-h-screen flex flex-col'
  
  .flex.flex-col.w-full

    % TopNav @isLoggedIn=model.user @compact=true

    .flex.justify-center.items-center.pt-10.pb-20.px-4
      = if model.league.val.logo_url
        .text-2xl.flex.items-center.h-16.w-16.rounded-lg.mr-2.border.border-neutral-200.overflow-hidden.shadow-xs
          img.object-contain src='{{model.league.val.logo_url}}' alt='League Logo'
      .h-6.text-2xl.flex.items-center.font-medium
        | {{or model.league.val.name 'League'}}
        |  →{{' '}}
        | {{or model.season.val.name 'Season'}}
        |  → Games

    .p-4
      = if (not model.games.counts.total)
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
            class="grid grid-cols-[auto_auto_auto_auto_auto_auto_auto_auto_auto_auto_1fr_auto_auto]"
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
            .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-2 class='h-[40px]': span: | Ext. ID
            .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-2 class='h-[40px]'

            = each model.games.page.items as |_g index|
              div [
                class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                class='flex items-center justify-center'
                class='border-r border-neutral-200 border-dashed'
              ]
                div class='px-2 py-2'
                  span: | {{add model.games.counts.before index 1}}

              = if _g.val.canceled
                div [
                  class='group-hover:bg-amber-100'
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center justify-center'
                  class='py-1'
                  class='col-start-2 col-end-5'
                ]
                  div class='mx-2 rounded border border-red-600 bg-white'
                    .inline-flex.font-medium.text-sm class='px-2 py-1 bg-red-600/10': | CANCELED
              = else
                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center'
                  class='py-1'
                  class=''
                ]
                  div class='px-2 font-mono text-sm'
                    span.whitespace-nowrap: | {{_g.ui.date}}

                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center'
                  class='py-1'
                  class=''
                ]
                  div class='px-2 font-mono text-sm'
                    span.whitespace-nowrap: | {{_g.ui.time}}

                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center'
                  class='py-1'
                  class=''
                ]
                  div class='px-2 font-mono text-sm'
                    span.text-neutral-400: | {{_g.ui.zone}}

              div [
                class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                class='flex items-center'
                class='py-1'
                class=''
              ]
                div class='px-2 w-full'
                  span: | {{_g.val.home_team.val.name}}

              div [
                class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                class='flex items-center justify-end'
                class='py-1 '
                class='font-black'
                class='pl-3 pr-[2px]'
              ]
                | {{get _g 'val.score.home'}}

              div [
                class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                class='flex items-center justify-end'
                class='py-1 '
                class='font-black'
                class=''
              ]
                % FaIcon @prefix='fas' @size='1x' @icon='caret-left' @transform='shrink-0' class="{{if (lte (get _g 'val.score.home') (get _g 'val.score.away')) 'opacity-0'}}"

              div [
                class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                class='flex items-center justify-end'
                class='py-1 '
                class='font-black'
                class=''
              ]
                % FaIcon @prefix='fas' @size='1x' @icon='caret-right' @transform='shrink-0' class="{{if (gte (get _g 'val.score.home') (get _g 'val.score.away')) 'opacity-0'}}"

              div [
                class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                class='flex items-center justify-start'
                class='py-1 '
                class='font-black'
                class='pl-[2px] pr-3'
              ]
                | {{get _g 'val.score.away'}}

              div [
                class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                class='flex items-center justify-start'
                class='py-1'
                class=''
              ]
                div class='px-2'
                  span: | {{_g.val.away_team.val.name}}

              div [
                class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                class='flex items-center justify-start'
                class='py-1'
                class=''
              ]
                div class='px-2'
                  span: | {{_g.val.location_text}}

              div [
                class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                class='flex items-center justify-start'
                class='py-1'
                class=''
              ]
                div class='px-2'
                  span: | {{_g.ext.gameofficials}}

              div [
                class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                class='flex items-center justify-end'
                class='py-1'
                class=''
              ]
                div class='px-2'
                  span: | {{_g.val.player_count}}

        .flex.pb-20
          = if model.games.prev
            % LinkTo [
              @route='global.games'
              @query={hash season_id=model.season.meta.id c=model.games.prev.meta.id p='page-end' }
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
              @route='global.games'
              @query={hash season_id=model.season.meta.id c=model.games.next.meta.id p='page-start' }
              class='bg-white border border-neutral-300 flex h-[37px] hover:pointer hover:text-neutral-700 hover:bg-neutral-100 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-md shadow-sm text-neutral-600 w-[37px]'
              role='link'
              tabindex='0'
            ]
              % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-right'
          = else
            div class='bg-white border border-neutral-200 flex h-[37px] items-center justify-center no-underline rounded-md shadow-sm ml-2 text-neutral-300 w-[37px]'
              % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-right'
        

% Footer
