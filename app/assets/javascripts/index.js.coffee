$(document).ready ->
  $("#teste").on("ajax:success", (e, data, status, xhr) ->
    alert("success: " + data.name)
  ).bind "ajax:error", (e, xhr, status, error) ->
    alert("error: ", status)
  