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
        | {{' → '}}
        | {{or model.season.val.name 'Season'}}
        |  → Standings

    .p-4
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



% Footer
