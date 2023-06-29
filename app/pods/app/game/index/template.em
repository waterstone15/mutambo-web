= page-title 'Games - Mutambo' replace=true separator=' → '

div class='min-h-screen flex flex-col md:flex-row'

  % AppNav [
    @leagues=model.leagues
    @user=model.user
  ]

  .flex.w-full
    .flex.flex-col.p-8.w-full
      .flex.justify-between.items-center.border-b.border-neutral-100.mb-8
        h2.flex.font-bold style='padding-top: 2px; padding-bottom: 21px;' Game

      .flex.items-center class='h-[37px]'
        .font-medium.text-neutral-900 Home Team
      .flex.flex-col.pb-5
        p.pb-2.text-neutral-800 {{if (get model 'game.val.home_team.val.name') model.game.val.home_team.val.name '–'}}
        = if (get model 'game.val.is_manager')
          .block.mb-2.mt-1
            div class='block float-left px-1.5 py-0.5 rounded-sm text-xs font-medium bg-purple-100 uppercase' Managers
          .grid.gap-y-1.gap-x-2 class='grid-cols-[auto_auto_auto_1fr]'
            = each (get model 'game.val.home_managers') as |manager|
              span.pl-2.pr-1.font-bold {{'•'}}
              span {{manager.val.display_name}}
              span.text-neutral-400 {{manager.val.email}}
              span

      .flex.items-center class='h-[37px]'
        .font-medium.text-neutral-900 Away Team
      .flex.flex-col.pb-5
        p.pb-2.text-neutral-800 {{if (get model 'game.val.away_team.val.name') model.game.val.away_team.val.name '–'}}
        = if (get model 'game.val.is_manager')
          .block.mb-2.mt-1
            div class='block float-left px-1.5 py-0.5 rounded-sm text-xs font-medium bg-purple-100 uppercase' Managers
          .grid.gap-y-1.gap-x-2 class='grid-cols-[auto_auto_auto_1fr]'
            = each (get model 'game.val.away_managers') as |manager|
              span.pl-2.pr-1.font-bold {{'•'}}
              span {{manager.val.display_name}}
              span.text-neutral-400 {{manager.val.email}}
              span

      .flex.items-center class='h-[37px]'
        .font-medium.text-neutral-900 Date • Time
      .flex.pb-5
        p.pb-2.text-neutral-800
          | {{if (get model 'game.ui.date_formatted') model.game.ui.date_formatted '–'}}
          span.px-2 {{'•'}}
          | {{if (get model 'game.ui.time_formatted') model.game.ui.time_formatted '–'}}


      .flex.items-center class='h-[37px]'
        .font-medium.text-neutral-900 Score
      .flex.pb-5
        .grid.grid-cols-2.gap-x-3.gap-y-1.border.border-neutral-200.py-1.px-2
          .flex.justify-center.uppercase.font-normal.text-neutral-500 Home
          .flex.justify-center.uppercase.font-normal.text-neutral-500 Away
          .flex.justify-center.font-black {{if (get model 'game.val.score.home') model.game.val.score.home '-'}}
          .flex.justify-center.font-black {{if (get model 'game.val.score.away') model.game.val.score.away '-'}}

      .flex.items-center class='h-[37px]'
        .font-medium.text-neutral-900 Location
      .flex.pb-5
        p.pb-2.text-neutral-800 {{if (get model 'game.val.location_text') model.game.val.location_text '–'}}

      .flex.items-center class='h-[37px]'
        .font-medium.text-neutral-900 Ext. ID
      .flex.pb-5
        p.pb-2.text-neutral-800 {{if (get model 'game.ext.gameofficials') model.game.ext.gameofficials '–'}}

