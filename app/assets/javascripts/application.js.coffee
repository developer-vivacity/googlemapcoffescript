#= require jquery
#= require jquery_ujs
#= require_tree .

$ ->
  $('*[data-googlemap]').googleMap()
  true