require! {
  './index.styl'

  'common/misc.js'
  'common/utils.ls'
}

window.g_content-box-inner-removed = false

document.add-event-listener \DOMContentLoaded !->
  utils.apply-service-links!

  unless (id = utils.get-id!)?
    $ \#content-inner .html (require './create.jade')!
    $ \.doneButton .click !->
      $ \.doneButton .off \click
      $.post \upload img: ($ \#contentBox .[0].to-data-URL \image/png)
        .done utils.on-upload-success
        .fail utils.on-upload-fail
    $ !-> $ \#contentBox .sketch!
    $ \#contentBoxOverlay .fade-out \fast
    return

  $ \#content-inner .html (require './result.jade')!

  utils.insert-ads!

  img = new Image!
  img.src = utils.create-asset-URL "uploads/#id.png"
  img.onload = !->
    $ \#contentBox .[0].get-context \2d .draw-image img, 0 0
    $ \#contentBoxOverlay .fade-out \fast
