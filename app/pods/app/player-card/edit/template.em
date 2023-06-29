= page-title 'Player Card → Edit - Mutambo' replace=true separator=' → '

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
            @goto={hash route='app.player-cards'}
            @icon={hash transform='grow-2' icon='portrait' class='text-purple-400'}
            @text='Player Cards'
          ]
          % Breadcrumb [
            @goto={hash route='app.player-card.edit' query=(hash card_id=model.card.meta.id)}
            @icon={hash transform='shrink-1' icon='pen' class='text-neutral-900'}
            @text='Edit'
          ]

      .p-8
        .space-y-6 class='sm:w-full sm:max-w-md'
          div
            label.flex.items-center.justify-between for='about'
              .font-medium.text-neutral-900 About
              button{on 'click' (fn toggleHelp 'about')} class='mutambo-form-help-button' role='button' tabindex='0'
                % FaIcon @prefix='fas' @size='1x' @icon='question-circle'

            = if form.help.about
              .bg-neutral-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                ol.list-disc.ml-5.space-y-2
                  li.text-neutral-600 Please write a brief description of yourself as a player.
                  li.text-neutral-600 Do not share your contact information. Registered managers will be able to email you.
                  li.text-neutral-600 Clear and concise is best.


            = if (and (not form.valid.about) form.submitted)
              .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                  ol.list-disc.ml-5.space-y-2
                    li.text-red-800 A description is required.

            .mt-1.relative.rounded-md.shadow-sm
            .mt-1.block.w-full.rounded-md.border-neutral-300
              % Textarea{on 'input' (fn formValueChanged 'about')}{on 'keydown' (fn formKeyPress 'about')} @value=form.values.about autofocus=true class='form-input mt-1 block w-full rounded-md border-neutral-300 mutambo-focus-sky' rows='4'

          div
            label.flex.items-center.justify-between for='status'
              .font-medium.text-neutral-900 Visibility
              button{on 'click' (fn toggleHelp 'status')} class='mutambo-form-help-button' role='button' tabindex='0'
                % FaIcon @prefix='fas' @size='1x' @icon='question-circle'


            = if form.help.status
              .bg-neutral-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                ol.list-disc.ml-5.space-y-2
                  li.text-neutral-600
                    span Select 'Do Not Show' to remove your player card from all free agent boards.

            .mt-1.block.w-full.rounded-md.border-neutral-300
              .mt-2
                div
                  label.inline-flex.items-center class='cursor-pointer mb-2'
                    input{on 'input' (fn formValueChanged 'status' 'show')} checked={eq form.values.status 'show'} type='radio' name='radio-direct' class='form-radio border-neutral-300 text-sky-600 shadow-sm focus:border-sky-300 focus:ring focus:ring-offset-0 focus:ring-sky-200 focus:ring-opacity-50' value=form.values.status
                    span.ml-2 Show
                  div
                  label.inline-flex.items-center class='cursor-pointer mb-2'
                    input{on 'input' (fn formValueChanged 'status' 'do-not-show')} checked={eq form.values.status 'do-not-show'} type='radio' name='radio-direct' class='form-radio border-neutral-300 text-sky-600 shadow-sm focus:border-sky-300 focus:ring focus:ring-offset-0 focus:ring-sky-200 focus:ring-opacity-50' value=form.values.status
                    span.ml-2 Do Not Show

        .mt-8.space-x-3
          button{on 'click' (fn save)} class='bg-green-500 border border-green-500 font-medium hover:border-green-600 hover:pointer inline-flex mutambo-focus-sky px-4 py-2 rounded-md shadow-sm text-white' role='button' tabindex='0'
            span Save

          % LinkTo [
            @route='app.player-cards'
            class='bg-white border border-neutral-200 font-medium hover:border-neutral-300 hover:pointer inline-flex mutambo-focus-sky px-4 py-2 rounded-md shadow-sm'
            role='link'
            tabindex='0'
          ]
            | Cancel
