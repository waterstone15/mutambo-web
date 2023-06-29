= page-title (get this 'title_string') replace=true separator=' → '

div class='min-h-screen flex flex-col md:flex-row'

  % AppNav [
    @league=model.league
    @leagues=model.leagues
    @season=model.season
    @seasons=model.seasons
    @user=model.user
  ]

  .flex.w-full
    .flex.flex-col.px-8.pb-8.w-full

      .flex.justify-between.items-center.border-b.border-neutral-100 class='mb-[20px] pt-[26px] pb-[17px]'
        .flex
          = if this.model.league.val.logo_url
            .h-6.flex.items-center.w-6.rounded.mr-2.border.border-neutral-100.overflow-hidden
              img.object-contain src='{{this.model.league.val.logo_url}}' alt='League Logo'
          .h-6.flex.items-center.font-bold
            = or this.model.league.val.name 'League'
            |  →{{' '}}
            = or this.model.season.val.name 'Season'
            |  → Divisions
        .flex class='w-[30px] h-[30px]'
          / % LinkTo [
          /   @route='app'
          /   class='transparent bg-white border border-neutral-200 flex hover:bg-neutral-100 hover:border-neutral-300 hover:pointer hover:text-neutral-700 items-center justify-center ml-2 no-underline rounded-md shadow-sm text-neutral-500 px-3 w-[32px] h-[32px] mutambo-focus-sky'
          /   role='button'
          /   tabindex='0'
          / ]
          /   % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='plus'

      = if (not (get this 'model.divisions.length'))
        p.pb-2.italic.text-neutral-500 This season doesn't have any divisions.
        p.pb-2.italic.text-neutral-500 All of this season's divisions will show up here.

      = if (get this 'model.divisions.length')
        .overflow-x-auto.mb-7
          .align-middle.inline-block.min-w-full
            .overflow-hidden.border.border-neutral-200 class='sm:rounded-sm'
              table.min-w-full.divide-y.divide-neutral-200
                thead.bg-neutral-100
                  tr
                    th.px-3.py-2.text-left.font-medium.w-6
                    th.px-3.py-2.text-left.font-medium Name
                tbody
                  = each (get this 'model.divisions') as |division index|
                    tr class='even:bg-neutral-50'
                      td.py-2.whitespace-nowrap.text-neutral-900.group.align-top: span.px-3 {{add index 1}}.
                      td.py-2.whitespace-nowrap.text-neutral-900.group.align-top: span.px-3 {{division.val.name}}










