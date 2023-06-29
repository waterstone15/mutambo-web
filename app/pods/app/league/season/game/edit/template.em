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
            @goto={hash route='app.league.season.games' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @icon={hash transform='grow-2' icon='futbol' prefix='fa-regular' class='text-red-400'}
            @text='Games'
          ]
          % Breadcrumb [
            @goto={hash route='app.league.season.game.edit' query=(hash game_id=model.game.meta.id league_id=model.league.meta.id season_id=model.season.meta.id)}
            @text='Edit Game'
          ]

      .p-8

        .space-y-6 class='sm:w-full sm:max-w-md'
          div
            label.flex.items-center.justify-between for='limit'
              .font-medium.text-neutral-900: | Location
              / button{on 'click' (fn this.toggleHelp 'limit')} class='mutambo-form-help-button' role='button' tabindex='0'
              /   % FaIcon @prefix='fas' @size='1x' @icon='question-circle'


            / = if form.help.location_text
            /   .bg-neutral-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
            /     ol.list-disc.ml-5.space-y-2
            /       li.text-neutral-600 Roster player limit is the maximum number of players that can be on a game roster.
            /       li.text-neutral-600 The limit must be a number from 1 to 100.
            /       / li.text-neutral-600 The limit must be less than or equal to the team player limit ({{get this 'model.season_settings.val.team_limits.team_players'}}).

            = if (and (not form.valid.location_text) form.submitted)
              .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                  ol.list-disc.ml-5.space-y-2
                    li.text-red-800 Location must be a string.

            .mt-1.relative.rounded-md
              % Input [
                @value=this.form.values.location_text
                class='form-input mt-1 block w-full rounded-md border-neutral-300 mutambo-focus-sky'
                id='location_text'
                placeholder=''
                oninput={ action this.formValueChanged 'location_text' }
                type='text'
              ]

          div
            label.text-neutral-900.font-medium for='datetime': | Date Time
            fieldset.flex.flex-col
              = if form.warnings.datetime
                .bg-orange-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                    ol.list-disc.ml-5.space-y-2
                      li.text-neutral-900: | Warning: Invalid Date Time.
                      li.text-neutral-900: | Game will be saved with no date or time.
              .flex.w-full.-space-x-px.rounded-md
                .flex-1: span.text-neutral-900.font-light: | Year
                .flex-1: span.text-neutral-900.font-light: | Month
                .flex-1: span.text-neutral-900.font-light: | Day
              .flex.w-full.-space-x-px.rounded-md.mt-px
                .flex-1
                  label.sr-only for='year': | Year
                  % Input [
                    @value=form.values.year
                    class='form-input relative block w-full rounded-none rounded-bl-md rounded-tl-md bg-transparent border-neutral-300'
                    class='mutambo-focus-sky focus:z-10'
                    id='year'
                    max=max_year
                    min=min_year
                    name='year'
                    oninput={ action this.formValueChanged 'year' }
                    placeholder=''
                    type='number'
                  ]
                .flex-1
                  label.sr-only for='month': | Month
                  % Input [
                    @value=form.values.month
                    class='form-input mutambo-focus-sky focus:z-10'
                    class='relative block w-full rounded-none bg-transparent border-neutral-300'
                    id='month'
                    max=12
                    min=1
                    name='month'
                    oninput={ action this.formValueChanged 'month' }
                    placeholder=''
                    type='number'
                  ]
                .flex-1
                  label.sr-only for='day': | Day
                  % Input [
                    @value=form.values.day
                    class='form-input mutambo-focus-sky focus:z-10'
                    class='relative block w-full rounded-none rounded-br-md rounded-tr-md bg-transparent border-neutral-300'
                    id='day'
                    max=31
                    min=1
                    name='day'
                    oninput={ action this.formValueChanged 'day' }
                    placeholder=''
                    type='number'
                  ]

          div
            .flex.w-full
              fieldset.flex.flex-col.flex-1.pr-2
                .flex.w-full.-space-x-px.rounded-md
                  .flex-1: span.text-neutral-900.font-light: | Hour
                  .flex-1: span.text-neutral-900.font-light: | Minute
                .flex.w-full.-space-x-px.rounded-md.mt-px
                  .flex-1
                    label.sr-only for='hour': | Hour
                    % Input [
                      @value=form.values.hour
                      class='form-input mutambo-focus-sky focus:z-10'
                      class='relative block w-full rounded-none rounded-bl-md rounded-tl-md bg-transparent border-neutral-300'
                      id='hour'
                      max=12
                      min=1
                      name='hour'
                      oninput={ action this.formValueChanged 'hour' }
                      placeholder=''
                      type='number'
                    ]
                  .flex-1
                    label.sr-only for='minute': | Minute
                    % Input [
                      @value=form.values.minute
                      class='form-input mutambo-focus-sky focus:z-10'
                      class='relative block w-full rounded-none rounded-br-md rounded-tr-md bg-transparent border-neutral-300'
                      id='minute'
                      max=59
                      min=00
                      name='minute'
                      oninput={ action this.formValueChanged 'minute' }
                      placeholder=''
                      type='number'
                    ]

              fieldset.flex.flex-col
                .flex.w-full.rounded-md
                  .flex-auto: span.text-white: | M
                .flex.w-full.rounded-md.mt-px
                  .flex-auto
                    / label.sr-only for='meridiem': | Meridiem
                    button{on 'click' (fn this.toggleMeridiem)} class='inline-flex justify-end items-center px-4 py-2 border border-neutral-300 shadow-sm font-medium rounded-md text-neutral-700 bg-white hover:bg-neutral-50 mutambo-focus-sky w-14' type='button'
                        = form.values.meridiem

          div
            label.flex.items-center.justify-between for='score'
              .font-medium.text-neutral-900: | Score
              / button{on 'click' (fn this.toggleHelp 'limit')} class='mutambo-form-help-button' role='button' tabindex='0'
              /   % FaIcon @prefix='fas' @size='1x' @icon='question-circle'


            / = if form.help.location_text
            /   .bg-neutral-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
            /     ol.list-disc.ml-5.space-y-2
            /       li.text-neutral-600 Roster player limit is the maximum number of players that can be on a game roster.
            /       li.text-neutral-600 The limit must be a number from 1 to 100.
            /       / li.text-neutral-600 The limit must be less than or equal to the team player limit ({{get this 'model.season_settings.val.team_limits.team_players'}}).

            = if (and (not form.valid.score) form.submitted)
              .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                  ol.list-disc.ml-5.space-y-2
                    li.text-red-800 Score must be integers or empty.

            
            div class="grid grid-cols-11 gap-x-2"
              .col-span-5
                label.inline-flex class='max-w-[95%]'
                  span.font-light: | Home
                  span.font-light.mx-1: | {{'–'}}
                  span.font-light.italic.overflow-hidden.text-ellipsis.truncate: | {{model.game.val.home_team.val.name}}
                .mt-1.relative.rounded-md
                  % Input [
                    @value=this.form.values.score.home
                    class='form-input mt-1 block w-full rounded-md border-neutral-300 mutambo-focus-sky'
                    id='score'
                    placeholder=''
                    oninput={ action this.formValueChanged 'score.home' }
                    type='number'
                  ]
              .col-span-1.flex.items-center.justify-center.pt-6
                span: | vs.
                  
              .col-span-5
                label.inline-flex class='max-w-[95%]'
                  span.font-light: | Away
                  span.font-light.mx-1: | {{'–'}}
                  span.font-light.italic.overflow-hidden.text-ellipsis.truncate: | {{model.game.val.away_team.val.name}}
                .mt-1.relative.rounded-md
                  % Input [
                    @value=this.form.values.score.away
                    class='form-input mt-1 block w-full rounded-md border-neutral-300 mutambo-focus-sky'
                    id='score'
                    placeholder=''
                    oninput={ action this.formValueChanged 'score.away' }
                    type='number'
                  ]

            
            
            

        .mt-8.space-x-3
          button{on 'click' (fn this.save)} class='bg-green-500 border border-green-500 font-medium hover:border-green-600 hover:pointer inline-flex mutambo-focus-sky px-4 py-2 rounded-md shadow-sm text-white' role='button' tabindex='0'
            span Save

          % LinkTo [
            @route='app.league.season.games'
            @query={hash league_id=model.league.meta.id season_id=model.season.meta.id}
            class='bg-white border border-neutral-200 font-medium hover:border-neutral-300 hover:pointer inline-flex mutambo-focus-sky px-4 py-2 rounded-md shadow-sm'
            role='link'
            tabindex='0'
          ]
            | Cancel
