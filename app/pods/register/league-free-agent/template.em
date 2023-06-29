= page-title 'Free Agent Registration - Mutambo' replace=true separator=' → '

.min-w-screen.min-h-screen
  .flex.flex-col.justify-between.w-screen.min-h-screen.bg-neutral-100

    % TopNav @isLoggedIn=true

    .flex.flex-col
      .flex.flex-col.justify-center.pt-4.pb-80 class='sm:px-6 lg:px-8'

        .flex.justify-center
          .w-32.h-32.rounded-full.flex.items-center.justify-center.bg-white.border.border-neutral-200
            % FaIcon class='text-stone-400' @fixedWidth=true @icon='clipboard' @prefix='fas' @size='3x' @transform='grow-0'


        div class='sm:mx-auto sm:w-full sm:max-w-md'
          h2.mt-6.mx-6.text-center.text-2xl.font-extrabold.text-neutral-900 Free Agent Registration
          = if model.league
            h2.mt-2.mx-6.text-center.text-xl.font-medium.text-neutral-900 {{model.league.val.name}}

        .mt-8 class='sm:mx-auto sm:w-full sm:max-w-md'
          .bg-white.border.border-neutral-200.px-6.py-10.mx-2.rounded-lg class='sm:rounded-lg sm:px-10'

            / = if (eq model.illst.val.season.val.settings.team_registration_status 'closed')
            /   p.text-center Team registration is closed.

            / = else
            .space-y-6
              div
                label.flex.items-center.justify-between for='display_name'
                  .font-medium.text-neutral-900 Display Name
                  button{on 'click' (fn this.toggleHelp 'display_name')} class='ml-2 p-2 rounded-full flex items-center justify-center text-neutral-500 hover:bg-neutral-200 hover:text-neutral-700 focus:outline-none focus:ring-2 focus:ring-sky-500'
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
                  % Input{on 'input' (fn this.formValueChanged 'display_name')}{on 'keydown' (fn this.formKeyPress 'display_name')} @type='text' @value=form.values.display_name autofocus=true class='form-input mt-1 block w-full rounded-md border-neutral-300 focus:border-sky-300 focus:ring focus:ring-sky-200 focus:ring-opacity-50' placeholder=''


              div
                label.flex.items-center.justify-between for='about'
                  .font-medium.text-neutral-900 About
                  button{on 'click' (fn this.toggleHelp 'about')} class='ml-2 p-2 rounded-full flex items-center justify-center text-neutral-500 hover:bg-neutral-200 hover:text-neutral-700 focus:outline-none focus:ring-2 focus:ring-sky-500'
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
                        li.text-red-800 About is required.

                .mt-1
                  % Textarea{on 'input' (fn this.formValueChanged 'about')} class='form-textarea font-sans mt-1 block w-full rounded-md border-neutral-300 focus:border-sky-300 focus:ring focus:ring-sky-200 focus:ring-opacity-50' name='about' rows='4' @value=form.values.about

              div
                button{on 'click' (fn this.register)} class='mutambo-focus-sky-dark w-full flex justify-between py-2 px-2 border border-transparent rounded-md shadow-sm font-medium text-white bg-sky-600 hover:bg-sky-700'
                  span.w-6
                  span Register
                  span.w-6

    div

  % Footer