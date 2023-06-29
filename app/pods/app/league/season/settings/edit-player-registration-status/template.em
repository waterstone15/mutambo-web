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
            @goto={hash route='app.league.season.settings.edit-player-registration-status' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @text='Player Registration'
          ]

      .p-8

        .space-y-6 class='sm:w-full sm:max-w-md'
          div
            label.flex.items-center.justify-between for='status'
              .font-medium.text-neutral-900 Player Registration
              button{on 'click' (fn this.toggleHelp 'status')} class='mutambo-form-help-button' role='button' tabindex='0'
                % FaIcon @prefix='fas' @size='1x' @icon='question-circle'


            = if form.help.status
              .bg-neutral-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                ol.list-disc.ml-5.space-y-2
                  li.text-neutral-600
                    span When player registration is open players can register for team(s) in the
                    span.font-semibold {{' '}}{{model.league.val.name}}, {{model.season.val.name}}
                    span {{' '}}season.



            = if (and (not form.valid.status) form.submitted)
              .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                  ol.list-disc.ml-5.space-y-2
                    li.text-red-800 A status is required.

            .mt-1.block.w-full.rounded-md.border-neutral-300
              .mt-2
                div
                  label.inline-flex.items-center class='cursor-pointer mb-2'
                    input{on 'input' (fn this.formValueChanged 'status' 'open')} checked={eq this.form.values.status 'open'} type='radio' name='radio-direct' class='form-radio border-neutral-300 text-sky-600 shadow-sm focus:border-sky-300 focus:ring focus:ring-offset-0 focus:ring-sky-200 focus:ring-opacity-50' value=this.form.values.status
                    span.ml-2 Open
                  div
                  label.inline-flex.items-center class='cursor-pointer mb-2'
                    input{on 'input' (fn this.formValueChanged 'status' 'closed')} checked={eq this.form.values.status 'closed'} type='radio' name='radio-direct' class='form-radio border-neutral-300 text-sky-600 shadow-sm focus:border-sky-300 focus:ring focus:ring-offset-0 focus:ring-sky-200 focus:ring-opacity-50' value=this.form.values.status
                    span.ml-2 Closed

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
