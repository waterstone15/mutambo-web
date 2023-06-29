= page-title 'Account → Edit (Gender) - Mutambo' replace=true separator=' → '

div class='min-h-screen flex flex-col md:flex-row'

  % AppNav [
    @leagues=model.leagues
    @user=model.user
  ]

  .flex.w-full
    .flex.flex-col.p-8.w-full
      .flex.justify-between.items-center.border-b.border-neutral-100.mb-7
        h2.flex.font-bold style='padding-top: 2px; padding-bottom: 21px;' Account &rarr; Edit (Gender)

      .space-y-6 class='sm:w-full sm:max-w-md'
        div
          label.flex.items-center.justify-between for='gender'
            .font-medium.text-neutral-900 Gender
            button{on 'click' (fn this.toggleHelp 'gender')} class='mutambo-form-help-button' role='button' tabindex='0'
              % FaIcon @prefix='fas' @size='1x' @icon='question-circle'

          = if form.help.gender
            .bg-neutral-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
              ol.list-disc.ml-5.space-y-2
                li.text-neutral-600 Gender will be visible to league administrators.
                li.text-neutral-600 Leagues may require gender to meet insurance, legal, or other operational requirements.
                li.text-neutral-600 Gender should match the ID you use for game check-in.

          = if (and (not form.valid.gender) form.submitted)
            .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                ol.list-disc.ml-5.space-y-2
                  li.text-red-800 A gender is required.

          .mt-1.relative.rounded-md.shadow-sm
          .mt-1.block.w-full.rounded-md.border-neutral-300
            .mt-2
              div
                label.inline-flex.items-center class='cursor-pointer mb-2'
                  input{on 'input' (fn this.formValueChanged 'gender' 'female')} checked={eq this.form.values.gender 'female'} type='radio' name='radio-direct' class='form-radio border-neutral-300 text-sky-600 shadow-sm focus:border-sky-300 focus:ring focus:ring-offset-0 focus:ring-sky-200 focus:ring-opacity-50' value=this.form.values.gender
                  span.ml-2 Female
                div
                label.inline-flex.items-center class='cursor-pointer mb-2'
                  input{on 'input' (fn this.formValueChanged 'gender' 'male')} checked={eq this.form.values.gender 'male'} type='radio' name='radio-direct' class='form-radio border-neutral-300 text-sky-600 shadow-sm focus:border-sky-300 focus:ring focus:ring-offset-0 focus:ring-sky-200 focus:ring-opacity-50' value=this.form.values.gender
                  span.ml-2 Male
                div
                label.inline-flex.items-center class='cursor-pointer mb-2'
                  input{on 'input' (fn this.formValueChanged 'gender' 'other')} checked={eq this.form.values.gender 'other'} type='radio' name='radio-direct' class='form-radio border-neutral-300 text-sky-600 shadow-sm focus:border-sky-300 focus:ring focus:ring-offset-0 focus:ring-sky-200 focus:ring-opacity-50' value=this.form.values.gender
                  span.ml-2 Other



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
