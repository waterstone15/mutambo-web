= page-title 'Seasons - Mutambo' replace=true separator=' → '

div class='min-h-screen flex flex-col md:flex-row'

  % AppNav [
    @isLoggedIn=this.model.isLoggedIn
    @leagues=this.model.leagues
    @user=this.model.user
  ]

  .flex.w-full
    .flex.flex-col.p-8.w-full
      .flex.justify-between.items-center.border-b.border-neutral-100.mb-7 style='padding-bottom: 17px;'
        h2.flex.font-bold.pb-1 Seasons

      = if (not (get this 'model.seasons.length'))
        p.pb-2.italic.text-neutral-500 You don't have any seasons.
        p.pb-2.italic.text-neutral-500 All of your seasons will show up here.

      = else
        .grid-cols-3.border.border-neutral-200.hidden class='lg:grid'
          span.border-b.border-neutral-200.px-3.py-2.bg-neutral-100.font-medium.py-1 Name
          span.border-b.border-neutral-200.px-3.py-2.bg-neutral-100.font-medium.py-1 League
          span.border-b.border-neutral-200.px-3.py-2.bg-neutral-100.font-medium.py-1 Roles
          = each (get this 'model.seasons') as |season index|
            .w-full.flex.items-center class="{{ if season.bg_paint 'bg-neutral-50' }}"
              span.mr-2 class='px-3 py-2' = season.name
              / % LinkTo [
              /   @route='index'
              /   class='border border-white border-opacity-0 group w-full px-3 py-2 flex items-center justify-between hover:pointer hover:bg-neutral-200 focus:outline-none focus:ring-2 focus:ring-sky-500'
              / ]
                / % FaIcon class='text-neutral-300 group-hover:text-black' @fixedWidth=true @icon='arrow-right' @prefix='fas' @size='1x' @transform='grow-0'

            .flex.items-center.px-3.py-2 class="{{if season.bg_paint 'bg-neutral-50'}}"
              = season.league.name
            .flex.items-center.px-3.py-2 class="{{if season.bg_paint 'bg-neutral-50'}}"
              = season.roles_formatted

        .space-y-2.w-full
          = each (get this 'model.seasons') as |season index|
            .flex.flex-col.border.border-neutral-200.p-4.rounded.w-full class="lg:hidden {{if season.bg_paint 'bg-neutral-50'}}"

              .flex.flex-row.my-1
                p.font-medium.w-20 Name
                p.flex-1 = season.name

              .flex.flex-row.my-1
                p.font-medium.w-20 League
                p.flex-1 = season.league.name

              .flex.flex-row.my-1
                p.font-medium.w-20 Roles
                p.flex-1 = season.roles_formatted

              / .flex.flex-row.mt-8
              /   % LinkTo [
              /     @route='index'
              /     class='px-4 py-2 rounded-md bg-white border border-neutral-200 font-medium shadow-sm flex items-center justify-between hover:border-neutral-300 hover:pointer focus:outline-none focus:ring-2 focus:ring-sky-500'
              /   ]
              /     span.mr-2 Season Home
              /     % FaIcon @fixedWidth=true @icon='arrow-right' @prefix='fas' @size='1x' @transform='grow-0'



