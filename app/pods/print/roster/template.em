= page-title 'Game Sheet' replace=true separator=' → '

.p-4 style='max-width: 8.5in;'

  table.w-full.table-auto
    tr.w-full
      td
        table.table-auto
          tbody
            tr
              td.font-medium League
              td.pl-2
                = or (get this 'model.sheet.val.league.val.name') ''
                | ,{{' '}}
                = or (get this 'model.sheet.val.season.val.name') ''
                = if (get this 'model.sheet.val.division.val.name')
                  |  &mdash;{{' '}}
                = or (get this 'model.sheet.val.division.val.name') ''
            tr
              td.font-medium Date &bull; Time
              td.pl-2
                = if (get this 'model.sheet.val.start_clock_time')
                  = get this 'model.sheet.val.date_formatted'
                  |  &bull;{{' '}}
                  = get this 'model.sheet.val.time_formatted'
            tr
              td.font-medium Location
              td.pl-2 = or (get this 'model.sheet.val.location_text') ''
      td.text-right
        //- img.inline-block(src!='{qrcode}', alt='Scan this 2D Code to download this roster as a PDF.')

  table.table-auto.border-r.border-b.w-full.border-neutral-700.my-2
    thead
      tr.border-t.border-neutral-700
        td.px-2.py-2.border-l.border-neutral-700.font-bold colspan='6'
          span.w-full.text-center
            = this.model.sheet.val.home_team.val.name
            |  (Home Team)
      tr.border-t.border-neutral-700
        td.px-2.border-l.border-neutral-700.font-medium.w-20 Check In
        td.px-4.border-l.border-neutral-700.font-medium.w-28 Player #
        td.px-2.border-l.border-neutral-700.font-medium Name
        td.px-2.border-l.border-neutral-700.font-medium.w-24 Goals
        td.px-2.border-l.border-neutral-700.font-medium.w-24 Cautions
        td.px-2.border-l.border-neutral-700.font-medium.w-24 Ejections
    tbody
      = each this.model.sheet.val.home_team.val.players as |player|
        tr.border-t.border-neutral-700.print-ready
          td.px-2.border-l.border-neutral-700
          td.px-4.border-l.border-neutral-700
          td.px-2.border-l.border-neutral-700 = player.name
          td.px-2.border-l.border-neutral-700
          td.px-2.border-l.border-neutral-700
          td.px-2.border-l.border-neutral-700

  .pagebreak

  table.w-full.table-auto
    tr.w-full
      td
        table.table-auto
          tbody
            tr
              td.font-medium League
              td.pl-2
                = or (get this 'model.sheet.val.league.val.name') ''
                | ,{{' '}}
                = or (get this 'model.sheet.val.season.val.name') ''
                = if (get this 'model.sheet.val.division.val.name')
                  |  &mdash;{{' '}}
                = or (get this 'model.sheet.val.division.val.name') ''
            tr
              td.font-medium Date &bull; Time
              td.pl-2
                = if (get this 'model.sheet.val.start_clock_time')
                  = get this 'model.sheet.val.date_formatted'
                  |  &bull;{{' '}}
                  = get this 'model.sheet.val.time_formatted'
            tr
              td.font-medium Location
              td.pl-2 = or (get this 'model.sheet.val.location_text') ''
      td.text-right
        //- img.inline-block(src!='{qrcode}', alt='Scan this 2D Code to download this roster as a PDF.')


  .my-4.border-b.border-white

  table.table-auto.border-r.border-b.w-full.border-neutral-700.my-2
    thead
      tr.border-t.border-neutral-700
        td.px-2.py-2.border-l.border-neutral-700.font-bold colspan='6'
          span.w-full.text-center
            = this.model.sheet.val.away_team.val.name
            |  (Away Team)
      tr.border-t.border-neutral-700
        td.px-2.border-l.border-neutral-700.font-medium.w-20 Check In
        td.px-4.border-l.border-neutral-700.font-medium.w-28 Player #
        td.px-2.border-l.border-neutral-700.font-medium Name
        td.px-2.border-l.border-neutral-700.font-medium.w-24 Goals
        td.px-2.border-l.border-neutral-700.font-medium.w-24 Cautions
        td.px-2.border-l.border-neutral-700.font-medium.w-24 Ejections
    tbody
        = each this.model.sheet.val.away_team.val.players as |player|
          tr.border-t.border-neutral-700.print-ready
            td.px-2.border-l.border-neutral-700
            td.px-4.border-l.border-neutral-700
            td.px-2.border-l.border-neutral-700 = player.name
            td.px-2.border-l.border-neutral-700
            td.px-2.border-l.border-neutral-700
            td.px-2.border-l.border-neutral-700
