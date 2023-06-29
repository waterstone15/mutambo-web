= page-title title_string replace=true separator=' → '

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
            @goto={hash route='app.league.index' query=(hash league_id=model.league.meta.id)}
            @icon={hash transform='grow-0 up-1' icon='home' class='text-neutral-900'}
            @text='Home'
          ]

      .p-8    
        .flex.flex-col.max-w-lg class='w-full md:w-10/12 lg:w-7/12 xl:w-6/12 2xl:w-4/12'

          h3.font-medium.pb-3 Name
          p.pb-2.text-neutral-800 = or model.league.val.name '–'

          / h3.font-medium.pb-3.pt-6 Description
          / p.pb-2.text-neutral-800 = or model.league.val.description '–'

          h3.font-medium.pb-3.pt-6 Sport
          p.pb-2.text-neutral-800 = or model.league.val.sport '–'

          h3.font-medium.pb-3.pt-6 Website
          = if (get model 'league.val.website')
            p
              a.pb-2.text-sky-600.whitespace-nowrap.inline-block class='hover:text-sky-800 hover:pointer hover:underline' href="{{model.league.val.website}}" rel='noopener noreferrer nofollow' target='_blank'
                = model.league.val.website
                span.px-2
                  % FaIcon @prefix='fas' @size='1x' @icon='external-link-alt' @transform='shrink-1'
          = else
            p.pb-2.text-neutral-800 —

          h3.font-medium.pb-3.pt-6 Roles
          p.pb-2.text-neutral-800 = or model.league.ui.roles '–'

          = if (and model.league.val.is_admin model.iclfa.ui.link)
            h3.font-medium.pb-3.pt-6 Invite Free Agents
            .flex
              .bg-neutral-100.rounded-md.mt-1.mb-3.pl-3.py-3.pr-4.w-full
                ol.list-disc.ml-5.space-y-2
                  li.text-neutral-600 To invite free agents to this league share the link below.

            .pb-2
              .mt-1.flex.rounded-md.shadow-sm
                .relative.flex.flex-grow.items-stretch class='focus-within:z-10'
                  input.block.w-full.rounded-none.rounded-l-md.px-2 type='text' name='link' class='mutambo-focus-sky border border-neutral-200' value='{{model.iclfa.ui.link}}'
                button{on 'click' (fn this.copy 'iclfa')} type='button' class='mutambo-focus-sky hover:border-neutral-300 hover:text-neutral-900 relative -ml-px inline-flex items-center space-x-2 rounded-r-md border border-neutral-200 bg-neutral-50 px-4 py-2 font-medium text-neutral-600'
                  % FaIcon @prefix='fas' @size='1x' @icon='copy' @transform='shrink-2'
                  span Copy

          = if model.league.val.is_admin
            .inline-flex.items-center.pb-1.pt-5
              .font-medium.text-neutral-900 Seasons
              / = if model.league.val.is_admin
              /   % LinkTo [
              /     class='ml-1 h-8 w-8 rounded-full flex items-center justify-center text-neutral-500 hover:bg-neutral-200 hover:text-neutral-700 focus:outline-none focus:ring-2 focus:ring-sky-500'
              /     @route='app.league.seasons.create'
              /     @query={hash league_id=model.league.meta.id}
              /   ]
              /     % FaIcon @prefix='fas' @size='1x' @transform='shrink-0' @icon='plus'

            = if model.league.val.is_admin
              = each model.seasons as |season|
                .flex.justify-start.items-center
                  % LinkTo [
                    class='group inline-block.rounded.border.border-white.border-opacity-0.group.mb-1 hover:pointer focus:outline-none focus:ring-2 focus:ring-sky-500'
                    @route='app.league.season.index'
                    @query={hash league_id=model.league.meta.id season_id=season.meta.id}
                  ]
                    .inline-block.mr-2.border-b.border-dotted.border-neutral-300.pt-2 class='group-hover:border-black' = season.val.name
                    % FaIcon @prefix='fas' @size='1x' @icon='arrow-right' @transform='shrink-1' class='text-neutral-300 group-hover:text-black'

