= page-title (get this 'title_string') replace=true separator=' → '

.min-w-screen.min-h-screen
  .flex.flex-col.justify-between.w-screen.min-h-screen

    % TopNav @isLoggedIn=model.isLoggedIn @compact=true

    .flex.w-full.bg-white
      .flex.flex-col.p-8.w-full

        .flex.justify-center.items-center.pb-20
          = if model.standings.league.val.logo_url
            .text-2xl.flex.items-center.h-16.w-16.rounded-lg.mr-2.border.border-neutral-200.overflow-hidden.shadow-xs
              img.object-contain src='{{model.standings.league.val.logo_url}}' alt='League Logo'
          .h-6.text-2xl.flex.items-center.font-medium
            = or model.standings.league.val.name 'League'
            |  →{{' '}}
            = or model.standings.season.val.name 'Season'
            |  → Standings

        = if (not (get model 'standings.standings.val.divisions'))
          p.pb-2.italic.text-neutral-500 This season doesn't have any standings.
          p.pb-2.italic.text-neutral-500 All of this season's standings will show up here.

        = if (get model 'standings.standings.val.divisions.length')
          .grid.mb-7.gap-6 class='grid-cols-auto-fill-300'
            = each (get model 'standings.standings.val.divisions') as |division|
              div [
                class='border border-neutral-200'
                class='h-full'
                class='sm:rounded-sm'
              ]
                div [
                  class='w-full'
                  class="grid grid-cols-[auto_auto_auto_auto_auto_auto_auto_auto_auto_1fr]"
                ]

                  h3.col-span-10.bg-neutral-100.px-2.py-1.border-b.border-neutral-200.font-medium {{division.val.name}}

                  span.flex.font-medium class='pl-2 pr-[4px] py-[1px]' Pts
                  span.flex.font-medium class='px-[4px] py-[1px]'
                  span.flex.font-medium class='px-[4px] py-[1px]' W
                  span.flex.font-medium class='px-[4px] py-[1px]' L
                  span.flex.font-medium class='px-[4px] py-[1px]' T
                  span.flex.font-medium class='px-[4px] py-[1px]'
                  span.flex.font-medium class='px-[4px] py-[1px]' GF
                  span.flex.font-medium class='px-[4px] py-[1px]' GA
                  span.flex.font-medium class='px-[4px] py-[1px]'
                  span.flex.font-medium class='pr-2 pl-[4px] py-[1px]' Team

                  = each division.val.standings as |standing index|
                    span.flex.justify-center class='pl-2 pr-[4px] py-[1px]' class="{{if (eq (mod index 2) 0) 'bg-neutral-50'}}" {{standing.val.points}}
                    span.flex class="{{if (eq (mod index 2) 0) 'bg-neutral-50'}}"
                    span.flex.justify-center class='px-[4px] py-[1px]' class="{{if (eq (mod index 2) 0) 'bg-neutral-50'}}" {{standing.val.wins}}
                    span.flex.justify-center class='px-[4px] py-[1px]' class="{{if (eq (mod index 2) 0) 'bg-neutral-50'}}" {{standing.val.losses}}
                    span.flex.justify-center class='px-[4px] py-[1px]' class="{{if (eq (mod index 2) 0) 'bg-neutral-50'}}" {{standing.val.ties}}
                    span.flex class="{{if (eq (mod index 2) 0) 'bg-neutral-50'}}"
                    span.flex.justify-center class='px-[4px] py-[1px]' class="{{if (eq (mod index 2) 0) 'bg-neutral-50'}}" {{standing.val.goals_for}}
                    span.flex.justify-center class='px-[4px] py-[1px]' class="{{if (eq (mod index 2) 0) 'bg-neutral-50'}}" {{standing.val.goals_against}}
                    span.flex class="{{if (eq (mod index 2) 0) 'bg-neutral-50'}}"
                    span.flex.whitespace-nowrap.overflow-hidden.text-ellipsis class='pr-2 pl-[4px] py-[1px]' class="{{if (eq (mod index 2) 0) 'bg-neutral-50'}}" {{standing.val.team.val.name}}



    div
    div
    div

  % Footer






