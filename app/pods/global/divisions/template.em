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
        |  → Divisions

    .p-4
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
                    li.px-2.py-1.rounded.flex.flex-row
                      .inline-flex.items-center.font-medium: | {{_t.val.name}}

% Footer
