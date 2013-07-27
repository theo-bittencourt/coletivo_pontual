class PositionEmitter
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
    data = {
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
    }

    $.get "/devices/#{@id}/tracker", {position: data}

  errorGettingPosition: (e) =>
    console.log e

CP.PositionEmitter = PositionEmitter
