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
            @goto={hash route='app.league.free-agents.index' query=(hash league_id=model.league.meta.id)}
            @icon={hash transform='grow-3' icon='running' class='text-purple-400'}
            @text='Free Agents'
          ]

      .p-8
        = if (not model.cards.page.items)
          p.pb-2.italic.text-neutral-500 This league doesn't have any free agents.
          p.pb-2.italic.text-neutral-500 Free agent player cards will show up here.

        = else
          .player-card-grid.grid.gap-2
            = each model.cards.page.items as |card|
              .flex.flex-col.border.border-neutral-200.rounded-md.shadow-sm.overflow-hidden
                .flex.justify-between.items-center.border-b.border-neutral-200.bg-neutral-100
                  .flex.font-bold.my-2.mx-4 = card.val.display_name
                  .flex.justify-center.text-xs.font-mono.text-neutral-500.mr-4
                    | {{card.ui.updated_at}}
                .about-box.flex.px-4.py-6.flex-grow.flex-col.justify-between
                  p = card.val.about
                = if card.val.email
                  .flex.items-center.flex-grow-0.justify-between.border-t.border-neutral-200.bg-neutral-50
                    p.flex.font-light.italic.my-2.mx-4.break-all = card.val.email


          .flex.pt-8
            = if model.cards.prev
              % LinkTo [
                @route='app.league.free-agents'
                @query={hash league_id=model.league.meta.id c=model.cards.prev.meta.id p='page-end' }
                class='bg-white border border-neutral-300 flex h-[37px] hover:pointer hover:text-neutral-700 hover:bg-neutral-100 items-center justify-center mutambo-focus-sky no-underline rounded-md shadow-sm text-neutral-600 w-[37px]'
                role='link'
                tabindex='0'
              ]
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-left'
            = else
              div class='bg-white border border-neutral-200 flex h-[37px] items-center justify-center no-underline rounded-md shadow-sm text-neutral-300 w-[37px]'
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-left'

            = if model.cards.next
              % LinkTo [
                @route='app.league.free-agents'
                @query={hash league_id=model.league.meta.id c=model.cards.next.meta.id p='page-start' }
                class='bg-white border border-neutral-300 flex h-[37px] hover:pointer hover:text-neutral-700 hover:bg-neutral-100 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-md shadow-sm text-neutral-600 w-[37px]'
                role='link'
                tabindex='0'
              ]
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-right'
            = else
              div class='bg-white border border-neutral-200 flex h-[37px] items-center justify-center no-underline rounded-md shadow-sm ml-2 text-neutral-300 w-[37px]'
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-right'