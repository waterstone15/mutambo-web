= page-title 'Sign In → Link Verification - Mutambo' replace=true separator=' → '

.min-w-screen.min-h-screen
  .flex.flex-col.justify-between.w-screen.min-h-screen.bg-neutral-100

    % TopNav

    .flex.flex-col
      .flex.flex-col.justify-center.pt-4.pb-80 class='sm:px-6 lg:px-8'

        .flex.justify-center
          .logo.sign-in

        div class='sm:mx-auto sm:w-full sm:max-w-md'
          h2.mt-6.text-center.text-2xl.font-extrabold.text-neutral-900 Sign In Link Verification

        .mt-8 class='sm:mx-auto sm:w-full sm:max-w-md'
          .bg-white.border.border-neutral-200.px-6.py-10.mx-2.rounded-lg class='sm:rounded-lg sm:px-10'
            p.mb-2 You will be redirected momentarily.
            p If not, the sign in link may have expired. Please try again.
            % LinkTo [
              @route='sign-in'
              class='inline-block mt-6 px-4 py-2 rounded-md bg-white border border-neutral-200 font-medium shadow-sm hover:border-neutral-400 hover:pointer'
            ]
              | Back

    div

  % Footer