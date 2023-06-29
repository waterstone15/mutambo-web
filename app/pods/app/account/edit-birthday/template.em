= page-title 'Account → Edit (Birthday) - Mutambo' replace=true separator=' → '

div class='min-h-screen flex flex-col md:flex-row'

  % AppNav [
    @leagues=model.leagues
    @user=model.user
  ]

  .flex.w-full
    .flex.flex-col.p-8.w-full
      .flex.justify-between.items-center.border-b.border-neutral-100.mb-7
        h2.flex.font-bold style='padding-top: 2px; padding-bottom: 21px;' Account &rarr; Edit (Birthday)

      .space-y-6 class='sm:w-full sm:max-w-md'
        div
          label.flex.items-center.justify-between for='birthday'
            .font-medium.text-neutral-900 Birthday
            button{on 'click' (fn this.toggleHelp 'birthday')} class='mutambo-form-help-button' role='button' tabindex='0'
              % FaIcon @prefix='fas' @size='1x' @icon='question-circle'

          = if msg.remaining.show
            .bg-amber-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                ol.list-disc.ml-5.space-y-2
                  li.text-amber-800
                    | Your have already reached the maximum number of birthday edits.
                  li.text-amber-800
                    | If your birthday is not accurate please contact support.

          = if form.help.birthday
            .bg-neutral-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
              ol.list-disc.ml-5.space-y-2
                li.text-neutral-600 Your birthday will be visible to league administrators.
                li.text-neutral-600 Leagues may require your birthday to meet insurance or other legal requirements.
                li.text-neutral-600 Your birthday should match the ID you use for game check-in.

          = if (and (not form.valid.birthday) form.submitted)
            .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                ol.list-disc.ml-5.space-y-2
                  li.text-red-800 A valid birthday is required.

          fieldset.flex.flex-col
            .flex.w-full.-space-x-px.rounded-md
              .flex-1: span.text-neutral-900.text-sm Year
              .flex-1: span.text-neutral-900.text-sm Month
              .flex-1: span.text-neutral-900.text-sm Day
            .flex.w-full.-space-x-px.rounded-md
              .flex-1
                label.sr-only for='birthday-year' Year
                % Input{on 'input' (fn this.formValueChanged 'birthday.year')}{on 'keydown' (fn this.formKeyPress 'birthday.year')} @type='number' @value=form.values.birthday.year name='birthday-year' class='form-input bg-transparent block border-neutral-300 mutambo-focus-sky focus:z-10 relative rounded-bl-md rounded-none rounded-tl-md w-full' placeholder='' min=1000 max=3000
              .flex-1
                label.sr-only for='birthday-month' Month
                % Input{on 'input' (fn this.formValueChanged 'birthday.month')}{on 'keydown' (fn this.formKeyPress 'birthday.month')} @type='number' @value=form.values.birthday.month name='birthday-month' class='form-input bg-transparent block border-neutral-300 mutambo-focus-sky focus:z-10 relative rounded-none w-full' placeholder='' min=1 max=12
              .flex-1
                label.sr-only for='birthday-day' Day
                % Input{on 'input' (fn this.formValueChanged 'birthday.day')}{on 'keydown' (fn this.formKeyPress 'birthday.day')} @type='number' @value=form.values.birthday.day name='birthday-day' class='form-input bg-transparent block border-neutral-300 mutambo-focus-sky focus:z-10 relative rounded-tr-md rounded-none rounded-br-md w-full' placeholder='' min=1 max=31


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
