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



document.addEventListener "page:load", orgs
$(orgs)