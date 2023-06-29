= page-title 'Pay - Mutambo' replace=true separator=' → '

.min-w-screen.min-h-screen
  .flex.flex-col.justify-between.w-screen.min-h-screen.bg-neutral-100

    % TopNav @isLoggedIn=model.isLoggedIn

    .flex.flex-col
      .flex.flex-col.justify-center.py-8 class='sm:px-6 lg:px-8'

        .flex.justify-center
          .w-32.h-32.rounded-full.flex.items-center.justify-center.text-green-500.bg-white.border.border-neutral-200
            % FaIcon class='text-green-500' @fixedWidth=true @icon='money-bill' @prefix='fas' @size='1x' @transform='grow-28'

        div class='sm:mx-auto sm:w-full sm:max-w-md'
          h2.mt-6.mx-6.text-center.text-2xl.font-extrabold.text-neutral-900 Payment


        .mt-8.mb-32 class='sm:mx-auto sm:w-full sm:max-w-md'
          .bg-white.border.border-neutral-200.px-6.py-10.mx-2.rounded-lg class='sm:rounded-lg sm:px-10'
            .space-y-8
              div
                .flex.items-center.justify-between
                  .font-semibold.text-neutral-900 Description
                  span
                .mt-1.relative.rounded-md
                  p = model.payment.val.description
              div
                .flex
                  .font-semibold.text-neutral-900 Items
                = each (get model 'payment.ui.items') as |item|
                  .flex.mt-1
                    .item-name.mr-1.whitespace-nowrap = item.name
                    .flex-grow.whitespace-nowrap.overflow-hidden.text-neutral-400 ..............................................................................................................................................................
                    .flex-shrink.ml-1
                      = item.amount
              div
                .flex.py-2.border-t.border-b.border-neutral-200
                  .item-name.mr-1.font-semibold Total
                  .flex-grow.whitespace-nowrap.overflow-hidden.text-neutral-400
                  .flex-shrink.ml-1.font-semibold
                    = model.payment.ui.total

            div.pt-10
              = if (eq model.payment.val.status 'paid')
                .flex.flex-center.justify-center.border.border-green-500.py-2.px-4.rounded-md.bg-green-500.bg-opacity-10
                  .flex.items-center.mr-2
                    % FaIcon class='text-green-700' @fixedWidth=true @icon='check' @prefix='fas' @size='1x' @transform='grow-4'
                  .inline-flex.font-bold.text-green-700: | Paid
              = else if (eq model.payment.val.status 'refunded')
                .flex.flex-center.justify-center.border.border-red-500.py-2.px-4.rounded-md.bg-red-500.bg-opacity-10
                  .flex.items-center.mr-2
                    % FaIcon class='text-red-700' @fixedWidth=true @icon='rotate-left' @prefix='fas' @size='1x' @transform='grow-4'
                  .inline-flex.font-bold.text-red-700: | Refunded
              = else
                button{on 'click' (fn this.pay)} class='mutambo-focus-sky w-full flex justify-center py-2 px-4 border border-transparent rounded-md font-medium text-white bg-sky-600 hover:bg-sky-700'
                  | Pay

    div

  % Footer
