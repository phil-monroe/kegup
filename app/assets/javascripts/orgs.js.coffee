orgs = ->
  $('.btn.tap-empty').on 'click', (event) ->
    org_id = $(this).data('org-id')
    tap_id = $(this).data('tap-id')

    if confirm('Are you sure?')
      $.ajax
        url: "/api/orgs/#{org_id}/taps/#{tap_id}/finished",
        method: "PATCH",
        success: ->
          window.location = "/orgs/#{org_id}"

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
          window.location = "/orgs/#{org_id}"

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

  curr_url = document.location.toString()
  if curr_url.match('#')
    sel = ".nav-tabs a[href=##{curr_url.split('#')[1]}]"
    $(sel).tab('show') ;

  # Change hash for page-reload
  $('a[data-toggle="tab"]').on 'show.bs.tab', (e) ->
    window.location.hash = e.target.hash

  $(".membership-form").on("ajax:success", (e, data, status, xhr) ->
      window.location = window.location.toString()
    ).bind "ajax:error", (e, xhr, status, error) ->
      window.location = window.location.toString()

  $(".membership-delete").on("ajax:success", (e, data, status, xhr) ->
      window.location = window.location.toString()
    ).bind "ajax:error", (e, xhr, status, error) ->
      window.location = window.location.toString()

  $('.description').popover
    trigger: 'hover'

document.addEventListener "page:load", orgs
$(orgs)