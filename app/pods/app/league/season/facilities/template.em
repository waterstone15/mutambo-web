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
    .flex.flex-col.px-8.pb-8.w-full

      .flex.justify-between.items-center.border-b.border-neutral-100 class='mb-[20px] pt-[26px] pb-[17px]'
        .flex
          = if this.model.league.val.logo_url
            .h-6.flex.items-center.w-6.rounded.mr-2.border.border-neutral-100.overflow-hidden
              img.object-contain src='{{this.model.league.val.logo_url}}' alt='League Logo'
          .h-6.flex.items-center.font-bold
            = or this.model.league.val.name 'League'
            |  →{{' '}}
            = or this.model.season.val.name 'Season'
            |  → Facilities
        .flex class='w-[30px] h-[30px]'
          / @query={hash league_id=this.model.league.meta.id season_id=season.meta.id}
          % LinkTo [
            @route='app.league.season.facilities.create'
            class='transparent bg-white border border-neutral-200 flex hover:bg-neutral-100 hover:border-neutral-300 hover:pointer hover:text-neutral-700 items-center justify-center no-underline rounded-md shadow-sm text-neutral-500 px-3 w-[32px] h-[32px] mutambo-focus-sky'
            role='button'
            tabindex='0'
          ]
            % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='plus'

      / .flex.items-center.pb-6.border-b.border-neutral-100.mb-7
      /   = if model.league.val.logo_url
      /     .h-6.flex.items-center.w-6.rounded.mr-2.border.border-neutral-100.overflow-hidden
      /       img.object-contain src='{{model.league.val.logo_url}}' alt='League Logo'
      /   .h-6.flex.items-center.font-bold
      /     = or model.league.val.name 'League'
      /     |  →{{' '}}
      /     = or model.season.val.name 'Season'
      /     |  → Misconduct



      = if (not (get model 'people.length'))
        p.pb-2.italic.text-neutral-500 This season doesn't have any facilities.
        p.pb-2.italic.text-neutral-500 All of this season's facilities will show up here.

      = if (get model 'people.length')
        .overflow-x-auto.mb-7
          .align-middle.inline-block.min-w-full
            .overflow-hidden.border.border-neutral-200 class='sm:rounded-sm'
              table.min-w-full.divide-y.divide-neutral-200
                thead.bg-neutral-100
                  tr
                    th.px-3.py-2.text-left.font-medium Display Name
                    th.px-3.py-2.text-left.font-medium Full Name
                    th.px-3.py-2.text-left.font-medium Email
                    th.px-3.py-2.text-left.font-medium
                    th.px-3.py-2.text-left.font-medium Phone
                    th.px-3.py-2.text-left.font-medium
                tbody
                  = each (get model 'people') as |person index|
                    tr class='even:bg-neutral-50'
                      td.py-2.whitespace-nowrap.text-neutral-900.align-top: span.px-3 {{person.val.display_name}}
                      td.py-2.whitespace-nowrap.text-neutral-900.align-top: span.px-3 {{person.val.full_name}}
                      td.whitespace-nowrap.text-neutral-900
                        .inline-flex.flex-row.items-center
                          span.inline-flex.px-3.font-mono
                            = if person.ui.email_masked
                              | {{person.ui.email_blackout}}
                            = else
                              | {{person.val.email}}
                          button{on 'click' (fn this.toggleEmailMasked person.meta.id)} class='border border-transparent flex h-[30px] hover:bg-neutral-100 hover:pointer hover:text-neutral-700 items-center justify-center mutambo-focus-sky no-underline rounded-full text-neutral-300 w-[30px]' role='button' tabindex='0'
                           .flex.justify-center.items-center
                             % FaIcon @prefix='fas' @size='1x' @transform='shrink-1' @icon="{{if person.ui.email_masked 'eye' 'eye-slash'}}"
                      td.whitespace-nowrap.text-neutral-900.align-top
                        .flex.items-center.py-px.px-px
                          a href='mailto:{{person.val.email}}' class='bg-white border border-neutral-200 flex h-[30px] hover:bg-neutral-100 hover:pointer hover:text-neutral-700 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-full shadow-sm text-neutral-500 w-[30px]' role='link' tabindex='0'
                            .flex.justify-center.items-center
                              % FaIcon @prefix='fas' @size='1x' @transform='shrink-1' @icon='envelope'
                      td.whitespace-nowrap.text-neutral-900
                        .inline-flex.flex-row.items-center
                          span.px-3.font-mono
                            = if person.ui.phone_masked
                              | {{person.ui.phone_blackout}}
                            = else
                              | {{person.val.phone}}
                          button{on 'click' (fn this.togglePhoneMasked person.meta.id)} class='border border-transparent flex h-[30px] hover:bg-neutral-100 hover:pointer hover:text-neutral-700 items-center justify-center mutambo-focus-sky no-underline rounded-full text-neutral-300 w-[30px]' role='button' tabindex='0'
                           .flex.justify-center.items-center
                             % FaIcon @prefix='fas' @size='1x' @transform='shrink-1' @icon="{{if person.ui.phone_masked 'eye' 'eye-slash'}}"
                      td.whitespace-nowrap.text-neutral-900.align-top
                        .flex.items-center.py-px.px-px
                          a href='tel:{{person.val.phone}}' class='bg-white border border-neutral-200 flex h-[30px] hover:bg-neutral-100 hover:pointer hover:text-neutral-700 items-center justify-center ml-2 mutambo-focus-sky no-underline rounded-full shadow-sm text-neutral-500 w-[30px]' role='link' tabindex='0'
                            .flex.justify-center.items-center
                              % FaIcon @prefix='fas' @size='1x' @transform='shrink-1' @icon='phone-alt'









