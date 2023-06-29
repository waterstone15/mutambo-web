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
            @goto={hash route='app.league.season.payments' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @icon={hash transform='grow-2' icon='building-columns' prefix='fas' class='text-green-500'}
            @text='Payments'
          ]
          % Breadcrumb [
            @goto={hash route='app.league.season.payments.create' query=(hash league_id=model.league.meta.id season_id=model.season.meta.id)}
            @text='Create Payment'
          ]

      .p-8


        .space-y-6 class='sm:w-full sm:max-w-md'

          div
            label.flex.items-center.justify-between for='form-title'
              .font-medium.text-neutral-900 Title

            = if (and (not form.valid.title) form.submitted)
              .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                  ol.list-disc.ml-5.space-y-2
                    li.text-red-800 Title is required.

            .mt-1.relative.rounded-md
              % Input [
                @value=this.form.values.title
                class='form-input mt-1 block w-full rounded-md border-neutral-300 mutambo-focus-sky'
                id='form-title'
                oninput={ action this.formValueChanged 'title' }
                type='text'
              ]

          div
            label.flex.items-center.justify-between for='form-description'
              .font-medium.text-neutral-900 Description

            = if (and (not form.valid.description) form.submitted)
              .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                  ol.list-disc.ml-5.space-y-2
                    li.text-red-800 Description is required.

            .mt-1.relative.rounded-md
              % Textarea [
                @value=form.values.description
                class='form-textarea font-sans mt-1 block w-full rounded-md border-neutral-300 mutambo-focus-sky'
                id='form-description'
                name='form-description'
                oninput={ action this.formValueChanged 'description' }
                rows='3'
              ]

          div
            label.flex.items-center.justify-between for='form-price'
              .font-medium.text-neutral-900: | Amount

            = if (and (not form.valid.price) form.submitted)
              .bg-red-100.rounded-md.mt-1.mb-2.pl-3.py-3.pr-4
                  ol.list-disc.ml-5.space-y-2
                    li.text-red-800
                      | An amount in the range{{' '}}
                      span.font-mono.rounded.border.border-neutral-300.pt-px.pb-px.bg-white class='px-1.5' 0.00
                      | {{' '}}to{{' '}}
                      span.font-mono.rounded.border.border-neutral-300.pt-px.pb-px.bg-white class='px-1.5' 500.00
                      | {{' '}}is required.

            .mt-1.relative.rounded-md
              .absolute.inset-y-0.left-0.pl-3.flex.items-center.pointer-events-none
                span.text-neutral-900.font-bold $
              % Input [
                @value=this.form.values.price
                class='form-input mt-1 block w-full font-mono rounded-md border-neutral-300 pl-7 pr-12 mutambo-focus-sky'
                id='form-price'
                oninput={ action this.formValueChanged 'price' }
                placeholder='0.00'
                type='text'
              ]
              .absolute.inset-y-0.right-0.pr-3.flex.items-center.pointer-events-none
                span.text-neutral-900.font-bold  USD



        .mt-8.space-x-3
          button{on 'click' (fn this.create)} class='bg-green-500 border border-green-500 font-medium hover:border-green-600 hover:pointer inline-flex mutambo-focus-sky px-4 py-2 rounded-md shadow-sm text-white' role='button' tabindex='0'
            span Create

          % LinkTo [
            @route='app.league.season.payments.index'
            @query={hash league_id=this.model.league.meta.id season_id=this.model.season.meta.id}
            class='bg-white border border-neutral-200 font-medium hover:border-neutral-300 hover:pointer inline-flex mutambo-focus-sky px-4 py-2 rounded-md shadow-sm'
            role='link'
            tabindex='0'
          ]
            | Cancel




