= page-title 'Sign In Await - Mutambo' replace=true separator=' → '

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
            p.mb-2 An email was sent to your inbox. Please click the link in your email to sign in.
            p You may close this window.
            % LinkTo [
              @route='sign-in'
              class='bg-white border border-neutral-200 font-medium hover:border-neutral-300 hover:pointer inline-flex mt-6 mutambo-focus-sky px-4 py-2 rounded-md shadow-sm'
              role='link'
              tabindex='0'
            ]
              | Back

    div

  % Footer