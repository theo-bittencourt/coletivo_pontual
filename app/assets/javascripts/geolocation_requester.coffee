class GeolocationRequester
  constructor: ->
    @startPolling()

  startPolling: ->
    setInterval @getPosition, 5000

  getPosition: =>
    navigator.geolocation.getCurrentPosition(
      @success
      @errorGettingPosition
      enableHighAccuracy: true
      timeout: 10000
      maximumAge: 0
    )

  success: (pos) =>
    output = """
      latitude:         #{pos.coords.latitude} <br>
      longitude:        #{pos.coords.longitude} <br>
      accuracy:         #{pos.coords.accuracy} <br>
      altitude:         #{pos.coords.altitude} <br>
      heading:          #{pos.coords.heading} <br>
      speed:            #{pos.coords.speed} <br>
      altitudeAccuracy: #{pos.coords.altitudeAccuracy}
      """
    $('#output').html output

  errorGettingPosition: (e) =>
    console.log e

$ -> new GeolocationRequester
