= page-title 'Teams - Mutambo' replace=true separator=' → '

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
            @goto={hash route='app.teams'}
            @icon={hash transform='grow-1' icon='tshirt' class='text-emerald-400'}
            @text='Teams'
          ]

      .p-8
        = if (not model.teams.length)
          p.pb-2.italic.text-neutral-500: | You do not have any teams yet.
          p.pb-2.italic.text-neutral-500: | All of your teams will show up here.

        = else
          div [
            class='border border-neutral-200'
            class='overflow-x-auto'
            class='w-full'
            class='mb-7'
          ]
            div [
              class="grid grid-cols-[auto_auto_auto_1fr_auto]"
              class='sm:rounded-sm'
            ]
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium class='h-[40px]'
                span class='h-[40px] w-full border-r border-neutral-200 border-dashed inline-flex items-center justify-center font-normal px-2'
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': | Team
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': | League
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]'
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': | Roles

              = each model.teams as |team index|
                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center justify-center'
                  class='border-r border-neutral-200 border-dashed'
                  class='px-2'
                ]
                  % LinkTo [
                    @route='app.team'
                    @query={hash team_id=team.meta.id}
                    class='bg-white border border-neutral-200 flex h-[30px] hover:bg-neutral-100 hover:pointer hover:text-neutral-700 items-center justify-center mutambo-focus-sky no-underline rounded-full shadow-sm text-neutral-500 w-[30px]' role='link' tabindex='0'
                  ]
                    .flex.justify-center.items-center
                      % FaIcon @prefix='fas' @size='1x' @transform='grow-6' @icon='arrow-alt-circle-right' class='relative'

                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center'
                  class='whitespace-nowrap'
                  class='h-[40px]'
                ]
                  div class='px-3 w-full'
                    span {{team.val.name}}

                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center'
                  class='whitespace-nowrap'
                  class='h-[40px]'
                ]
                  div class='px-3 w-full'
                    span {{team.val.league.val.name}}, {{team.val.season.val.name}}

                div class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"

                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center'
                  class='whitespace-nowrap'
                  class='h-[40px]'
                ]
                  div class='px-3 w-full'
                    span {{team.ui.roles}}



