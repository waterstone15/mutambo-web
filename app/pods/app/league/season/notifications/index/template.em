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
    .flex.flex-col.p-8.w-full

      .flex.items-center.pb-6.border-b.border-neutral-100.mb-7
        = if model.league.val.logo_url
          .h-6.flex.items-center.w-6.rounded.mr-2.border.border-neutral-100.overflow-hidden
            img.object-contain src='{{model.league.val.logo_url}}' alt='League Logo'
        .h-6.flex.items-center.font-bold
          = or model.league.val.name 'League'
          |  →{{' '}}
          = or model.season.val.name 'Season'
          |  → Notifications

      = if (not (get model 'notifications.page_items.length'))
        p.pb-2.italic.text-neutral-500 This season doesn't have any notifications.
        p.pb-2.italic.text-neutral-500 All of this season's notifications will show up here.

      = if (get model 'notifications.page_items')
        .flex.space-y-4.flex-col class='w-12/12 md:w-8/12 lg:w-6/12 xl:w-4/12'
          = each (get model 'notifications.page_items') as |notification index|
            div [
              class='flex flex-col'
              class='py-4 px-4'
              class='border border-neutral-200 rounded-lg'
            ]
              span.font-bold.mb-2 {{notification.val.title}}
              span {{notification.val.body}}
              = if notification.val.data.val.notes
                .px-3.py-1.mt-2.border-l-2.border-neutral-200.font-light {{notification.val.data.val.notes}}
              = if (eq notification.val.status 'to-do')
                .flex.justify-end.space-x-2.mt-6

                  button [
                    onclick={action this.reject notification}
                    class='bg-white border border-neutral-200 font-medium hover:border-neutral-300 hover:pointer inline-flex mutambo-focus-sky px-4 py-2 rounded-md shadow-sm'
                    role='button'
                    tabindex='0'
                  ]
                    | Ignore

                  button [
                    onclick={action this.accept notification}
                    class='border border-transparent font-medium hover:pointer inline-flex mutambo-focus-sky-dark text-white bg-green-500 hover:bg-green-600 px-4 py-2 rounded-md shadow-sm'
                    role='button'
                    tabindex='0'
                  ]
                    | Accept










