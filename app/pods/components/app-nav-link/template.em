% LinkTo [
  @invokeAction=this.invokeAction
  @query=this.query
  @route=this.route
  class="border border-transparent flex font-medium items-center mb-2 md:mb-1 md:px-2 md:py-1 mutambo-focus-sky px-4 py-3 rounded-md {{if this.isActive 'hover:bg-white' 'hover:bg-neutral-100'}} {{if this.isActive 'bg-white'}}"
  role='link'
  tabindex='0'
]

  .flex.items-center.justify-center.w-5.relative
    = if (eq this.route 'app.league.season.divisions')
      .relative
        % FaIcon class='text-orange-400 absolute top-[-10px] left-[-9px]' @fixedWidth=true @icon=this.icon @prefix=this.prefix @size='1x' @transform='grow-3'
        % FaIcon class='text-amber-400 absolute top-[-4px]  left-[-9px]' @fixedWidth=true @icon=this.icon @prefix=this.prefix @size='1x' @transform='grow-3'
    = else
      % FaIcon class=this.color @fixedWidth=true @icon=this.icon @prefix=this.prefix @size=this.size @transform=this.transform

  .flex.items-center.pl-2
    = this.name