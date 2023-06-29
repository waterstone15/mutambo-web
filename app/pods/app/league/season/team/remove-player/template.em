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
            @goto={hash route='app.league.season.teams' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @icon={hash transform='grow-0' icon='users' prefix='fas' class='text-emerald-400'}
            @text='Teams'
          ]
          % Breadcrumb [
            @goto={hash route='app.league.season.team' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id team_id=model.team.meta.id player_id=model.player.meta.id )}
            @text={model.team.val.name}
          ]
          % Breadcrumb [
            @goto={hash route='app.league.season.team.remove-player' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id team_id=model.team.meta.id player_id=model.player.meta.id )}
            @text='Remove Player'
          ]

      .p-8

        .space-y-6 class='sm:w-full sm:max-w-md'
          div
            label
              .font-medium.text-neutral-900: | Player
              .inline-flex {{model.player.val.full_name}}
            
            = if form.warnings.confirm_text
              .bg-orange-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                ol.list-disc.ml-5.space-y-2
                  li.text-neutral-600
                    | Once removed, there will no longer be a record of {{or model.player.val.full_name 'this player'}} on {{or model.team.val.name 'this team'}}.
                  
          div
            label.flex.items-center.justify-between
              .font-medium.text-neutral-900: | Confirm
            label
              .inline-flex: | Type
              .inline-flex.ml-1.py-px.px-1.rounded-sm.border.border-neutral-100.bg-white: | REMOVE
              .inline-flex.ml-1: | in the field below to confirm.


            = if (and (not form.valid.confirm_text) form.submitted)
              .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                  ol.list-disc.ml-5.space-y-2
                    li.text-red-800: | This field is required.

            .mt-1.relative.rounded-md
              % Input [
                @value=this.form.values.confirm_text
                class='form-input mt-1 block w-full rounded-md border-neutral-300 mutambo-focus-sky'
                id='confirm_text'
                placeholder=''
                oninput={ action this.formValueChanged 'confirm_text' }
                type='text'
              ]

        .mt-8.space-x-3
          button [
            onclick={action confirm}
            class='text-center py-2 px-4 border border-transparent rounded-md font-medium mutambo-focus-neutral-dark shadow-sm text-white bg-neutral-800 hover:bg-neutral-900'
            role='button'
            tabindex='0'
          ]
            | Remove Player

          % LinkTo [
            @route='app.league.season.team'
            @query={hash league_id=model.league.meta.id season_id=model.season.meta.id team_id=model.team.meta.id}
            class='bg-white border border-neutral-200 font-medium hover:border-neutral-300 hover:pointer inline-flex mutambo-focus-sky px-4 py-2 rounded-md shadow-sm'
            role='link'
            tabindex='0'
          ]
            | Cancel
