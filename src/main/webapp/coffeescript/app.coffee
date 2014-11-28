define ['jquery', 'bootstrap', 'nprogress', 'controller', 'model', 'service'],
->
  'use strict'
  document.getElementsByTagName("body")[0].style.display='block'
  #progress  bar start
  NProgress.configure({ showSpinner: false })
  NProgress.start()
  $ ->
    $('body').show()
    # IE10 viewport hack for Surface/desktop Windows 8 bug
    # See Getting Started docs for more information
    if (navigator.userAgent.match(/IEMobile\/10\.0/))
      msViewportStyle = document.createElement("style")
      msViewportStyle.appendChild(
        document.createTextNode(
          "@-ms-viewport{width:auto!important}"
        )
      )
      document.getElementsByTagName("head")[0].appendChild(msViewportStyle)

    #scrollup
    $(".back-top").click(->
      $('html, body').animate({scrollTop: '0px'}, 400, 'linear')
    )
    $(window).scroll(->
      if ($(window).scrollTop() > 200)
        $(".back-top").fadeIn(200)
      else
        $(".back-top").fadeOut(200)
    )
    #progress  bar done
    NProgress.done()