require! [ moment, '../../services.json' ]

gen-id = ->
  year = new Date!.get-UTC-full-year! - 2015
  day  = moment.utc!.format 'DDDD'
  rand = 'xxxxxx'.replace /[x]/g, -> (Math.random!*36.|.0).to-string 36
  "#year#day#rand"

module.exports = handlers =
  things: (data) ->
    console.log data

  sketch: (data) ->
    console.log data

  snap: (data) ->
    console.log data

  clip: (data) ->
    console.log data

  voice: (data) ->
    console.log data

  cast: (data) ->
    console.log data

# Quick sanity check
for service in services
  unless service of handlers
    console.warn "WARNING: No server handler for #service service!"
