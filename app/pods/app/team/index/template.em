= page-title (get this 'title_string') replace=true separator=' → '

div class='min-h-screen flex flex-col md:flex-row min-w-full'

  % AppNav [
    @isLoggedIn=this.model.isLoggedIn
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
            @goto={hash route='app.teams'}
            @icon={hash transform='grow-1' icon='tshirt' class='text-emerald-400'}
            @text='Teams'
          ]
          % Breadcrumb [
            @goto={hash route='app.team.index' query=(hash team_id=model.team.meta.id)}
            @text={or model.team.val.name 'Team'}
          ]


      .p-8.flex.flex-col
        .flex.flex-col [
          class="max-w-4xl"
          class="md:w-full"
          class="2xl:w-8/12"
        ]

          .inline-flex.items-center.pb-2
            .font-medium.text-neutral-900: | Roles

          .inline-flex.pb-6
            p.pb-2.text-neutral-800
              | {{or (get model 'team.ui.roles') '–'}}

          

          .inline-flex.items-center.pb-1
            .font-medium.text-neutral-900 Managers

          = if (and model.team.val.is_manager model.ictm.ui.link)
            .inline-flex.pb-2
              .bg-neutral-100.rounded-lg.mt-1.p-4.w-full
                ol.list-disc.ml-5.space-y-2
                  li.text-neutral-600: | To invite additional managers to this team share the link below.
                .inline-flex.w-full.pt-3
                  .inline-flex.w-full.rounded-md.shadow-sm
                    .relative.flex.flex-grow.items-stretch class='focus-within:z-10'
                      input.block.w-full.rounded-none.rounded-l-md.px-2 type='text' name='link' class='mutambo-focus-sky border border-neutral-200' value='{{model.ictm.ui.link}}'
                    button{on 'click' (fn this.copy 'ictm')} type='button' class='mutambo-focus-sky hover:border-neutral-300 hover:text-neutral-900 relative -ml-px inline-flex items-center space-x-2 rounded-r-md border border-neutral-200 bg-neutral-50 px-4 py-2 font-medium text-neutral-600'
                      % FaIcon @prefix='fas' @size='1x' @icon='copy' @transform='shrink-2'
                      span: | Copy

          .flex.pb-6.flex-col
            = if (not model.team.val.managers.length)
              p.pb-2.italic.text-neutral-500: | This team does not have any managers yet.
              p.pb-2.italic.text-neutral-500: | Managers of this team will show up here.
            = else
              .grid.border.border-neutral-100.rounded-md class='grid-cols-[auto_auto_1fr_auto] overflow-x-auto'
                .inline-flex.h-10.bg-neutral-100.border-r.border-neutral-200.border-dashed
                .inline-flex.items-center.h-10.bg-neutral-100.font-medium.px-2.py-px Display Name
                = if (get model 'team.val.is_manager')
                  .inline-flex.items-center.h-10.bg-neutral-100.font-medium.px-2.py-px: | Full Name
                  .inline-flex.items-center.h-10.bg-neutral-100.font-medium.px-2.py-px: | Email
                = else
                  .inline-flex.h-10.bg-neutral-100
                  .inline-flex.h-10.bg-neutral-100

                = each (get model 'team.val.managers') as |_manager _index|
                  .contents.group
                    .inline-flex.items-center.justify-end.h-10.text-right.pl-2.pr-1.border-r.border-neutral-200.border-dashed class='group-hover:bg-amber-100' {{add _index 1}}.
                    .inline-flex.items-center.h-10.px-2.whitespace-nowrap class='group-hover:bg-amber-100' {{_manager.val.display_name}}
                    = if (and (get model 'team.val.is_manager') _manager.val.full_name _manager.val.email)
                      .inline-flex.items-center.h-10.px-2.whitespace-nowrap class='group-hover:bg-amber-100' {{_manager.val.full_name}}
                      .inline-flex.items-center.h-10.px-2.whitespace-nowrap.break-all.text-neutral-400 class='group-hover:bg-amber-100' class='min-w-[220px]' {{_manager.val.email}}
                    = else
                      .inline-flex.h-10 class='group-hover:bg-amber-100'
                      .inline-flex.h-10 class='group-hover:bg-amber-100'



          .inline-flex.items-center.pb-1
            .font-medium.text-neutral-900 Players
          
          = if (and model.team.val.is_manager model.ictp.ui.link)
            .inline-flex.pb-2
              .bg-neutral-100.rounded-lg.mt-1.p-4.w-full
                ol.list-disc.ml-5.space-y-2
                  li.text-neutral-600: | To invite additional players to this team share the link below.
                .inline-flex.w-full.pt-3
                  .inline-flex.w-full.rounded-md.shadow-sm
                    .relative.flex.flex-grow.items-stretch class='focus-within:z-10'
                      input.block.w-full.rounded-none.rounded-l-md.px-2 type='text' name='link' class='mutambo-focus-sky border border-neutral-200' value='{{model.ictp.ui.link}}'
                    button{on 'click' (fn this.copy 'ictp')} type='button' class='mutambo-focus-sky hover:border-neutral-300 hover:text-neutral-900 relative -ml-px inline-flex items-center space-x-2 rounded-r-md border border-neutral-200 bg-neutral-50 px-4 py-2 font-medium text-neutral-600'
                      % FaIcon @prefix='fas' @size='1x' @icon='copy' @transform='shrink-2'
                      span: | Copy

          .flex.pb-6.flex-col
            = if (not model.team.val.players.length)
              p.pb-2.italic.text-neutral-500: | This team does not have any players yet.
              p.pb-2.italic.text-neutral-500: | Players on this team will show up here.
            = else
              .grid.border.border-neutral-100.rounded-md class='grid-cols-[auto_auto_1fr_auto_auto] overflow-x-auto'
                .inline-flex.items-center.py-1.h-10.bg-neutral-100.border-r.border-neutral-200.border-dashed
                .inline-flex.items-center.py-1.h-10.bg-neutral-100.font-medium.px-2.py-px Display Name
                = if (get model 'team.val.is_manager')
                  .inline-flex.items-center.py-1.h-10.bg-neutral-100.font-medium.px-2.py-px: | Full Name
                  .inline-flex.items-center.py-1.h-10.bg-neutral-100.font-medium.px-2.py-px: | Email
                  .inline-flex.items-center.py-1.h-10.bg-neutral-100
                = else
                  .inline-flex.items-center.py-1.h-10.bg-neutral-100
                  .inline-flex.items-center.py-1.h-10.bg-neutral-100
                  .inline-flex.items-center.py-1.h-10.bg-neutral-100

                = each (get model 'team.val.players') as |_player _index|
                  .contents.group
                    .inline-flex.h-10.items-center.justify-center.pl-2.pr-1.border-r.border-neutral-200.border-dashed class='group-hover:bg-amber-100' {{add _index 1}}
                    .inline-flex.h-10.items-center.px-2.whitespace-nowrap class='group-hover:bg-amber-100' {{_player.val.display_name}}
                    = if (or (and (get model 'team.val.is_manager') _player.val.full_name _player.val.email) (eq _player.val.email model.user.val.email))
                      .inline-flex.h-10.items-center.px-2.whitespace-nowrap class='group-hover:bg-amber-100' {{_player.val.full_name}}
                      .inline-flex.h-10.items-center.px-2.whitespace-nowrap.break-all.text-neutral-400 class='min-w-[220px]' class='group-hover:bg-amber-100' {{_player.val.email}}
                      .flex.items-center.justify-center class='group-hover:bg-amber-100 px-1'
                        button [
                          class='border border-neutral-700/0 h-8 w-8 hover:bg-white focus:hover:bg-white hover:cursor-pointer hover:shadow-sm inline-flex items-center justify-center mutambo-focus-sky overflow-hidden rounded-md'
                          role='button'
                          tabindex='0'
                          onclick={action toggleRemovePlayerBox _player}
                        ]
                          % FaIcon [
                            @prefix='fas'
                            @size='1x'
                            @transform=''
                            @icon='user-minus'
                            class='text-neutral-900'
                          ]
                    = else
                      .flex class='group-hover:bg-amber-100'
                      .flex class='group-hover:bg-amber-100'
                      .flex class='group-hover:bg-amber-100'


  = if this.show_remove_player_box
    .fixed.flex.justify-center.items-center.w-screen.h-screen.bg-opacity-75.bg-neutral-500.z-10.top-0.left-0.p-8 class='md:p-0'
      .p-8.bg-white.border.border-neutral-100.shadow-lg.rounded-lg.w-full class='md:w-96 md:m-0'

        .flex.items-center.justify-between.pb-6.border-b.border-neutral-100.mb-7
          .inline-flex.flex-col.items-start.mr-2
            .inline-flex.font-bold: | Remove Player

          .flex.items-center.justify-center
            button [
              onclick={action this.toggleRemovePlayerBox}
              class='flex justify-center items-center'
              class='hover:bg-neutral-50 text-neutral-900 hover:text-black'
              class='border border-neutral-700/20 h-8 w-8 focus:hover:bg-white hover:cursor-pointer shadow-sm inline-flex items-center justify-center mutambo-focus-sky rounded-md'
              class='w-8 h-8'
              type='button'
            ]
              % FaIcon @fixedWidth=true @icon='times' @prefix='fas' @size='1x' @transform='shrink-0'

        div class='sm:w-full sm:max-w-md'
          div.mb-4
            .flex.items-center.justify-between
              .font-medium.text-neutral-900: | Player
            .flex.flex-col
              .inline-flex: | {{form.values.player.val.full_name}}
          
          div
            label.flex.items-center.justify-between for='confirm_text'
              .font-medium.text-neutral-900: | Confirm
              span
              / button{on 'click' (fn this.toggleHelp 'confirm_text')} class='mutambo-form-help-button' role='button' tabindex='0'
              /   % FaIcon @prefix='fas' @size='1x' @icon='question-circle'
            label
              .inline-flex: | Type
              .inline-flex.ml-1.py-px.px-1.rounded-sm.border.border-neutral-100.bg-white: | REMOVE
              .inline-flex.ml-1: | in the field below to confirm.

            = if form.help.confirm_text
              .bg-neutral-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                ol.list-disc.ml-5.space-y-2
                  li.text-neutral-600 A player cannot be removed once they have been on a game roster.

            = if (and (not form.valid.confirm_text) form.submitted)
              .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                  ol.list-disc.ml-5.space-y-2
                    li.text-red-800 This field is required.

            .mt-1.relative.rounded-md.shadow-sm
            .mt-1.block.w-full.rounded-md.border-neutral-300
              % Input{on 'input' (fn this.formValueChanged 'confirm_text')} @type='text' @value=form.values.confirm_text autofocus=true class='form-input mt-1 block w-full rounded-md border-neutral-300 mutambo-focus-sky' placeholder=''

          div.pt-8
            button [
              onclick={action confirm}
              class='w-full flex justify-center py-2 px-4 border border-transparent rounded-md font-medium mutambo-focus-neutral-dark shadow-sm text-white bg-neutral-800 hover:bg-neutral-900'
              role='button'
              tabindex='0'
            ]
              | Remove Player