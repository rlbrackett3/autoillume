$(document).ready ->
  $ ->
    alert = $(".alert")
    if alert.length > 0
      alert.show().animate height: alert.outerHeight(), 200
      window.setTimeout ->
        alert.slideUp()
      , 3000