
.flex.justify-between.items-center class='md:hidden'
  % LinkTo [
    @route='index'
    class='flex p-2 rounded-md items-center justify-center md:hidden hover:bg-white border border-transparent'
    role='link'
    tabindex='0'
  ]
    .logo.nav
    h1.brand.font-semibold.text-xl.ml-2.pr-2 Mutambo
  button{on 'click' (fn toggleNav)} class='bg-white border border-neutral-200 flex h-12 items-center justify-center mutambo-focus-sky rounded-md shadow-sm w-12' role='button' tabindex='0'
    % FaIcon @prefix='fas' @size='1x' @transform='grow-3' @icon={if nav.show 'times' 'bars'}

% LinkTo [
  @route='index'
  class='border border-transparent hidden hover:bg-white items-center justify-center md:flex mutambo-focus-sky p-2 rounded-md'
  role='link'
  tabindex='0'
]
  .logo.nav
  h1.brand.font-semibold.text-xl.ml-2.pr-2 Mutambo


div class='md:block' class={nav.show::hidden}
  div class='md:pt-[7px]'
  button [
    onclick={action toggleSwitcher}
    class="bg-white border border-neutral-200"
    class="flex items-center justify-between"
    class="group hover:shadow-sm"
    class="md:mt-3 md:px-2 md:py-2 mt-6 my-2 px-4 py-3 rounded-md w-full "
    class="mutambo-focus-sky"
    class="{{if showMainSwitcher 'shadow-sm'}}"
    role='button'
    tabindex='0'
  ]
    .flex-items-center
      span
        % FaIcon @prefix='fas' @fixedWidth=true @size='1x' @transform='grow-0' @icon="{{if league 'trophy' 'user'}}" class="{{if league 'text-amber-400'}}"
      span.ml-2 class='font-semibold'
        = if league league.val.name (or user.val.display_name 'Dashboard')
    span class="mr-1 flex items-center justify-center text-neutral-900"
      % FaIcon @prefix='fas' @fixedWidth=true @size='1x' @transform={if showMainSwitcher 'grow-0' 'grow-0'} @icon={if showMainSwitcher 'times' 'sort'}

  = if showMainSwitcher
    div class='flex w-full flex-col py-2 bg-white border border-neutral-200 rounded-md shadow-sm'

      h4 class='uppercase text-neutral-400 text-sm px-4 md:px-3 pt-2 pb-1' User

      % LinkTo [
        @invokeAction={fn toggleSwitcher}
        @route='app.hello'
        class="border border-transparent"
        class="hover:bg-neutral-100"
        class="md:px-2 md:py-2 mutambo-focus-sky px-4 py-3 w-full"
        class="{{if (not league_id) 'bg-neutral-100' }}"
        class='flex flex-row items-center'
        role='link'
        tabindex='0'
      ]
        span
          % FaIcon @prefix='fas' @fixedWidth=true @size='1x' @transform='grow-0' @icon='user'
          span.ml-2 class='font-semibold'
            = if user.val.display_name user.val.display_name 'Dashboard'

      = if (get this 'leagues.length')
        h4 class='uppercase text-neutral-400 text-sm px-4 md:px-3 pt-4 pb-1' Leagues
      = each leagues as |league|
        % LinkTo [
          @invokeAction={fn toggleSwitcher}
          @route='app.league'
          @query={hash league_id=(get league 'meta.id')}
          class="border border-transparent flex flex-row hover:bg-neutral-100 items-center md:px-2 md:py-2 mutambo-focus-sky px-4 py-3 w-full {{if (eq league_id (get league 'meta.id')) 'bg-neutral-100' }}"
          role='link'
          tabindex='0'
        ]
          .flex.items-center.justify-center.w-5
            % FaIcon @prefix='fas' @fixedWidth=true @size='1x' @transform='grow-0' @icon='trophy' class='text-amber-400'
          .flex.items-center.pl-2.font-semibold
            = league.val.name

      / % LinkTo [
      /   @invokeAction={fn toggleSwitcher}
      /   @route='index'
      /   class='flex w-full flex-row items-center px-4 py-3 md:px-2 md:py-2 hover:bg-neutral-100'
      / ]
      /   .flex.items-center.justify-center.w-5
      /     % FaIcon @prefix='fas' @fixedWidth=true @size='1x' @transform='grow-0' @icon='plus' class='text-amber-500'
      /   .flex.items-center.pl-2.font-semibold
      /     | New League


  = if (and (not league) (not showMainSwitcher))
    ul.mt-4

      % AppNavLink [
        @color='text-purple-400'
        @icon='portrait'
        @invokeAction={fn closeNav}
        @name='Player Cards'
        @route='app.player-cards'
        @transform='grow-3'
      ]

      % AppNavLink [
        @color='text-emerald-400'
        @icon='tshirt'
        @invokeAction={fn closeNav}
        @name='Teams'
        @route='app.teams'
        @transform='grow-0'
      ]

      % AppNavLink [
        @color='text-red-400'
        @icon='futbol'
        @name='Games'
        @route='app.games'
        @transform='grow-1'
      ]

      % AppNavLink [
        @color='text-stone-400'
        @icon='clipboard'
        @invokeAction={fn closeNav}
        @name='Registrations'
        @route='app.registrations'
        @transform='grow-1'
      ]
      
      % AppNavLink [
        @color='text-green-500'
        @icon='money-bill'
        @invokeAction={fn closeNav}
        @name='Payments'
        @route='app.payments'
        @transform='grow-0'
      ]

      % AppNavLink [
        @color='text-gray-400'
        @icon='user'
        @invokeAction={fn closeNav}
        @name='Account'
        @route='app.account'
        @transform='grow-1'
      ]

      / % AppNavLink [
      /   @color='text-slate-400'
      /   @icon='cog'
      /   @name='Settings'
      /   @route='app.settings'
      /   @transform='grow-1'
      / ]

      % AppNavLink [
        @color='text-gray-800'
        @icon='question-circle'
        @invokeAction={fn closeNav}
        @name='Support'
        @route='app.support'
        @transform='grow-1'
      ]


  = if (and league.meta.id (not showMainSwitcher))
    ul.mt-4
      % AppNavLink [
        @color='text-black'
        @icon='home'
        @invokeAction={fn closeNav}
        @name='Home'
        @query={hash league_id=league_id}
        @route='app.league.index'
        @transform='shrink-1 up-1'
      ]

      % AppNavLink [
        @color='text-purple-400'
        @icon='running'
        @invokeAction={fn closeNav}
        @name='Free Agents'
        @query={hash c=null p=null league_id=league_id}
        @route='app.league.free-agents.index'
        @transform='grow-4 up-1'
      ]


  = if (and league league.meta.id seasons.length league.val.is_admin (not season.meta.id) (not showMainSwitcher))
    .uppercase.text-neutral-400.mt-6.ml-2.text-sm.tracking-wide Seasons
    ul.mt-2
      = each seasons as |season|
        % AppNavLink [
          @color='text-yellow-400'
          @icon='sun'
          @name=season.val.name
          @query={hash league_id=league.meta.id season_id=season.meta.id}
          @route='app.league.season.index'
          @transform='grow-0'
        ]

  = if (and league.meta.id season.meta.id (not showMainSwitcher))
    button{on 'click' (fn toggleSeasonSwitcher)} class="bg-white border border-neutral-200 flex group hover:shadow-sm items-center justify-between md:mt-8 md:px-2 md:py-2 mt-12 mutambo-focus-sky my-2 px-4 py-3 rounded-md w-full {{if showSeasonSwitcher 'shadow-sm'}}" role='button' tabindex='0'
      .flex.items-center
        .flex.items-center.justify-center
          % FaIcon @prefix='fas' @fixedWidth=true @size='1x' @transform='grow-3' @icon='sun' class='text-yellow-400'
        .flex.items-center.pl-2.font-medium
          = season.val.name
      span class="mr-1 flex items-center justify-center text-neutral-900"
        % FaIcon @prefix='fas' @fixedWidth=true @size='1x' @transform={if showSeasonSwitcher 'grow-0' 'grow-0'} @icon={if showSeasonSwitcher 'times' 'sort'}

  = if (and showSeasonSwitcher (not showMainSwitcher))
    div class='flex w-full flex-col py-2 bg-white border border-neutral-200 rounded-md shadow-sm'

      h4 class='uppercase text-neutral-400 text-sm px-4 md:px-3 pt-2 pb-1' Seasons

      = each seasons as |season|
        % LinkTo [
          @invokeAction={fn toggleSeasonSwitcher}
          @query={hash league_id=league.meta.id season_id=season.meta.id }
          @route='app.league.season.index'
          class="border border-transparent"
          class="flex flex-row hover:bg-neutral-100 items-center"
          class="md:px-2 md:py-2 px-4 py-3 w-full"
          class="mutambo-focus-sky"
          class="{{if (eq season_id (get season 'meta.id')) 'bg-neutral-100' }}"
          role='link'
          tabindex='0'
        ]
          .flex.items-center
            .flex.items-center.justify-center
              % FaIcon @prefix='fas' @fixedWidth=true @size='1x' @transform='grow-3' @icon='sun' class='text-yellow-400'
            .flex.items-center.pl-2.font-medium
              = season.val.name

  = if (and league.meta.id season.meta.id (not showSeasonSwitcher) (not showMainSwitcher))
    ul.mt-4

      % AppNavLink [
        @color='text-black'
        @icon='home'
        @invokeAction={fn closeNav}
        @name='Home'
        @query={hash league_id=league_id season_id=season_id}
        @route='app.league.season.index'
        @transform='shrink-1 up-1'
      ]

      = if season.val.is_admin
        % AppNavLink [
          @color='text-slate-400'
          @icon='cogs'
          @invokeAction={fn closeNav}
          @name='Settings'
          @query={hash league_id=league_id season_id=season_id}
          @route='app.league.season.settings'
          @transform='grow-1'
        ]

        / % AppNavLink [
        /   @color='text-blue-400'
        /   @icon='bolt'
        /   @name='Notifications'
        /   @query={hash c=null p=null league_id=league_id season_id=season_id}
        /   @route='app.league.season.notifications'
        /   @transform='grow-1'
        / ]

        % AppNavLink [
          @color='text-orange-400'
          @icon='chevron-up'
          @name='Divisions'
          @query={hash c=null p=null league_id=league_id season_id=season_id}
          @route='app.league.season.divisions'
          @transform='grow-1'
        ]

        % AppNavLink [
          @color='text-pink-400'
          @icon='chart-simple'
          @name='Standings'
          @query={hash league_id=league_id season_id=season_id}
          @route='app.league.season.standings'
          @transform='grow-1'
        ]

        % AppNavLink [
          @color='text-emerald-400'
          @icon='users'
          @name='Teams'
          @query={hash c=null p=null league_id=league_id season_id=season_id}
          @route='app.league.season.teams'
          @transform='grow-0'
        ]

        % AppNavLink [
          @color='text-red-400'
          @icon='futbol'
          @prefix='fa-regular'
          @name='Games'
          @query={hash c=null p=null league_id=league_id season_id=season_id}
          @route='app.league.season.games'
          @transform='grow-2'
        ]

        / % AppNavLink [
        /   @color='text-cyan-500'
        /   @icon='map-marker-alt'
        /   @name='Facilities'
        /   @query={hash c=null p=null league_id=league_id season_id=season_id}
        /   @route='app.league.season.facilities'
        /   @transform='grow-1'
        / ]

        % AppNavLink [
          @color='text-brown-600'
          @icon='gavel'
          @name='Misconduct'
          @query={hash c=null p=null league_id=league_id season_id=season_id}
          @route='app.league.season.misconducts'
          @transform='grow-2'
        ]

        % AppNavLink [
          @color='text-stone-400'
          @icon='clipboard-list'
          @name='Registrations'
          @query={hash c=null p=null league_id=league_id season_id=season_id}
          @route='app.league.season.registrations'
          @transform='grow-1'
        ]

        % AppNavLink [
          @color='text-green-500'
          @icon='university'
          @name='Payments'
          @query={hash c=null p=null league_id=league_id season_id=season_id}
          @route='app.league.season.payments'
          @transform='grow-2'
        ]

        % AppNavLink [
          @color='text-purple-400'
          @icon='address-book'
          @name='People'
          @query={hash c=null p=null league_id=league_id season_id=season_id search_at=null}
          @route='app.league.season.people.index'
          @transform='grow-1'
        ]


