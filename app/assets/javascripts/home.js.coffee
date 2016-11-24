$.fn.googleMap = () ->
  element = $(this).get(0)
  zoomLevel = $(this).data('zoom') || 8

  if $(this).data('size')
    [width, height] = $(this).data('size').split('x')
    $(this).css({width: Number(width), height: Number(height), background: '#fff'})

  wrapperElem = $(this).wrap('<div class="map-wrap"/>').css({background:'#fff'})
  $(this).hide() # To avoid confusing Flash Of Non-interactive Map Content

  geocoder = new google.maps.Geocoder
  geocoderParams =
    address: $(this).data('address') || "1461 North Opdyke Road, Auburn Hills, MI, United States, 48326-2680"
    region: "US"
  results = geocoder.geocode geocoderParams, (results, status) ->
    if status == google.maps.GeocoderStatus.OK
      latlng = results[0].geometry.location

      mapOptions =
        mapTypeControl: false
        overviewMapControl: false
        zoom: zoomLevel
        center: latlng
        mapTypeId: google.maps.MapTypeId.ROADMAP

      map = new google.maps.Map(element, mapOptions)

      marker = new google.maps.Marker
        position: latlng
        map: map

      $(element).show() # Time to re-show the element