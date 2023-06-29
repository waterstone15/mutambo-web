= page-title 'Settings - Mutambo' replace=true separator=' → '

div class='min-h-screen flex flex-col md:flex-row'

  % AppNav [
    @isLoggedIn=this.model.isLoggedIn
    @leagues=this.model.leagues
    @user=this.model.user
  ]

  .flex.w-full
    .flex.flex-col.p-8.w-full
      .flex.justify-between.items-center.border-b.border-neutral-100.mb-7
        h2.flex.font-bold style='padding-top: 2px; padding-bottom: 21px;' Settings

      .flex.flex-col.pb-5
        .font-medium.text-neutral-900.mb-2 Share Email With
        .mt-1.relative.rounded-md
          label.inline-flex.items-center for='checkbox-share-with-opposing-team-managers' class='cursor-pointer mb-1'
            / input={(fn this.toggleTeamSelection team.id)}
            / checked={team.checked}
            input [
              type='checkbox'
              id='checkbox-share-with-opposing-team-managers'
              name='checkbox-share-with-opposing-team-managers'
              class='form-checkbox border-neutral-300 text-sky-600 shadow-sm rounded-sm '
              class='focus:border-sky-300 focus:ring focus:ring-offset-0 focus:ring-sky-200 focus:ring-opacity-50'
              checked={this.share_with_opposing_team_managers}
            ]
            span.ml-2
              | Opposing Teams' Managers{{' '}}
              span.text-neutral-400 (as a Manager)

        .mt-1.relative.rounded-md
          label.inline-flex.items-center for='checkbox-share-with-team-managers' class='cursor-pointer mb-1'
            / input={(fn this.toggleTeamSelection team.id)}
            / checked={team.checked}
            / value=team.id
            input [
              type='checkbox'
              id='checkbox-share-with-team-managers'
              name='checkbox-share-with-team-managers'
              class='form-checkbox border-neutral-300 text-sky-600 shadow-sm rounded-sm '
              class='focus:border-sky-300 focus:ring focus:ring-offset-0 focus:ring-sky-200 focus:ring-opacity-50'
              checked={this.share_with_team_managers}
            ]
            span.ml-2
              | My Teams' Managers{{' '}}
              span.text-neutral-400 (as a Player)
