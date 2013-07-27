class BusDevice
  constructor: (@id, @title) ->
    @startPolling()

  startPolling: ->
    setInterval @getPosition, 2000

  getPosition: =>
    navigator.geolocation.getCurrentPosition(
      @success
      @errorGettingPosition
      enableHighAccuracy: true
      timeout: 10000
      maximumAge: 0
    )

  success: (pos) =>
    @positionData =
      id:                @id,
      name:              @title,
      latitude:          pos.coords.latitude,
      longitude:         pos.coords.longitude,
      accuracy:          pos.coords.accuracy,
      altitude:          pos.coords.altitude,
      heading:           pos.coords.heading,
      speed:             pos.coords.speed,
      altitude_accuracy: pos.coords.altitudeAccuracy,
      timestamp:         Date.now()

    @positionData.eta = @getETA()

    $.get "/devices/#{@id}/tracker", {position: @positionData}

  errorGettingPosition: (e) =>
    console.log e

  coords: ->
    new google.maps.LatLng(-22.948751,-43.185803)

  userCoords: ->
    new google.maps.LatLng(@positionData.latitude, @positionData.longitude)

  getETA: ->
    service = new google.maps.DistanceMatrixService
    options =
      origins:           [@coords()]
      destinations:      [@userCoords()]
      travelMode:        google.maps.TravelMode.DRIVING
      durationInTraffic: true
      avoidHighways:     false
      avoidTolls:        false

    service.getDistanceMatrix options, (response, status) =>
      @eta = response.rows[0].elements[0].duration.text
    @eta

CP.BusDevice = BusDevice
