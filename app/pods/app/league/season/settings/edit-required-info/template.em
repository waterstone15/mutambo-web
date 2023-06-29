= page-title (get this 'title_string') replace=true separator=' → '

div class='min-h-screen flex flex-col md:flex-row'

  % AppNav [
    @league=model.league
    @leagues=model.leagues
    @season=model.season
    @seasons=model.seasons
    @user=model.user
  ]

  .flex.w-full
    .flex.flex-col.w-full
      .px-8.flex.justify-between.items-center.border-b.border-neutral-100 class='min-h-[80px]'
        .inline-flex.items-center.flex-wrap class='md:h-[48px] py-4 md:py-0'
          % Breadcrumb [
            @arrow=false
            @goto={hash route='app.league.index' query=(hash league_id=model.league.meta.id)}
            @image={hash src=model.league.val.logo_url alt='League Logo'}
            @icon={hash transform='grow-0' icon='trophy' class='text-amber-400'}
            @text={or model.league.val.name 'League'}
          ]
          % Breadcrumb [
            @goto={hash route='app.league.season.index' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @icon={hash transform='grow-1' icon='sun' class='text-yellow-400'}
            @text={or model.season.val.name 'Season'}
          ]
          % Breadcrumb [
            @goto={hash route='app.league.season.settings' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @icon={hash transform='grow-2' icon='cogs' class='text-slate-400'}
            @text='Settings'
          ]
          % Breadcrumb [
            @goto={hash route='app.league.season.settings.edit-required-info' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @text='Required Information'
          ]

      .p-8

        .space-y-6 class='sm:w-full sm:max-w-md'
          div
            label.flex.items-center.justify-between for='info'
              .font-medium.text-neutral-900: | Required Information
              button{on 'click' (fn this.toggleHelp 'info')} class='mutambo-form-help-button' role='button' tabindex='0'
                % FaIcon @prefix='fas' @size='1x' @icon='question-circle'

            = if form.help.info
              .bg-neutral-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                ol.list-disc.ml-5.space-y-2
                  li.text-neutral-600
                    span When users register for
                    span.font-semibold {{' '}}{{model.league.val.name}}, {{model.season.val.name}}
                    span {{' '}}they will be required to provide the following information.

            = if (and (not form.valid.info) form.submitted)
              .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                  ol.list-disc.ml-5.space-y-2
                    li.text-red-800 A status is required.

            
            table.mt-1.w-full.table-auto.border-separate
              thead
                tr.border-b-1.border-t-1.border-neutral-200.rounded.overflow-hidden
                  th.bg-neutral-100.rounded-l: .pr-2.py-1.px-2.uppercase.text-neutral-800.text-sm.flex.items-start
                  / th.bg-neutral-100: .px-2.py-1.px-2.uppercase.text-neutral-800.text-sm Admins
                  th.bg-neutral-100: .px-2.py-1.px-2.uppercase.text-neutral-800.text-sm Managers
                  th.bg-neutral-100.rounded-r: .pl-2.py-1.px-2.uppercase.text-neutral-800.text-sm Players
              tbody
                tr
                  td: .pt-1.px-2.flex Address
                  / td: .flex.items-center.justify-center
                  /   button{on 'click' (fn this.toggleInfo 'admin.address')} class='mutambo-focus-sky w-[23px] h-[23px] border border-neutral-100 rounded hover:bg-neutral-100 inline-flex justify-center items-center'
                  /     = if (get this 'form.values.info.admin.address')
                  /       % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                  /     = else
                  /       % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .flex.items-center.justify-center
                    button{on 'click' (fn this.toggleInfo 'manager.address')} class='mutambo-focus-sky w-[23px] h-[23px] border border-neutral-100 rounded hover:bg-neutral-100 inline-flex justify-center items-center'
                      = if (get this 'form.values.info.manager.address')
                        % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                      = else
                        % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .flex.items-center.justify-center
                    button{on 'click' (fn this.toggleInfo 'player.address')} class='mutambo-focus-sky w-[23px] h-[23px] border border-neutral-100 rounded hover:bg-neutral-100 inline-flex justify-center items-center'
                      = if (get this 'form.values.info.player.address')
                        % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                      = else
                        % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                tr
                  td: .pt-1.px-2.flex Birthday
                  / td: .flex.items-center.justify-center
                  /   button{on 'click' (fn this.toggleInfo 'admin.birthday')} class='mutambo-focus-sky w-[23px] h-[23px] border border-neutral-100 rounded hover:bg-neutral-100 inline-flex justify-center items-center'
                  /     = if (get this 'form.values.info.admin.birthday')
                  /       % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                  /     = else
                  /       % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .flex.items-center.justify-center
                    button{on 'click' (fn this.toggleInfo 'manager.birthday')} class='mutambo-focus-sky w-[23px] h-[23px] border border-neutral-100 rounded hover:bg-neutral-100 inline-flex justify-center items-center'
                      = if (get this 'form.values.info.manager.birthday')
                        % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                      = else
                        % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .flex.items-center.justify-center
                    button{on 'click' (fn this.toggleInfo 'player.birthday')} class='mutambo-focus-sky w-[23px] h-[23px] border border-neutral-100 rounded hover:bg-neutral-100 inline-flex justify-center items-center'
                      = if (get this 'form.values.info.player.birthday')
                        % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                      = else
                        % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                tr
                  td: .pt-1.px-2.flex Display Name
                  / td: .flex.items-center.justify-center
                  /   button{on 'click' (fn this.toggleInfo 'admin.display_name')} class='mutambo-focus-sky w-[23px] h-[23px] border border-neutral-100 rounded hover:bg-neutral-100 inline-flex justify-center items-center'
                  /     = if (get this 'form.values.info.admin.display_name')
                  /       % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                  /     = else
                  /       % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .flex.items-center.justify-center
                    button{on 'click' (fn this.toggleInfo 'manager.display_name')} class='mutambo-focus-sky w-[23px] h-[23px] border border-neutral-100 rounded hover:bg-neutral-100 inline-flex justify-center items-center'
                      = if (get this 'form.values.info.manager.display_name')
                        % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                      = else
                        % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .flex.items-center.justify-center
                    button{on 'click' (fn this.toggleInfo 'player.display_name')} class='mutambo-focus-sky w-[23px] h-[23px] border border-neutral-100 rounded hover:bg-neutral-100 inline-flex justify-center items-center'
                      = if (get this 'form.values.info.player.display_name')
                        % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                      = else
                        % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                / tr
                /   td: .pt-1.px-2.flex Email
                /   / td: .flex.items-center.justify-center
                /   /   button{on 'click' (fn this.toggleInfo 'admin.email')} class='mutambo-focus-sky w-[23px] h-[23px] border border-neutral-100 rounded hover:bg-neutral-100 inline-flex justify-center items-center'
                /   /     = if (get this 'form.values.info.admin.email')
                /   /       % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                /   /     = else
                /   /       % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                /   td: .flex.items-center.justify-center
                /     button{on 'click' (fn this.toggleInfo 'manager.email')} class='mutambo-focus-sky w-[23px] h-[23px] border border-neutral-100 rounded hover:bg-neutral-100 inline-flex justify-center items-center'
                /       = if (get this 'form.values.info.manager.email')
                /         % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                /       = else
                /         % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                /   td: .flex.items-center.justify-center
                /     button{on 'click' (fn this.toggleInfo 'player.email')} class='mutambo-focus-sky w-[23px] h-[23px] border border-neutral-100 rounded hover:bg-neutral-100 inline-flex justify-center items-center'
                /       = if (get this 'form.values.info.player.email')
                /         % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                /       = else
                /         % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                tr
                  td: .pt-1.px-2.flex Full Name
                  / td: .flex.items-center.justify-center
                  /   button{on 'click' (fn this.toggleInfo 'admin.full_name')} class='mutambo-focus-sky w-[23px] h-[23px] border border-neutral-100 rounded hover:bg-neutral-100 inline-flex justify-center items-center'
                  /     = if (get this 'form.values.info.admin.full_name')
                  /       % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                  /     = else
                  /       % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .flex.items-center.justify-center
                    button{on 'click' (fn this.toggleInfo 'manager.full_name')} class='mutambo-focus-sky w-[23px] h-[23px] border border-neutral-100 rounded hover:bg-neutral-100 inline-flex justify-center items-center'
                      = if (get this 'form.values.info.manager.full_name')
                        % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                      = else
                        % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .flex.items-center.justify-center
                    button{on 'click' (fn this.toggleInfo 'player.full_name')} class='mutambo-focus-sky w-[23px] h-[23px] border border-neutral-100 rounded hover:bg-neutral-100 inline-flex justify-center items-center'
                      = if (get this 'form.values.info.player.full_name')
                        % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                      = else
                        % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                tr
                  td: .pt-1.px-2.flex Gender
                  / td: .flex.items-center.justify-center
                  /   button{on 'click' (fn this.toggleInfo 'admin.gender')} class='mutambo-focus-sky w-[23px] h-[23px] border border-neutral-100 rounded hover:bg-neutral-100 inline-flex justify-center items-center'
                  /     = if (get this 'form.values.info.admin.gender')
                  /       % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                  /     = else
                  /       % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .flex.items-center.justify-center
                    button{on 'click' (fn this.toggleInfo 'manager.gender')} class='mutambo-focus-sky w-[23px] h-[23px] border border-neutral-100 rounded hover:bg-neutral-100 inline-flex justify-center items-center'
                      = if (get this 'form.values.info.manager.gender')
                        % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                      = else
                        % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .flex.items-center.justify-center
                    button{on 'click' (fn this.toggleInfo 'player.gender')} class='mutambo-focus-sky w-[23px] h-[23px] border border-neutral-100 rounded hover:bg-neutral-100 inline-flex justify-center items-center'
                      = if (get this 'form.values.info.player.gender')
                        % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                      = else
                        % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                tr
                  td: .pt-1.px-2.flex Phone
                  / td: .flex.items-center.justify-center
                  /   button{on 'click' (fn this.toggleInfo 'admin.phone')} class='mutambo-focus-sky w-[23px] h-[23px] border border-neutral-100 rounded hover:bg-neutral-100 inline-flex justify-center items-center'
                  /     = if (get this 'form.values.info.admin.phone')
                  /       % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                  /     = else
                  /       % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .flex.items-center.justify-center
                    button{on 'click' (fn this.toggleInfo 'manager.phone')} class='mutambo-focus-sky w-[23px] h-[23px] border border-neutral-100 rounded hover:bg-neutral-100 inline-flex justify-center items-center'
                      = if (get this 'form.values.info.manager.phone')
                        % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                      = else
                        % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'

                  td: .flex.items-center.justify-center
                    button{on 'click' (fn this.toggleInfo 'player.phone')} class='mutambo-focus-sky w-[23px] h-[23px] border border-neutral-100 rounded hover:bg-neutral-100 inline-flex justify-center items-center'
                      = if (get this 'form.values.info.player.phone')
                        % FaIcon @prefix='fas' @size='1x' @transform='grow-2' @icon='check' class='text-neutral-600'
                      = else
                        % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='minus' class='text-neutral-300'





        .mt-8.space-x-3
          button{on 'click' (fn this.save)} class='bg-green-500 border border-green-500 font-medium hover:border-green-600 hover:pointer inline-flex mutambo-focus-sky px-4 py-2 rounded-md shadow-sm text-white' role='button' tabindex='0'
            span Save

          % LinkTo [
            @route='app.league.season.settings'
            @query={hash league_id=model.league.meta.id season_id=model.season.meta.id}
            class='bg-white border border-neutral-200 font-medium hover:border-neutral-300 hover:pointer inline-flex mutambo-focus-sky px-4 py-2 rounded-md shadow-sm'
            role='link'
            tabindex='0'
          ]
            | Cancel
