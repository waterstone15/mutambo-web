= page-title 'Player Invite - Mutambo' replace=true separator=' → '

.min-w-screen.min-h-screen
  .flex.flex-col.justify-between.w-screen.min-h-screen.bg-neutral-100

    % TopNav @isLoggedIn=this.model.isLoggedIn

    .flex.flex-col
      .flex.flex-col.justify-center.py-8 class='sm:px-6 lg:px-8'

        .flex.justify-center
          .w-32.h-32.rounded-full.flex.items-center.justify-center.bg-white.border.border-neutral-200
            % FaIcon class='text-emerald-400' @fixedWidth=true @icon='tshirt' @prefix='fas' @size='3x' @transform='grow-0'

        div class='sm:mx-auto sm:w-full sm:max-w-md'
          h2.mt-6.mx-6.text-center.text-2xl.font-extrabold.text-neutral-900: | Team Player
          h2.mt-2.mx-6.text-center.text-xl.font-medium.text-neutral-900
            = if model.itp.val.team.val.name
              | {{model.itp.val.team.val.name}}
            = if model.itp.val.league.val.name
              | {{' • '}}{{model.itp.val.league.val.name}}
            = if model.itp.val.season.val.name
              | {{', '}}{{model.itp.val.season.val.name}}

        .mt-8.mb-32 class='sm:mx-auto sm:w-full sm:max-w-md'
          .bg-white.border.border-neutral-200.px-6.py-10.mx-2.rounded-lg class='sm:rounded-lg sm:px-10'
            = if model.itp
              p
                | You are invited to be a player on
                | {{' '}}
                span.font-semibold {{model.itp.val.team.val.name}}
                = if model.itp.val.league.val.name
                  | {{' in the '}}
                  span.font-semibold {{model.itp.val.league.val.name}}
                = if model.itp.val.season.val.name
                  | {{', '}}
                  span.font-semibold {{model.itp.val.season.val.name}}
                  | {{' '}}season.
            = else
              p: | This invite link is not valid. Please contact a team manager and ask them for a new link.

            .flex.flex-row.mt-6.space-x-2
              % LinkTo [
                @route='app.teams'
                class='w-full flex justify-center py-2 px-2 border border-neutral-200 rounded-md shadow-sm font-medium text-neutral-900 bg-white hover:border-neutral-300 hover:bg-neutral-50 mutambo-focus-sky'
                role='link'
                tabindex='0'
              ]
                span: | Ignore

              a href='/register/team-player{{model.hash}}' class='w-full flex justify-center py-2 px-2 border border-transparent rounded-md shadow-sm font-medium text-white bg-sky-600 hover:bg-sky-700 mutambo-focus-sky-dark' role='link' tabindex='0'
                span: | Continue



    div

  % Footer
