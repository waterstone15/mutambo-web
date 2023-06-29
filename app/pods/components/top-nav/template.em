div class="{{if @compact 'w-full' 'container mx-auto'}}"
  .flex.flex-row.justify-between
    % LinkTo [
      @route='index'
      class='border border-transparent flex hover:bg-white items-center justify-center mutambo-focus-sky no-underline p-2 rounded-md text-neutral-900 m-4'
      role='button'
      tabindex='0'
    ]
      .logo.nav
      h1.brand.font-semibold.text-xl.ml-2.pr-2 Mutambo

    % LinkTo [
      @route={if @isLoggedIn 'app.hello' 'sign-in'}
      class='bg-white border border-neutral-200 flex font-medium hover:pointer items-center mutambo-focus-sky no-underline px-4 py-2 rounded-md shadow-sm text-neutral-900 m-4'
      role='link'
      tabindex='0'
    ]
      = if @isLoggedIn
        span Dashboard
      = else
        span Sign In
