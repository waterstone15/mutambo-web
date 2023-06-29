= page-title (get this 'title_string') replace=true separator=' → '

div class='min-h-screen flex flex-col md:flex-row'

  % AppNav [
    @isLoggedIn=this.model.isLoggedIn
    @league=this.model.league
    @leagues=this.model.leagues
    @season=this.model.season
    @user=this.model.user
  ]

  .flex.w-full
    .flex.flex-col.p-8.w-full
      .flex.items-center.pb-6.border-b.border-neutral-100.mb-7 style='padding-top: 2px; padding-bottom: 21px;'
        = if this.model.league.val.logo_url
          .h-6.flex.items-center.w-6.rounded.mr-2.border.border-neutral-100.overflow-hidden
            img.object-contain src='{{this.model.league.val.logo_url}}' alt='League Logo'
        .h-6.flex.items-center.font-bold
          = or this.model.league.val.name 'League'
          | {{' '}}→ Create New Season


      .space-y-6 class='sm:w-full sm:max-w-md'
        div
          label.flex.items-center.justify-between for='season_name'
            .font-medium.text-neutral-900.py-1 Season Name
            / button{on 'click' (fn this.toggleHelp 'season_name')} class='ml-2 p-2 rounded-full flex items-center justify-center text-neutral-500 hover:bg-neutral-200 hover:text-neutral-700 focus:outline-none focus:ring-2 focus:ring-sky-500'
            /   % FaIcon @prefix='fas' @size='1x' @icon='question-circle'

          / = if form.help.season_name
          /   .bg-neutral-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
          /     ol.list-disc.ml-5.space-y-2
          /       li.text-neutral-600 Your display name will be visible to all players.
          /       li.text-neutral-600 A first name or nickname works well.

          = if (and (not form.valid.season_name) form.submitted)
            .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                ol.list-disc.ml-5.space-y-2
                  li.text-red-800 A season name is required.

          .mt-1.relative.rounded-md.shadow-sm
          .mt-1.block.w-full.rounded-md.border-neutral-300
            % Input{on 'input' (fn this.formValueChanged 'season_name')}{on 'keydown' (fn this.formKeyPress 'season_name')} @type='text' @value=form.values.season_name autofocus=true class='form-input mt-1 block w-full rounded-md border-neutral-300 focus:border-sky-300 focus:ring focus:ring-sky-200 focus:ring-opacity-50' placeholder=''

      .mt-8.space-x-3
        button{on 'click' (fn this.save)} class='bg-green-500 border border-green-500 border-transparent focus:outline-none font-medium hover:bg-green-600 hover:border-green-600 hover:pointer inline-flex px-4 py-2 rounded-md shadow-sm text-white'
          span Save

        % LinkTo [
          @query={hash league_id=(get model 'league.meta.id')}
          @route='app.league.index'
          class='bg-white border border-neutral-200 focus:outline-none focus:ring-2 focus:ring-sky-500 focus:ring-offset-2 font-medium hover:border-neutral-300 hover:pointer inline-flex px-4 py-2 rounded-md shadow-sm'
        ]

          | Cancel
