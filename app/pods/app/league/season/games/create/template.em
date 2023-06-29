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
            @goto={hash route='app.league.season.games.create' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @text='Create Game'
          ]

      .p-8

        .space-y-6 class='sm:w-full sm:max-w-md'

          div
            label.text-neutral-900.font-medium for='home_team' Home Team

            = if (and (not form.valid.home_team) form.submitted)
              .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                  ol.list-disc.ml-5.space-y-2
                    li.text-red-800: | A home team is required.
                    li.text-red-800: | Teams should not be the same.
                    / = if (not (eq (get this 'form.values.home_team.val.division.meta.id') (get this 'form.values.away_team.val.division.meta.id')))

            select [
              class='form-select mutambo-focus-sky'
              class='mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 rounded-md'
              name='home_team'
              onchange={ action this.selectHomeTeam }
            ]
              option selected='' —
              = each model.teams as |team index|
                option value="{{team.meta.id}}" {{team.val.name}}

          div
            label.text-neutral-900.font-medium for='away_team': | Away Team

            = if (and (not form.valid.away_team) form.submitted)
              .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                  ol.list-disc.ml-5.space-y-2
                    li.text-red-800: | An away team is required.
                    li.text-red-800: | Teams should not be the same.

            select [
              class='form-select mutambo-focus-sky'
              class='mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 rounded-md'
              name='away_team'
              onchange={ action this.selectAwayTeam }
            ]
              option selected='' —
              = each model.teams as |team index|
                option value="{{team.meta.id}}" {{team.val.name}}


          div
            label.text-neutral-900.font-medium for='datetime': | Date Time
            fieldset.flex.flex-col
              = if form.warnings.datetime
                .bg-orange-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                    ol.list-disc.ml-5.space-y-2
                      li.text-neutral-900: | Warning: Invalid Date Time.
                      li.text-neutral-900: | Game will be created with no date or time.
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
            label.flex.items-center.justify-between for='location'
              .font-medium.text-neutral-900 Location
            .mt-1.relative.rounded-md
              % Input [
                oninput={ action formValueChanged 'location_text' }
                @value=form.values.location_text
                class='form-input mt-1 block w-full rounded-md border-neutral-300 mutambo-focus-sky'
                id='location'
                placeholder=''
                type='text'
              ]

          div
            label.flex.items-center for='ext_id'
              .font-medium.text-neutral-900 Ext. ID
            .mt-1.relative.rounded-md
              % Input{on 'input' (fn formValueChanged 'ext_id')} @value=form.values.ext_id class='form-input mt-1 block w-full rounded-md border-neutral-300 mutambo-focus-sky' id='ext_id' placeholder='' type='text'

        .mt-8.space-x-3
          button{on 'click' (fn this.create)} class='bg-green-500 border border-green-500 font-medium hover:border-green-600 hover:pointer inline-flex mutambo-focus-sky px-4 py-2 rounded-md shadow-sm text-white' role='button' tabindex='0'
            span: | Create

          % LinkTo [
            @route='app.league.season.games.index'
            @query={hash league_id=this.model.league.meta.id season_id=this.model.season.meta.id}
            class='bg-white border border-neutral-200 font-medium hover:border-neutral-300 hover:pointer inline-flex mutambo-focus-sky px-4 py-2 rounded-md shadow-sm'
            role='link'
            tabindex='0'
          ]
            | Cancel




