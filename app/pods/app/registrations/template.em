= page-title 'Registrations - Mutambo' replace=true separator=' → '

div class='min-h-screen flex flex-col md:flex-row'

  % AppNav [
    @leagues=model.leagues
    @user=model.user
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
            @goto={hash route='app.registrations'}
            @icon={hash transform='grow-3' icon='clipboard' class='text-stone-400'}
            @text='Registrations'
          ]

      .p-8
        = if (not model.registrations.page.items.length)
          p.pb-2.italic.text-neutral-500: | You don't have any registrations.
          p.pb-2.italic.text-neutral-500: | All of your registrations will show up here.

        = else
          div [
            class='border border-neutral-200'
            class='overflow-x-auto'
            class='w-full'
            class='mb-7'
          ]
            div [
              class="grid grid-cols-[auto_auto_1fr_auto_auto_auto]"
              class='sm:rounded-sm'
            ]
              / .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]'
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | Type
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | Team
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | League
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]'
              .inline-flex.justify-end.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | Fee
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | Payment

              = each model.registrations.page.items as |_r index|
                / div [
                /   class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                /   class='flex items-center'
                /   class='whitespace-nowrap'
                /   class='h-[40px]'
                / ]
                /   div class='px-3 w-full'
                /     span.font-mono.text-sm {{_r.ui.updated_at}}

                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='inline-flex items-center justify-center'
                  class='whitespace-nowrap'
                  class='h-[40px]'
                ]
                  div class='inline-flex justify-center px-3 w-full'
                    = if (eq _r.meta.type 'league-season-team')
                      span class='px-1.5 py-0.5 rounded-sm text-xs font-medium bg-stone-300 uppercase': | Team
                    = if (eq _r.meta.type 'registration/season-team')
                      span class='px-1.5 py-0.5 rounded-sm text-xs font-medium bg-stone-300 uppercase': | Team
                    = if (eq _r.meta.type 'registration/team-manager')
                      span class='px-1.5 py-0.5 rounded-sm text-xs font-medium bg-stone-300 uppercase': | Manager
                    = if (eq _r.meta.type 'registration-league-season-team-manager')
                      span class='px-1.5 py-0.5 rounded-sm text-xs font-medium bg-stone-300 uppercase': | Manager
                    = if (eq _r.meta.type 'registration-league-season-team-player')
                      span class='px-1.5 py-0.5 rounded-sm text-xs font-medium bg-stone-200 uppercase': | Player
                    = if (eq _r.meta.type 'registration/team-player')
                      span class='px-1.5 py-0.5 rounded-sm text-xs font-medium bg-stone-200 uppercase': | Player

                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center'
                  class='whitespace-nowrap'
                  class='h-[40px]'
                ]
                  div class='px-3 w-full'
                    span: | {{_r.val.team.val.name}}

                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center'
                  class='whitespace-nowrap'
                  class='h-[40px]'
                ]
                  div class='px-3 w-full'
                    span: | {{_r.val.league.val.name}}, {{_r.val.season.val.name}}

                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='inline-flex items-center'
                  class='whitespace-nowrap'
                  class=''
                ]
                  div class='inline-flex pl-3 w-full justify-center'
                    span.rounded-sm.font-medium.text-sm class='px-2 py-0.5 bg-[#c0c3a1]/50'
                      | {{_r.ui.currency}}

                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center'
                  class='whitespace-nowrap'
                  class='h-[40px]'
                ]
                  div class='inline-flex px-3 w-full justify-end'
                    span.font-mono.font-medium: | {{_r.ui.total}}

                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center'
                  class='whitespace-nowrap'
                  class='h-[40px]'
                ]
                  div class='px-3 py-1.5 w-full'
                    = if (not _r.val.payment.val.total)
                      % FaIcon @prefix='fas' @size='1x' @icon='minus' @transform='grow-0' class='text-neutral-300'
                    = else
                      = if (eq _r.val.payment.val.status 'paid')
                        a [
                          class='w-full justify-center border font-medium border-green-500 hover:bg-green-50 hover:pointer inline-flex mutambo-focus-sky px-2 py-1 rounded-md shadow-sm text-sm text-green-700 items-center'
                          href='{{_r.ui.link}}'
                          role='link'
                          tabindex='0'
                        ]
                          % FaIcon @prefix='fas' @size='1x' @icon='check' @transform='grow-0' class='text-green-500'
                          span.ml-1.mr-1: | Paid
                      = else if (eq _r.val.payment.val.status 'refunded')
                        a [
                          class='w-full justify-center border font-medium border-red-500 hover:bg-red-50 hover:pointer inline-flex mutambo-focus-sky px-2 py-1 rounded-md shadow-sm text-sm text-red-700 items-center'
                          href='{{_r.ui.link}}'
                          role='link'
                          tabindex='0'
                        ]
                          % FaIcon @prefix='fas' @size='1x' @icon='rotate-left' @transform='grow-0' class='text-red-500'
                          span.ml-1.mr-1: | Refunded
                      = else
                        a [
                          class='w-full justify-center bg-green-500 border border-transparent font-medium hover:border-green-600 hover:pointer inline-flex mutambo-focus-sky px-2 py-1 rounded-md shadow-sm text-sm text-white'
                          href='{{_r.ui.link}}'
                          role='link'
                          tabindex='0'
                        ]
                          span.mr-1.ml-1: | Pay