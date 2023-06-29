= page-title 'Support - Mutambo' replace=true separator=' → '

div class='min-h-screen flex flex-col md:flex-row'

  % AppNav [
    @isLoggedIn=this.model.isLoggedIn
    @leagues=this.model.leagues
    @user=this.model.user
  ]

  .flex.w-full
    .flex.flex-col.w-full
      .px-8.flex.justify-between.items-center.border-b.border-neutral-100 class='min-h-[80px]'
        .inline-flex.items-center.flex-wrap class='md:h-[48px] py-4 md:py-0'
          % Breadcrumb [
            @arrow=false
            @goto={hash route='app.hello'}
            @icon={hash transform='grow-1' icon='user' class='text-neutral-900'}
            @text={if model.user model.user.val.display_name 'Dashboard'}
          ]
          % Breadcrumb [
            @goto={hash route='app.support'}
            @icon={hash transform='grow-1' icon='question-circle' class='text-neutral-900'}
            @text='Support'
          ]

      .p-8.flex.flex-col
        p.pb-2.text-neutral-800
          | If you have any ideas, feedback, or questions please send a message to{{' '}}
          a.text-sky-600 class='hover:text-sky-800 hover:pointer hover:underline' href='mailto:hello@mutambo.com' hello@mutambo.com
          | .
        p.pb-2.text-neutral-800 Enjoy your games!
