= page-title (get this 'title_string') replace=true separator=' → '

.min-w-screen.min-h-screen
  .flex.flex-col.justify-between.w-screen.min-h-screen.bg-neutral-100

    % TopNav @isLoggedIn=this.model.isLoggedIn

    .flex.flex-col
      .flex.flex-col.justify-center.pt-4.pb-80 class='sm:px-6 lg:px-8'

        .flex.justify-center
          .w-32.h-32.rounded-full.flex.items-center.justify-center.text-purple-400.bg-white.border.border-neutral-200
            % FaIcon @prefix='fas' @size='3x' @icon='tshirt'


        div class='sm:mx-auto sm:w-full sm:max-w-md'
        h2.mt-6.mx-6.text-center.text-2xl.font-extrabold.text-neutral-900 Player Registration
        h3.mt-3.mx-6.text-center.text-lg.font-medium.text-neutral-900
          = if (get this 'model.illstp.val.league.val.name')
            | {{get this 'model.illstp.val.league.val.name'}}
          = if (get this 'model.illstp.val.season.val.name')
            | {{', '}}{{get this 'model.illstp.val.season.val.name'}}
          = if (get this 'model.illstp.val.team.val.name')
            | {{' • '}}{{get this 'model.illstp.val.team.val.name'}}

        .mt-8 class='sm:mx-auto sm:w-full sm:max-w-md'
          .bg-white.border.border-neutral-200.px-6.py-10.mx-2.rounded-lg class='sm:rounded-lg sm:px-10'

            = if (eq illstp.val.season.val.settings.player_registration_status 'closed')
              p.text-center Player registration is closed.

            = else if (gte (get model 'illstp.val.team.val.player_count') (get model 'illstp.val.season.val.settings.team_player_limit'))
              p.text-center Player limit reached.

            = else
              .space-y-6

                div
                  label.flex.items-center.justify-between for='full_name'
                    .font-medium.text-neutral-900 Full Name
                    button{on 'click' (fn this.toggleHelp 'full_name')} class='mutambo-form-help-button' role='button' tabindex='0'
                      % FaIcon @prefix='fas' @size='1x' @icon='question-circle'


                  = if form.help.full_name
                    .bg-neutral-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                      ol.list-disc.ml-5.space-y-2
                        li.text-neutral-600 Your full name will be used on official game sheets.
                        li.text-neutral-600 Your full name will be visible to league administrators and officials.
                        li.text-neutral-600 If your leauge uses IDs at game check-in, this should match your ID.

                  = if (and (not form.valid.full_name) form.submitted)
                    .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                        ol.list-disc.ml-5.space-y-2
                          li.text-red-800 A full name is required.

                  .mt-1.relative.rounded-md.shadow-sm
                    % Input{on 'input' (fn this.formValueChanged 'full_name')}{on 'keydown' (fn this.formKeyPress 'full_name')} @type='text' @value=form.values.full_name autofocus=true class='block border-neutral-300 form-input mt-1 mutambo-focus-sky rounded-md w-full' placeholder=''

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
                    % Input{on 'input' (fn this.formValueChanged 'display_name')}{on 'keydown' (fn this.formKeyPress 'display_name')} @type='text' @value=form.values.display_name autofocus=true class='block border-neutral-300 form-input mt-1 mutambo-focus-sky rounded-md w-full' placeholder=''

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
                    .flex.w-full.-space-x-px.rounded-md.shadow-sm
                      .flex-1
                        label.sr-only for='birthday-year' Year
                        % Input{on 'input' (fn this.formValueChanged 'birthday.year')}{on 'keydown' (fn this.formKeyPress 'birthday.year')} @type='number' @value=form.values.birthday.year name='birthday-year' class='form-input bg-transparent block border-neutral-300 mutambo-focus-sky focus:z-10 relative rounded-bl-md rounded-none rounded-tl-md w-full' placeholder='' min=1000 max=3000
                      .flex-1
                        label.sr-only for='birthday-month' Month
                        % Input{on 'input' (fn this.formValueChanged 'birthday.month')}{on 'keydown' (fn this.formKeyPress 'birthday.month')} @type='number' @value=form.values.birthday.month name='birthday-month' class='form-input bg-transparent block border-neutral-300 mutambo-focus-sky focus:z-10 relative rounded-none w-full' placeholder='' min=1 max=12
                      .flex-1
                        label.sr-only for='birthday-day' Day
                        % Input{on 'input' (fn this.formValueChanged 'birthday.day')}{on 'keydown' (fn this.formKeyPress 'birthday.day')} @type='number' @value=form.values.birthday.day name='birthday-day' class='form-input bg-transparent block border-neutral-300 mutambo-focus-sky focus:z-10 relative rounded-tr-md rounded-none rounded-br-md w-full' placeholder='' min=1 max=31

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


                div
                  label.flex.items-center.justify-between for='address'
                    .font-medium.text-neutral-900 Address
                    button{on 'click' (fn this.toggleHelp 'address')} class='mutambo-form-help-button' role='button' tabindex='0'
                      % FaIcon @prefix='fas' @size='1x' @icon='question-circle'

                  = if msg.update_after.show
                    .bg-amber-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                        ol.list-disc.ml-5.space-y-2
                          li.text-amber-800
                            | You can only change your address occasionally. It can be changed again in{{' '}}
                            = get this 'msg.update_after.days'
                            | {{' '}}days.

                  = if form.help.address
                    .bg-neutral-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                      ol.list-disc.ml-5.space-y-2
                        li.text-neutral-600 Your address will be visible to league administrators.
                        li.text-neutral-600 Leagues may require your address to meet insurance or other legal requirements.
                        li.text-neutral-600 Your address should match the ID you use for game check-in.


                  = if (and (not form.valid.address) form.submitted)
                    .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                        ol.list-disc.ml-5.space-y-2
                          li.text-red-800 An address is required.

                  .mt-1.relative.rounded-md.shadow-sm
                  .mt-1.block.w-full.rounded-md.border-neutral-300
                    % Textarea{on 'input' (fn this.formValueChanged 'address')}{on 'keydown' (fn this.formKeyPress 'address')} @value=form.values.address autofocus=true class='block border-neutral-300 form-input mt-1 mutambo-focus-sky rounded-md w-full' placeholder='' rows='4'

                div
                  label.flex.items-center.justify-between for='phone'
                    .font-medium.text-neutral-900 Phone Number
                    button{on 'click' (fn this.toggleHelp 'phone')} class='mutambo-form-help-button' role='button' tabindex='0'
                      % FaIcon @prefix='fas' @size='1x' @icon='question-circle'


                  = if form.help.phone
                    .bg-neutral-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                      ol.list-disc.ml-5.space-y-2
                        li.text-neutral-600 Your phone number will be visible to league administrators.
                        li.text-neutral-600 Leagues may require a phone number to meet insurance, legal, or other operational requirements.

                  = if (and (not form.valid.phone) form.submitted)
                    .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                        ol.list-disc.ml-5.space-y-2
                          li.text-red-800 A phone number is required.

                  .mt-1.relative.rounded-md.shadow-sm
                    % Input{on 'input' (fn this.formValueChanged 'phone')}{on 'keydown' (fn this.formKeyPress 'phone')} @type='text' @value=form.values.phone autofocus=true class='block border-neutral-300 form-input mt-1 mutambo-focus-sky rounded-md w-full' placeholder=''


                div
                  button{on 'click' (fn this.register)} class=' w-full flex justify-between py-2 px-2 border border-transparent rounded-md shadow-sm font-medium text-white bg-sky-600 hover:bg-sky-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-sky-500'
                    span.w-6
                    span Register
                    / = if form.ok
                    /   span.flex.justify-center.items-center.w-6.h-6.border.border-sky-800.bg-sky-700.shadow-sm.rounded.text-neutral-500 class='sm:text-sm'
                    /     span.mt-1.text-neutral-100 &#9166;
                    / = else
                    span.w-6

    div

  % Footer