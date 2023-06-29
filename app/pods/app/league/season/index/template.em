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
            @goto={hash route='app.league.season.index' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @icon={hash transform='grow-0 up-1' icon='home' class='text-neutral-900'}
            @text='Home'
          ]


      .p-8
        .flex.flex-col.max-w-lg class='w-full md:w-10/12 lg:w-7/12 xl:w-6/12 2xl:w-4/12'
        
          h3.font-medium.pb-3 Name
          p.pb-2.text-neutral-800 = or model.season.val.name '–'

          h3.font-medium.pb-3.pt-6 Roles
          p.pb-2.text-neutral-800 = or model.season.val.roles_formatted '–'


          = if (and model.season.val.is_admin model.icsa.ui.link)
            h3.font-medium.pb-3.pt-6 Invite Admins
            .flex
              .bg-neutral-100.rounded-md.mt-1.mb-3.pl-3.py-3.pr-4.w-full
                ol.list-disc.ml-5.space-y-2
                  li.text-neutral-600 To invite additional admins to this season share the link below.

            .pb-2
              .mt-1.flex.rounded-md.shadow-sm
                .relative.flex.flex-grow.items-stretch class='focus-within:z-10'
                  input.block.w-full.rounded-none.rounded-l-md.px-2 type='text' name='link' class='mutambo-focus-sky border border-neutral-200' value='{{model.icsa.ui.link}}'
                button{on 'click' (fn this.copy 'icsa')} type='button' class='mutambo-focus-sky hover:border-neutral-300 hover:text-neutral-900 relative -ml-px inline-flex items-center space-x-2 rounded-r-md border border-neutral-200 bg-neutral-50 px-4 py-2 font-medium text-neutral-600'
                  % FaIcon @prefix='fas' @size='1x' @icon='copy' @transform='shrink-2'
                  span Copy

          = if (and model.season.val.is_admin model.icst.ui.link)
            h3.font-medium.pb-3.pt-6 Invite Teams
            .flex
              .bg-neutral-100.rounded-md.mt-1.mb-3.pl-3.py-3.pr-4.w-full
                ol.list-disc.ml-5.space-y-2
                  li.text-neutral-600 To invite additional teams to this season share the link below.

            .pb-2
              .mt-1.flex.rounded-md.shadow-sm
                .relative.flex.flex-grow.items-stretch class='focus-within:z-10'
                  input.block.w-full.rounded-none.rounded-l-md.px-2 type='text' name='link' class='mutambo-focus-sky border border-neutral-200' value='{{model.icst.ui.link}}'
                button{on 'click' (fn this.copy 'icst')} type='button' class='mutambo-focus-sky hover:border-neutral-300 hover:text-neutral-900 relative -ml-px inline-flex items-center space-x-2 rounded-r-md border border-neutral-200 bg-neutral-50 px-4 py-2 font-medium text-neutral-600'
                  % FaIcon @prefix='fas' @size='1x' @icon='copy' @transform='shrink-2'
                  span Copy