orgs = ->
  $('.btn.tap-empty').on 'click', (event) ->
    org_id = $(this).data('org-id')
    tap_id = $(this).data('tap-id')

    if confirm('Are you sure?')
      $.ajax
        url: "/api/orgs/#{org_id}/taps/#{tap_id}/finished",
        method: "PATCH",
        success: ->
          Turbolinks.visit("/orgs/#{org_id}")

        error: ->
          alert("Unable to empty tap...")


  $('.btn.keg-tapped').on 'click', (event) ->
    org_id = $(this).data('org-id')
    keg_id = $(this).data('keg-id')
    tap_id = $("#keg-#{keg_id}_tap_id").val()

    if confirm('Are you sure?')
      $.ajax
        url: "/api/orgs/#{org_id}/taps/#{tap_id}/tapped",
        method: "PATCH",
        data:
          keg_id: keg_id
        success: ->
          Turbolinks.visit("/orgs/#{org_id}")

        error: ->
          alert("Unable to tap keg...")

  $('#bother-kegmeisters').on 'click', (event) ->
    org_id  = $(this).data('org-id')
    user_id = $(this).data('user-id')
    $.ajax
      url: "/api/orgs/#{org_id}/bother",
      method: "get",
      data:
        user_id: user_id
      success: ->
        alert("Kegmeisters notified that they suck...")

      error: ->
        alert("Unable to scold kegmeisters.")

  url = document.location.toString()
  if url.match('#')
    $('.nav-tabs a[href=#'+url.split('#')[1]+']').tab('show') ;

  # Change hash for page-reload
  $('a[data-toggle="tab"]').on 'show.bs.tab', (e) ->
    window.location.hash = e.target.hash

  $(".membership-form").on("ajax:success", (e, data, status, xhr) ->
      Turbolinks.visit(window.location.toString())
    ).bind "ajax:error", (e, xhr, status, error) ->
      Turbolinks.visit(window.location.toString())

  $(".membership-delete").on("ajax:success", (e, data, status, xhr) ->
      Turbolinks.visit(window.location.toString())
    ).bind "ajax:error", (e, xhr, status, error) ->
      Turbolinks.visit(window.location.toString())

  $('.description').popover
    trigger: 'hover'

document.addEventListener "page:load", orgs
$(orgs)