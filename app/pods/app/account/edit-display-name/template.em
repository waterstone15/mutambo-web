= page-title 'Account → Edit (Display Name) - Mutambo' replace=true separator=' → '

div class='min-h-screen flex flex-col md:flex-row'

  % AppNav [
    @leagues=model.leagues
    @user=model.user
  ]

  .flex.w-full
    .flex.flex-col.p-8.w-full
      .flex.justify-between.items-center.border-b.border-neutral-100.mb-7
        h2.flex.font-bold style='padding-top: 2px; padding-bottom: 21px;' Account &rarr; Edit (Display Name)

      .space-y-6 class='sm:w-full sm:max-w-md'
        div
          label.flex.items-center.justify-between for='display_name'
            .font-medium.text-neutral-900 Display Name
            button{on 'click' (fn this.toggleHelp 'display_name')} class='mutambo-form-help-button' role='button' tabindex='0'
              % FaIcon @prefix='fas' @size='1x' @icon='question-circle'

          = if form.help.display_name
            .bg-neutral-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
              ol.list-disc.ml-5.space-y-2
                li.text-neutral-600 Your display name will be visible to all players.
                li.text-neutral-600 A first name or nickname works well.

          = if (and (not form.valid.display_name) form.submitted)
            .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                ol.list-disc.ml-5.space-y-2
                  li.text-red-800 A display name is required.

          .mt-1.relative.rounded-md.shadow-sm
          .mt-1.block.w-full.rounded-md.border-neutral-300
            % Input{on 'input' (fn this.formValueChanged 'display_name')}{on 'keydown' (fn this.formKeyPress 'display_name')} @type='text' @value=form.values.display_name autofocus=true class='form-input mt-1 block w-full rounded-md border-neutral-300 mutambo-focus-sky' placeholder=''

      .mt-8.space-x-3
        button{on 'click' (fn this.save)} class='bg-green-500 border border-green-500 font-medium hover:border-green-600 hover:pointer inline-flex mutambo-focus-sky px-4 py-2 rounded-md shadow-sm text-white' role='button' tabindex='0'
          span Save

        % LinkTo [
          @route='app.account.index'
          class='bg-white border border-neutral-200 font-medium hover:border-neutral-300 hover:pointer inline-flex mutambo-focus-sky px-4 py-2 rounded-md shadow-sm'
          role='link'
          tabindex='0'
        ]
          | Cancel
