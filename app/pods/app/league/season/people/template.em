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
            @goto={hash route='app.league.season.index' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @icon={hash transform='grow-1' icon='sun' class='text-yellow-400'}
            @text={or model.season.val.name 'Season'}
          ]
          % Breadcrumb [
            @goto={hash route='app.league.season.people' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @icon={hash transform='grow-1' icon='address-book' class='text-purple-400'}
            @text='People'
          ]

      .p-8
        = if (not model.people.page.items.length)
          p.pb-2.italic.text-neutral-500: | There are no people in this league yet.
          p.pb-2.italic.text-neutral-500: | All people in this league will show up here.

        = else
          div [
            class='border border-neutral-200'
            class='overflow-x-auto'
            class='w-full'
            class='mb-7'
          ]
            div [
              class="grid grid-cols-[auto_auto_1fr_auto]"
              class='sm:rounded-sm'
            ]
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium class='h-[40px]'
                span class='h-[40px] w-full border-r border-neutral-200 border-dashed inline-flex items-center justify-center font-normal px-2'
                  | {{model.people.counts.total}}
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | Full Name
              .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | Email
              .inline-flex.items-center.justify-between.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]'
                .inline-flex: | Roles
                .infline-flex.items-center.justify-center class='pl-1.5'
                  button [
                    onclick={action this.toggleRoleFilterBox}
                    class='border border-neutral-700/0 h-8 w-8 hover:bg-white focus:hover:bg-white hover:cursor-pointer hover:shadow-sm inline-flex items-center justify-center mutambo-focus-sky overflow-hidden rounded-md'
                    role='button'
                    tabindex='0'
                  ]
                    % FaIcon [
                      @prefix='fas'
                      @size='1x'
                      @transform='grow-0'
                      @icon='filter'
                      class='text-neutral-900'
                    ]
              / .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium class='h-[40px]'
              / .inline-flex.justify-end.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | Total
              / .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium.px-3 class='h-[40px]': span: | Payment
              / .inline-flex.items-center.bg-neutral-100.border-b.border-neutral-200.font-medium class='h-[40px]'


              = each model.people.page.items as |_p index|
                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center justify-center'
                  class='border-r border-neutral-200 border-dashed'
                ]
                  div class='px-2 py-2'
                    span: | {{add model.people.counts.before index 1}}

                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center'
                  class='py-1'
                  class='min-w-[200px]'
                ]
                  div class='px-3 w-full'
                    span: | {{or _p.val.full_name _p.val.display_name}}

                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center'
                  class='py-1'
                  class='min-w-[200px]'
                ]
                  div class='px-3 w-full'
                    span.text-neutral-400.font-light.italic: | {{_p.val.email}}

                div [
                  class="{{if (eq (mod index 2) 1) 'bg-neutral-50'}}"
                  class='flex items-center'
                  class='py-1'
                  class='min-w-[200px]'
                ]
                  div class='px-3 w-full'
                    span: | {{_p.ui.roles}}


          .flex
            = if model.people.prev
              % LinkTo [
                @route='app.league.season.people'
                @query={hash league_id=model.league.meta.id season_id=model.season.meta.id c=model.people.prev.meta.id p='page-end' }
                class='bg-white border border-neutral-300 flex h-[37px] hover:pointer hover:text-neutral-700 hover:bg-neutral-100 items-center justify-center mutambo-focus-sky no-underline rounded-md shadow-sm text-neutral-600 w-[37px]'
                role='link'
                tabindex='0'
              ]
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-left'
            = else
              div class='bg-white border border-neutral-200 flex h-[37px] items-center justify-center no-underline rounded-md shadow-sm text-neutral-300 w-[37px]'
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-left'

            = if model.people.next
              % LinkTo [
                @route='app.league.season.people'
                @query={hash league_id=model.league.meta.id season_id=model.season.meta.id c=model.people.next.meta.id p='page-start' }
                class='bg-white border border-neutral-300 flex h-[37px] hover:pointer hover:text-neutral-700 hover:bg-neutral-100 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-md shadow-sm text-neutral-600 w-[37px]'
                role='link'
                tabindex='0'
              ]
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-right'
            = else
              div class='bg-white border border-neutral-200 flex h-[37px] items-center justify-center no-underline rounded-md shadow-sm ml-2 text-neutral-300 w-[37px]'
                % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='arrow-right'

  = if this.show_role_filter_box
    .fixed.flex.justify-center.items-center.w-screen.h-screen.bg-opacity-75.bg-neutral-500.z-10.top-0.left-0.p-8 class='md:p-0'
      .p-8.bg-white.border.border-neutral-100.shadow-lg.rounded-lg.w-full class='md:w-96 md:m-0'

        .flex.items-center.justify-between.pb-6.border-b.border-neutral-100.mb-7
          .inline-flex.items-start.mr-2.space-x-2
            .inline: | Filter:
            .inline.font-bold: | Role

          .flex.items-center.justify-center
            button [
              onclick={action this.toggleRoleFilterBox}
              class='flex justify-center items-center'
              class='hover:bg-neutral-50 text-neutral-900 hover:text-black'
              class='border border-neutral-700/20 h-8 w-8 focus:hover:bg-white hover:cursor-pointer shadow-sm inline-flex items-center justify-center mutambo-focus-sky rounded-md'
              class='w-8 h-8'
              type='button'
            ]
              % FaIcon @fixedWidth=true @icon='times' @prefix='fas' @size='1x' @transform='shrink-0'

        .space-y-6
          div
            / label.flex.items-center.justify-between.font-medium for='filter-type': | Show
            / .mt-1.relative.rounded-md
            /   div
            .mt-1.block.w-full.rounded-md.border-neutral-300
              .mt-2
                div
                  label.inline-flex.items-center class='cursor-pointer mb-2'
                    input{on 'input' (fn this.formValueChanged 'filter_role' 'all')} checked={eq this.form.values.filter_role 'all'} type='radio' name='radio-direct' class='form-radio border-neutral-300 text-sky-600 shadow-sm focus:border-sky-300 focus:ring focus:ring-offset-0 focus:ring-sky-200 focus:ring-opacity-50' value=form.values.filter_role
                    span.ml-2: | All
                  div
                  label.inline-flex.items-center class='cursor-pointer mb-2'
                    input{on 'input' (fn formValueChanged 'filter_role' 'admin')} checked={eq form.values.filter_role 'admin'} type='radio' name='radio-direct' class='form-radio border-neutral-300 text-sky-600 shadow-sm focus:border-sky-300 focus:ring focus:ring-offset-0 focus:ring-sky-200 focus:ring-opacity-50' value=form.values.filter_role
                    span.ml-2: | Admin
                  div
                  label.inline-flex.items-center class='cursor-pointer mb-2'
                    input{on 'input' (fn formValueChanged 'filter_role' 'manager')} checked={eq form.values.filter_role 'manager'} type='radio' name='radio-direct' class='form-radio border-neutral-300 text-sky-600 shadow-sm focus:border-sky-300 focus:ring focus:ring-offset-0 focus:ring-sky-200 focus:ring-opacity-50' value=form.values.filter_role
                    span.ml-2: | Manager
                  div
                  label.inline-flex.items-center class='cursor-pointer mb-2'
                    input{on 'input' (fn formValueChanged 'filter_role' 'player')} checked={eq form.values.filter_role 'player'} type='radio' name='radio-direct' class='form-radio border-neutral-300 text-sky-600 shadow-sm focus:border-sky-300 focus:ring focus:ring-offset-0 focus:ring-sky-200 focus:ring-opacity-50' value=form.values.filter_role
                    span.ml-2: | Player

          div.pt-8
            button [
              onclick={action setFilterRole}
              class='w-full flex justify-center py-2 px-4 border border-transparent rounded-md font-medium mutambo-focus-sky-dark shadow-sm text-white bg-sky-600 hover:bg-sky-700'
              role='button'
              tabindex='0'
            ]
              | Confirm