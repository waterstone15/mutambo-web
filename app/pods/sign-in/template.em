= page-title 'Sign In - Mutambo' replace=true separator=' → '

.min-w-screen.min-h-screen
  .flex.flex-col.justify-between.w-screen.min-h-screen.bg-neutral-100

    % TopNav @isLoggedIn=this.model.isLoggedIn

    .flex.flex-col
      .flex.flex-col.justify-center.pt-4.pb-80 class='sm:px-6 lg:px-8'

        .flex.justify-center
          .logo.sign-in

        div class='sm:mx-auto sm:w-full sm:max-w-md'
          h2.mt-6.text-center.text-2xl.font-extrabold.text-neutral-900 Sign In

        .mt-8 class='sm:mx-auto sm:w-full sm:max-w-md'
          .bg-white.border.border-neutral-200.px-6.py-10.mx-2.rounded-lg class='sm:rounded-lg sm:px-10'
            .space-y-6
              = if msg
                .bg-orange-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                  ol.list-disc.ml-5.space-y-2
                    li.text-black = msg
              div
                label.flex.items-center.justify-between for='email'
                  .font-medium.text-neutral-900 Email
                  button{on 'click' (fn this.toggleHelp 'email')} class='mutambo-form-help-button' role='button' tabindex='0'
                    % FaIcon @prefix='fas' @size='1x' @icon='question-circle'


                = if form.help.email
                  .bg-neutral-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                    ol.list-disc.ml-5.space-y-2
                      li.text-neutral-600 Use the same email each time you sign in to Mutambo.
                      li.text-neutral-600 Use your email, not a shared email.

                = if (and (not form.valid.email) form.submitted)
                  .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                      ol.list-disc.ml-5.space-y-2
                        li.text-red-800 Please use a valid email address.

                .mt-1.relative.rounded-md.shadow-sm
                  .absolute.inset-y-0.left-0.pl-3.flex.items-center.pointer-events-none
                    % FaIcon @prefix='fas' @fixedWidth=true @size='1x' class='text-neutral-300' @icon='envelope'
                  % Input{on 'input' (fn this.formValueChanged 'email')}{on 'keydown' (fn this.formKeyPress 'email')} @type='text' @value=form.values.email autofocus=true class='form-input pl-10 mt-1 block w-full rounded-md border-neutral-300 mutambo-focus-sky' placeholder=''

              div
                button{on 'click' (fn this.sendCodeEmail)} class='w-full flex justify-between py-2 px-2 border border-transparent rounded-md shadow-sm font-medium text-white bg-sky-600 hover:bg-sky-700 mutambo-focus-sky-dark' role='button' tabindex='0'
                  span.w-6
                  span Next
                  = if form.ok
                    span.flex.justify-center.items-center.w-6.h-6.border.border-sky-800.bg-sky-700.shadow-sm.rounded.text-neutral-500 class='sm:text-sm'
                      span.mt-1.text-neutral-100 &#9166;
                  = else
                    span.w-6

          p.my-4.px-8.pb-2.italic.text-neutral-400.text-center If you are new to Mutambo, an account will automatically be created.

    div

  % Footer