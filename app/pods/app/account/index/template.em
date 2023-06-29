= page-title 'Account - Mutambo' replace=true separator=' → '

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
            @goto={hash route='app.account'}
            @icon={hash transform='grow-1' icon='user' class='text-gray-400'}
            @text='Account'
          ]

      .p-8.flex.flex-col
        .inline-flex.items-center.pb-2
          .font-medium.text-neutral-900 Display Name
          / % LinkTo [
          /   @route='app.account.edit-display-name'
          /   class='bg-white border border-neutral-200 flex h-[30px] hover:pointer hover:text-neutral-700 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-full shadow-sm text-neutral-500 w-[30px]'
          /   role='link'
          /   tabindex='0'
          / ]
          /   % FaIcon @prefix='fas' @size='1x' @transform='shrink-2' @icon='pen'
        .inline-flex.pb-5
          p.pb-2.text-neutral-800 = if (get this 'model.user.val.display_name') (get this 'model.user.val.display_name') '–'

        .inline-flex.items-center.pb-2
          .font-medium.text-neutral-900 Full Name
          % LinkTo [
            @route='app.account.edit-full-name'
            class='bg-white border border-neutral-200 flex h-[30px] hover:pointer hover:text-neutral-700 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-full shadow-sm text-neutral-500 w-[30px]'
            role='link'
            tabindex='0'
          ]
            % FaIcon @prefix='fas' @size='1x' @transform='shrink-2' @icon='pen'
        .inline-flex.pb-5
          p.pb-2.text-neutral-800 = if (get this 'model.user.val.full_name') (get this 'model.user.val.full_name') '–'

        .inline-flex.items-center.pb-2
          .font-medium.text-neutral-900 Birthday
          / % LinkTo [
          /   @route='app.account.edit-birthday'
          /   class='bg-white border border-neutral-200 flex h-[30px] hover:pointer hover:text-neutral-700 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-full shadow-sm text-neutral-500 w-[30px]'
          /   role='link'
          /   tabindex='0'
          / ]
          /   % FaIcon @prefix='fas' @size='1x' @transform='shrink-2' @icon='pen'
        .inline-flex.pb-5
          p.pb-2.text-neutral-800 {{or model.user.ui.birthday '–'}}

        .inline-flex.items-center.pb-2
          .font-medium.text-neutral-900 Address
          / % LinkTo [
          /   @route='app.account.edit-address'
          /   class='bg-white border border-neutral-200 flex h-[30px] hover:pointer hover:text-neutral-700 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-full shadow-sm text-neutral-500 w-[30px]'
          /   role='link'
          /   tabindex='0'
          / ]
          /   % FaIcon @prefix='fas' @size='1x' @transform='shrink-2' @icon='pen'
        .flex.flex-col.space-y-1.pb-7
          = each model.user.ui.address as |line|
              p.text-neutral-800 = line
          = else
            p.text-neutral-800: | {{'–'}}


        .inline-flex.items-center.pb-2
          .font-medium.text-neutral-900 Gender
          / % LinkTo [
          /   @route='app.account.edit-gender'
          /   class='bg-white border border-neutral-200 flex h-[30px] hover:pointer hover:text-neutral-700 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-full shadow-sm text-neutral-500 w-[30px]'
          /   role='link'
          /   tabindex='0'
          / ]
          /   % FaIcon @prefix='fas' @size='1x' @transform='shrink-2' @icon='pen'
        .inline-flex.pb-5
          p.pb-2.text-neutral-800 = if (get this 'model.user.ui.gender') (get this 'model.user.ui.gender') '–'

        .inline-flex.pb-2
          h3.font-medium
            | Email
            = if (gt (get model 'user.val.emails.length') 1)
              | s
        .flex.flex-col.space-y-1.pb-7.items-start
          = each (get model 'user.val.emails') as |email|
            p.text-neutral-800
              | {{email}}
              span.px-1
              = if (eq email (get model 'user.val.email'))
                span class='inline-flex items-center justify-center bg-blue-700/5 text-blue-700 uppercase text-xs font-medium px-[6px] py-[3px] rounded-md'
                  | Primary


        .inline-flex
          h3.font-medium.pb-3 Phone
        .inline-flex
          p.pb-2.text-neutral-800 = if (get this 'model.user.val.phone') (get this 'model.user.val.phone') '–'

        .mt-8
          % LinkTo [
            @route='log-out'
            class='bg-white border border-neutral-200 font-medium hover:border-neutral-300 hover:pointer inline-flex mutambo-focus-sky px-4 py-2 rounded-md shadow-sm'
            role='link'
            tabindex='0'
          ]
            | Log Out

