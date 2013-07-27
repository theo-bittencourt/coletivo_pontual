class TrackedStream
  constructor: ->
    @setup() if location.pathname == '/'

  setup: ->
    source = new EventSource('/devices/tracked_index_stream')
    $(source).on 'tracker', => @render event.data

  render: (data) ->
    data = JSON.parse(JSON.parse(data))
    elID = "device-#{data.id}"

    # caso o device já esteja na página, atualiza conteúdo, senão cria um novo.
    if $("##{elID}").length
      $("##{elID}").html JST["device_position"](data)
    else
      el = $("<div id=#{elID}></div>").appendTo('#tracked-stream')
      el.html JST["device_position"](data)

CP.TrackedStream = TrackedStream
$ -> new CP.TrackedStream
