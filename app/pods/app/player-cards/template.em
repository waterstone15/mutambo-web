= page-title 'Player Cards - Mutambo' replace=true separator=' → '

div class='min-h-screen flex flex-col md:flex-row'

  % AppNav [
    @leagues=this.model.leagues
    @user=this.model.user
  ]

  .flex.w-full
    .flex.flex-col.w-full
      .px-8.flex.justify-between.items-center.border-b.border-neutral-100 class='min-h-[80px]'
        .inline-flex.items-center.flex-wrap class='md:h-[48px] py-4 md:py-0'
          % Breadcrumb [
            @arrow=false
            @goto={hash route='app.hello'}
            @icon={hash transform='grow-1' icon='user' class='text-neutral-900'}
            @text={if model.user model.user.val.display_name 'Dashboard'}
          ]
          % Breadcrumb [
            @goto={hash route='app.player-cards'}
            @icon={hash transform='grow-2' icon='portrait' class='text-purple-400'}
            @text='Player Cards'
          ]

      .p-8
        = if (not (get this 'model.cards.length'))
          p.pb-2.italic.text-neutral-500 You don't have any player cards.
          p.pb-2.italic.text-neutral-500 All of your player cards will show up here.

        = else
          .player-card-grid.grid.gap-2
            = each (get this 'model.cards') as |card index|
              / cards as card, index (card.meta.id)")
              .flex.flex-col.border.border-neutral-200.rounded-md.shadow-sm.overflow-hidden
                .flex.justify-between.items-center.border-b.border-neutral-200.bg-neutral-100
                  = if card.val.display_name
                    .flex.font-bold.my-2.mx-4 {{card.val.display_name}}
                  = else
                    .flex.my-2.mx-4.italic class='text-neutral-400/0' Display Name

                  % LinkTo [
                    @route='app.player-card.edit'
                    @query={hash card_id=card.meta.id}
                    class='bg-white border border-neutral-200 flex h-[30px] hover:pointer hover:text-neutral-700 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-full shadow-sm text-neutral-500 w-[30px] mr-1'
                    role='link'
                    tabindex='0'
                  ]
                    % FaIcon @prefix='fas' @size='1x' @transform='shrink-2' @icon='pen'

                  

                .flex.flex-grow.justify-center.items-center.bg-neutral-50.px-6.py-16.border-b.border-neutral-200
                  = if (eq (get card 'val.sport') 'Football (Soccer)')
                    % FaIcon @prefix='fas' @size='3x' @icon='futbol' @transform='grow-0' class='text-neutral-300'
                  = else
                    % FaIcon @prefix='fas' @size='3x' @icon='user' @transform='grow-0' class='text-neutral-300'
                .flex-grow.px-4.py-6
                  = if (not (not card.val.sport))
                    .flex.justify-center
                      .flex.font-medium.mb-4.bg-purple-100.rounded.border.border-purple-400.px-2.py-1
                        | {{card.val.sport}}
                  p
                    = if card.val.about
                      | {{card.val.about}}
                    = else
                      span.italic class='text-neutral-400/0'
                        | Player description.
                .flex.items-center.flex-grow-0.justify-between.border-t.border-neutral-200.bg-neutral-50
                  p.flex.font-light.italic.my-2.mx-4.break-all = card.val.email


