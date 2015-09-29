require! {
  './index.styl'

  'common/misc.js'
  'common/utils.ls'
}

document.add-event-listener \DOMContentLoaded !->
  utils.services.for-each (service) !->
    for elem in document.get-elements-by-class-name service + \Icon
      elem.add-event-listener \click !->
        utils.nav-to-service service
