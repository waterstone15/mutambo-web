= page-title 'Mutambo' replace=true separator=' → '

.min-w-screen.min-h-screen
  .flex.flex-col.justify-between.w-screen.min-h-screen.bg-neutral-100

    % TopNav @isLoggedIn=this.model.isLoggedIn

    .flex.flex-col.items-center.justify-center
      .flex.flex-col.items-center.justify-center.group
        .logo.hero.mb-10.mt-20 class='md:mt-4'
        h1.inline-flex.items-center.mb-4
          .z-50.px-1.brand.text-6xl.font-semibold style='box-shadow: 10px 0px 20px 10px rgb(245, 245, 245);'
            span: | Mutambo
          / .relative.flex.justify-center.items-center
          /   .inline-flex.justify-end.items-center.overflow-hidden class="w-0 transition-[width] ease-[cubic-bezier(0.45,0,0.55,1)] duration-[800ms] group-hover:w-[294px]"
          /     .pl-6.inline-flex.brand.text-6xl.font-thin.text-neutral-800.italic.whitespace-nowrap: | – The Game
        h2.text-xl Enjoy your games!
      .sport-icons.flex.flex-wrap.justify-center.flex-row.mt-28.mb-28
        span.flex.items-center.justify-center.w-16.p-3: % FaIcon @prefix='fas' @fixedWidth=true @size='2x' class='text-neutral-200' @icon='basketball-ball'
        span.flex.items-center.justify-center.w-16.p-3: % FaIcon @prefix='fas' @fixedWidth=true @size='2x' class='text-neutral-200' @icon='baseball-ball'
        span.flex.items-center.justify-center.w-16.p-3: % FaIcon @prefix='fas' @fixedWidth=true @size='2x' class='text-neutral-200' @icon='quidditch'
        span.flex.items-center.justify-center.w-16.p-3: % FaIcon @prefix='fas' @fixedWidth=true @size='2x' class='text-neutral-200' @icon='football-ball'
        span.flex.items-center.justify-center.w-16.p-3: % FaIcon @prefix='fas' @fixedWidth=true @size='2x' class='text-neutral-200' @icon='hockey-puck'
        span.flex.items-center.justify-center.w-16.p-3: % FaIcon @prefix='far' @fixedWidth=true @size='2x' class='text-neutral-200' @icon='futbol'
        span.flex.items-center.justify-center.w-16.p-3: % FaIcon @prefix='fas' @fixedWidth=true @size='2x' class='text-neutral-200' @icon='bowling-ball'
        span.flex.items-center.justify-center.w-16.p-3: % FaIcon @prefix='fas' @fixedWidth=true @size='2x' class='text-neutral-200' @icon='table-tennis'
        span.flex.items-center.justify-center.w-16.p-3: % FaIcon @prefix='fas' @fixedWidth=true @size='2x' class='text-neutral-200' @icon='volleyball-ball'

    div

  % Footer