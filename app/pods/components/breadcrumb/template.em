= if (not (eq @arrow false))
  div class='inline-flex items-center justify-center w-6'
    % FaIcon [
      @icon='arrow-right'
      @prefix='fas'
      @size='1x'
      @transform='shrink-1'
      class='text-neutral-300'
    ]

% LinkTo [
  @query={@goto.query}
  @route={@goto.route}
  class={if (and @icon (not @image)) 'pl-3'}
  class={if (and (not @icon) (not @image)) 'pl-4'}
  class='bg-neutral-50 border border-neutral-200 h-10 hover:bg-neutral-100 hover:cursor-pointer hover:shadow-sm inline-flex items-center mutambo-focus-sky overflow-hidden pr-4 rounded-md space-x-2'
  role='link'
  tabindex='0'
]

  = if @image
    div class='border-r border-neutral-200 h-10 inline-flex items-center justify-center overflow-hidden w-10 mr-1'
      img.object-contain src='{{@image.src}}' alt='{{@image.alt}}'
  
  = if (and @icon (not @image))
    .inline-flex.justify-center.items-center
      = if (eq @icon 'divisions')
        .relative.mx-2
          % FaIcon class='text-orange-400 absolute top-[-10px] left-[-9px]' @fixedWidth=true @icon='chevron-up' @prefix='fas' @size='1x' @transform='grow-3'
          % FaIcon class='text-amber-400 absolute top-[-4px]  left-[-9px]' @fixedWidth=true @icon='chevron-up' @prefix='fas' @size='1x' @transform='grow-3'
      = else
        % FaIcon [
          @prefix={if @icon.prefix @icon.prefix 'fas'}
          @size={if @icon.size @icon.size '1x'}
          @transform={if @icon.transform @icon.transform 'grow-0'}
          @icon={if @icon.icon @icon.icon 'square'}
          class={if @icon.class @icon.class 'text-neutral-900'}
        ]

  = if @text
    h2.inline-flex.font-bold
      | {{@text}}

