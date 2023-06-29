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
            @goto={hash route='app.league.season.misconducts' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @icon={hash transform='grow-2' icon='gavel' prefix='fas' class='text-brown-600'}
            @text='Misconduct'
          ]
          % Breadcrumb [
            @goto={hash route='app.league.season.misconducts.create' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @text='Create Misconduct'
          ]

      .p-8

        .space-y-6 class='sm:w-full sm:max-w-md'

          div
            label.text-neutral-900.font-medium for='team': | Team

            = if (and (not form.valid.team) form.submitted)
              .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                  ol.list-disc.ml-5.space-y-2
                    li.text-red-800: | A team is required.
                    / = if (not (eq (get this 'form.values.team.val.division.meta.id') (get this 'form.values.team.val.division.meta.id')))

            select [
              class='form-select mutambo-focus-sky'
              class='mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 rounded-md'
              name='team'
              onchange={ action this.selectTeam }
            ]
              option selected='' —
              = each model.teams as |team|
                option value="{{team.meta.id}}" {{team.val.name}}

          div
            label.text-neutral-900.font-medium for='person': | Person

            = if (and (not form.valid.person) form.submitted)
              .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                  ol.list-disc.ml-5.space-y-2
                    li.text-red-800: | A person is required.

            select [
              class='form-select mutambo-focus-sky'
              class='mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 rounded-md'
              name='person'
              onchange={ action this.selectPerson }
            ]
              option selected='' —
              = each people as |person|
                option value="{{person.meta.id}}" {{person.val.full_name}}

          div
            label.text-neutral-900.font-medium for='game': | Game

            = if (and (not form.valid.game) form.submitted)
              .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                  ol.list-disc.ml-5.space-y-2
                    li.text-red-800: | A game is required.

            select [
              class='form-select mutambo-focus-sky'
              class='mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 rounded-md'
              name='game'
              onchange={ action this.selectGame }
            ]
              option selected='' —
              = each games as |game|
                option value="{{game.meta.id}}"
                  | {{game.ui.date}} • {{game.ui.time}} {{game.ui.zone}} – {{game.val.home_team.val.name}} vs. {{game.val.away_team.val.name}}

          div
            label.flex.items-center.justify-between for='scope'
              .font-medium.text-neutral-900: | Scope
              button{on 'click' (fn this.toggleHelp 'scope')} class='ml-2 p-2 rounded-full flex items-center justify-center text-neutral-500 hover:bg-neutral-200 hover:text-neutral-700 focus:outline-none focus:ring-2 focus:ring-sky-500'
                % FaIcon @prefix='fas' @size='1x' @icon='question-circle'

            = if form.help.scope
              .bg-neutral-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                ol.list-disc.ml-5.space-y-2
                  li.text-neutral-600
                    span.mr-2.font-medium: | League{{':'}}
                    span Suspend from all games within {{model.league.val.name}} while the suspension is active.
                  li.text-neutral-600
                    span.mr-2.font-medium: | Season{{':'}}
                    span Suspend from all games within {{model.season.val.name}} while the suspension is active.
                  li.text-neutral-600
                    span.mr-2.font-medium: | Team{{':'}}
                    span Suspend from all games with {{or form.values.team.val.name 'the selected team'}} while the suspension is active.

            = if (and (not form.valid.scope) form.submitted)
              .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                  ol.list-disc.ml-5.space-y-2
                    li.text-red-800: | A scope is required.

            .mt-1.relative.rounded-md.shadow-sm
            .mt-1.block.w-full.rounded-md.border-neutral-300
              .mt-2
                div
                  label.inline-flex.items-center class='cursor-pointer mb-2'
                    input{on 'input' (fn this.formValueChanged 'scope' 'league')} checked={eq this.form.values.scope 'league'} type='radio' name='radio-direct' class='form-radio border-neutral-300 text-sky-600 shadow-sm focus:border-sky-300 focus:ring focus:ring-offset-0 focus:ring-sky-200 focus:ring-opacity-50' value=this.form.values.scope
                    span.ml-2: | League
                    span.ml-1.italic.text-neutral-400: | – {{model.league.val.name}}
                  div
                  label.inline-flex.items-center class='cursor-pointer mb-2'
                    input{on 'input' (fn this.formValueChanged 'scope' 'season')} checked={eq this.form.values.scope 'season'} type='radio' name='radio-direct' class='form-radio border-neutral-300 text-sky-600 shadow-sm focus:border-sky-300 focus:ring focus:ring-offset-0 focus:ring-sky-200 focus:ring-opacity-50' value=this.form.values.scope
                    span.ml-2: | Season
                    span.ml-1.italic.text-neutral-400: | – {{model.season.val.name}}
                  div
                  label.inline-flex.items-center class='cursor-pointer mb-2'
                    input{on 'input' (fn this.formValueChanged 'scope' 'team')} checked={eq this.form.values.scope 'team'} type='radio' name='radio-direct' class='form-radio border-neutral-300 text-sky-600 shadow-sm focus:border-sky-300 focus:ring focus:ring-offset-0 focus:ring-sky-200 focus:ring-opacity-50' value=this.form.values.scope
                    span.ml-2: | Team
                    span.ml-1.italic.text-neutral-400
                      = if form.values.team.val.name
                        | – {{form.values.team.val.name}}


          div
            label.flex.items-center.justify-between for='demerits'
              .font-medium.text-neutral-900: | Demerits
            
            = if (and (not form.valid.demerits) form.submitted)
              .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                  ol.list-disc.ml-5.space-y-2
                    li.text-red-800: | Demerits must be an integer.

            .mt-1.relative.rounded-md
              % Input [
                oninput={ action formValueChanged 'demerits' }
                @value=form.values.demerits
                class='form-input mt-1 block w-full rounded-md border-neutral-300 mutambo-focus-sky'
                id='demerits'
                placeholder=''
                type='number'
                min=0
              ]

          div
            label.flex.items-center.justify-between for='form-fee'
              .font-medium.text-neutral-900: | Fee

            = if (and (not form.valid.fee) form.submitted)
              .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                  ol.list-disc.ml-5.space-y-2
                    li.text-red-800
                      | An amount in the range{{' '}}
                      span.font-mono.rounded.border.border-neutral-300.pt-px.pb-px.bg-white class='px-1.5': | 0.00
                      | {{' '}}to{{' '}}
                      span.font-mono.rounded.border.border-neutral-300.pt-px.pb-px.bg-white class='px-1.5': | 500.00
                      | {{' '}}is required.

            .mt-1.relative.rounded-md
              .absolute.inset-y-0.left-0.pl-3.flex.items-center.pointer-events-none
                span.text-neutral-900.font-bold $
              % Input [
                @value=this.form.values.fee
                class='form-input mt-1 block w-full font-mono rounded-md border-neutral-300 pl-7 pr-12 mutambo-focus-sky'
                id='form-fee'
                oninput={ action this.formValueChanged 'fee' }
                placeholder='0.00'
                type='text'
              ]
              .absolute.inset-y-0.right-0.pr-3.flex.items-center.pointer-events-none
                span.text-neutral-900.font-bold: | USD


        .mt-8.space-x-3
          button{on 'click' (fn this.create)} class='bg-green-500 border border-green-500 font-medium hover:border-green-600 hover:pointer inline-flex mutambo-focus-sky px-4 py-2 rounded-md shadow-sm text-white' role='button' tabindex='0'
            span: | Create

          % LinkTo [
            @route='app.league.season.misconducts.index'
            @query={hash league_id=this.model.league.meta.id season_id=this.model.season.meta.id}
            class='bg-white border border-neutral-200 font-medium hover:border-neutral-300 hover:pointer inline-flex mutambo-focus-sky px-4 py-2 rounded-md shadow-sm'
            role='link'
            tabindex='0'
          ]
            | Cancel




