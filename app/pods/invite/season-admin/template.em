= page-title 'Admin Invite - Mutambo' replace=true separator=' → '

.min-w-screen.min-h-screen
  .flex.flex-col.justify-between.w-screen.min-h-screen.bg-neutral-100

    % TopNav @isLoggedIn=this.model.isLoggedIn

    .flex.flex-col
      .flex.flex-col.justify-center.py-8 class='sm:px-6 lg:px-8'

        .flex.justify-center
          .w-32.h-32.rounded-full.flex.items-center.justify-center.bg-white.border.border-neutral-200
            % FaIcon class='text-yellow-400' @fixedWidth=true @icon='sun' @prefix='fas' @size='3x' @transform='grow-0'

        div class='sm:mx-auto sm:w-full sm:max-w-md'
          h2.mt-6.mx-6.text-center.text-2xl.font-extrabold.text-neutral-900 Season Administrator
          = if model.season
            h2.mt-2.mx-6.text-center.text-xl.font-medium.text-neutral-900 {{model.league.val.name}}, {{model.season.val.name}}

        .mt-8.mb-32 class='sm:mx-auto sm:w-full sm:max-w-md'
          .bg-white.border.border-neutral-200.px-6.py-10.mx-2.rounded-lg class='sm:rounded-lg sm:px-10'
            = if (and model.season season.val.is_admin)
              p.text-center
                span You are already an administrator of
                span.font-semibold {{' '}}{{model.season.val.name}}, {{model.league.val.name}}
                span !
            = else if model.season
              p
                span You are invited to be an administrator of the{{' '}}
                span.font-semibold {{model.league.val.name}}, {{model.season.val.name}}
                span {{' '}}season.
            = else
              p This invite link is not valid. Please contact a season administrator and ask them for a new link.

            .flex.flex-row.mt-6.space-x-2
              button{on 'click' (fn this.ignore)} class='w-full flex justify-center py-2 px-2 border border-neutral-200 rounded-md shadow-sm font-medium text-neutral-900 bg-white hover:border-neutral-300 hover:bg-neutral-50 mutambo-focus-sky' role='button' tabindex='0'
                span Ignore
              button{on 'click' (fn this.accept)} class='w-full flex justify-center py-2 px-2 border border-transparent rounded-md shadow-sm font-medium text-white bg-sky-600 hover:bg-sky-700 mutambo-focus-sky-dark' role='button' tabindex='0'
                span Accept



    div

  % Footer
