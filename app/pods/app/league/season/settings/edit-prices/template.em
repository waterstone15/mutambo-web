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
            @goto={hash route='app.league.season.settings.edit-prices' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @text='Fees'
          ]

      .p-8

        .space-y-6 class='sm:w-full sm:max-w-md'
          div
            label.flex.items-center.justify-between for='prices'
              .font-medium.text-neutral-900 Fees
              button{on 'click' (fn this.toggleHelp 'prices')} class='mutambo-form-help-button' role='button' tabindex='0'
                % FaIcon @prefix='fas' @size='1x' @icon='question-circle'

            = if form.help.prices
              .bg-neutral-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                ol.list-disc.ml-5.space-y-2
                  li.text-neutral-600
                    span When users register for
                    span.font-semibold {{' '}}{{model.league.val.name}}, {{model.season.val.name}}
                    span {{' '}}they will automatically charged according to the table below.
                  li.text-neutral-600
                    span Fees must be a positive number.
                  / li.text-neutral-600
                  /   span Fees are truncated to 2 decimal places
                  /   br
                  /   span.italic Eg. 10.035 → 10.03

            = if (and (not form.valid.prices) form.submitted)
              .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                  ol.list-disc.ml-5.space-y-2
                    li.text-red-800 A status is required.

            
            table.mt-1.w-full.table-auto.border-separate
              thead
                tr.border-b-1.border-t-1.border-neutral-200.rounded.overflow-hidden
                  th.bg-neutral-100.rounded-l: .pr-2.py-1.px-2.uppercase.text-neutral-800.text-sm.flex.items-start class='min-w-[120px]'
                  th.bg-neutral-100.text-right: .px-2.py-1.px-2.uppercase.text-neutral-800.text-sm Standard
                  th.bg-neutral-100.rounded-r.text-right: .pl-2.py-1.px-2.uppercase.text-neutral-800.text-sm Returning
              tbody
                tr
                  td: .pt-1.px-2.flex Team × Season
                  td: .flex.items-center.justify-center
                    span.mr-1.ml-2.font-medium $
                    % Input{on 'input' (fn this.formValueChanged 'prices.team_per_season.default')}{on 'keydown' (fn this.formKeyPress 'prices.team_per_season.default')} @type='text' @value=form.values.prices.team_per_season.default class='form-input block w-full rounded border-neutral-300 mutambo-focus-sky px-1 py-px text-right mr-2 font-mono' placeholder=''

                  td: .flex.items-center.justify-center
                    span.mr-1.ml-2.font-medium $
                    % Input{on 'input' (fn this.formValueChanged 'prices.team_per_season.returning')}{on 'keydown' (fn this.formKeyPress 'prices.team_per_season.returning')} @type='text' @value=form.values.prices.team_per_season.returning class='form-input block w-full rounded border-neutral-300 mutambo-focus-sky px-1 py-px text-right mr-2 font-mono' placeholder=''

                tr
                  td: .pt-1.px-2.flex Player × Season
                  td: .flex.items-center.justify-center
                    span.mr-1.ml-2.font-medium $
                    % Input{on 'input' (fn this.formValueChanged 'prices.player_per_season.default')}{on 'keydown' (fn this.formKeyPress 'prices.player_per_season.default')} @type='text' @value=form.values.prices.player_per_season.default class='form-input block w-full rounded border-neutral-300 mutambo-focus-sky px-1 py-px text-right mr-2 font-mono' placeholder=''

                  td: .flex.items-center.justify-center
                    span.mr-1.ml-2.font-medium $
                    % Input{on 'input' (fn this.formValueChanged 'prices.player_per_season.returning')}{on 'keydown' (fn this.formKeyPress 'prices.player_per_season.returning')} @type='text' @value=form.values.prices.player_per_season.returning class='form-input block w-full rounded border-neutral-300 mutambo-focus-sky px-1 py-px text-right mr-2 font-mono' placeholder=''



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
