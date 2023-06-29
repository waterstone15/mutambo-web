= page-title 'Payment → Failure'  replace=true separator=' → '

.min-w-screen.min-h-screen
  .flex.flex-col.justify-between.w-screen.min-h-screen.bg-neutral-100

    % TopNav @isLoggedIn=this.model.isLoggedIn

    .flex.flex-col
      .flex.flex-col.justify-center.py-8 class='sm:px-6 lg:px-8'

        .flex.justify-center
            .w-32.h-32.rounded-full.flex.items-center.justify-center.bg-white.border.border-neutral-200
              % FaIcon class='text-red-400' @fixedWidth=true @icon='times' @prefix='fas' @size='3x' @transform='grow-0'

        div class='sm:mx-auto sm:w-full sm:max-w-md'
          h2.mt-6.mx-6.text-center.text-2xl.font-extrabold.text-neutral-900 Payment Failed

        .mt-8.mb-32 class='sm:mx-auto sm:w-full sm:max-w-md'
          .bg-white.border.border-neutral-200.px-6.py-10.mx-2.rounded-lg class='sm:rounded-lg sm:px-10'
            p.pb-2 Something went wrong, please try again later.
            p.pb-2
              | If you are having persistent trouble, please send a message to
              | {{' '}}
              a.text-sky-600 class='hover:text-sky-800 hover:pointer hover:underline' href='mailto:hello@mutambo.com' hello@mutambo.com
              | .
            p

    div

  % Footer
