ready = ->

  # ==========================================================================
  #
  #  ++ home ++
  #
  # ==========================================================================
  
  # ----------------------------------------
  #                          + float panel +
  # ----------------------------------------
  centeringFloatPanel = ->
    panel = $('.l-main__float-panel')

    displayWidth = $(window).width()
    panelWidth   = panel.outerWidth()
    left         = (displayWidth - panelWidth) / 2

    displayHeight = $(window).height()
    panelHeight   = panel.outerHeight()
    top           = (displayHeight - panelHeight) / 2

    position = { top: top, left: left }
    panel.css(position)
  centeringFloatPanel()

  toggleFloatPanel = (mes) ->
    if mes is 'show'
      $('.l-main__float-panel-overlay').fadeIn('slow')
      $('.l-main__float-panel.p-home__admin-register-book').fadeIn('slow')
    if mes is 'close'
      $('.l-main__float-panel-overlay').fadeOut('slow')
      $('.l-main__float-panel').fadeOut('slow')
  # show
  $('.c-button.p-home__button-show-register-book-panel').on 'click', ->
    toggleFloatPanel('show')
  # close
  $('.l-main__float-panel-overlay').on 'click', ->
    toggleFloatPanel('close')
  $('.l-main__float-panel-close-button').on 'click', (event) ->
    event.preventDefault()
    toggleFloatPanel('close')

  toggleImageIcon = (e) ->
    i = $(e.target).children('i')
    i.toggleClass('fa-file-image-o')
    i.toggleClass('fa-plus-circle')
  $('.p-books__show-portlait-image-placeholder').on 'mouseenter', (e) ->
    toggleImageIcon(e)
  $('.p-books__show-portlait-image-placeholder').on 'mouseleave', (e) ->
    toggleImageIcon(e)

  # ----------------------------------------
  #                      + switching panel +
  # ----------------------------------------
  switchingRegisterPanel = (e) ->
    e.preventDefault()
    targetFloatPanel  = $(e.target).parents('.l-main__float-panel')
    panelType         = targetFloatPanel.attr('class').replace('l-main__float-panel', '').trimLeft()
    panelForSwitch    = $(".l-main__float-panel:not(.#{panelType})")
    panelLeftPosition = targetFloatPanel.css('left')

    targetFloatPanel.animate({
      left: '-1600px',
      opacity: 0
    }, 300, ->
      targetFloatPanel.css({
        'display': 'none', 'opacity': 1, 'left': panelLeftPosition
      })
      panelForSwitch.fadeIn(200)
    )
  $('.l-main__float-panel-switch-button').on 'click', (e) ->
    switchingRegisterPanel(e)

  # ----------------------------------------
  #                        + register book +
  # ----------------------------------------
  selectFile = (input) ->
    file       = input.target.files[0]
    fileName   = file.name
    fileReader = new FileReader()

    sibling = $(input.target.previousSibling)
    i       = sibling.children('i')
    span    = sibling.children('span')
    img     = sibling.children('img')
    
    if file.type.indexOf("image") is 0
      # when 'file' is image
      i.removeClass('fa-frown-o').addClass('fa-file-image-o')
      span.text("")

      fileReader.addEventListener 'load', (event) ->
        sibling.addClass('is-previewing')
        i.css('display', 'none')
        span.css('display', 'none')
        $(img).attr('src', event.target.result)
      fileReader.readAsDataURL(file)
    else
      # when 'file' is not image
      console.log 'file is not image'
      sibling.removeClass('is-previewing')
      i.attr('style', '')
      span.attr('style', '')
      img.attr('src', '')
      i.removeClass('fa-file-image-o').addClass('fa-frown-o')
      span.text("画像じゃないようです")
      false

  $('.p-books__show-portlait-image-container > input[type="file"]').on 'change', (input) ->
    selectFile(input)

  $('.p-books__show-portlait-image-placeholder').on 'click', ->
    $(this).siblings('input[type="file"]').click()

  togglePersonFinder = (e) ->
    panel   = $('.p-book__search-person-wrapper')
    classes = panel.attr('class')
    isShow  = classes.split(' ').indexOf('is-show')
    
    if isShow > 0
      # 表示中のとき
      panel.animate({
        bottom: '-1000px',
        opacity: 0
      }, 300).removeClass('is-show')
    else
      # 非表示のとき
      panel.animate({
        bottom: '0px',
        opacity: 1
      }, 300, ->
        panel.addClass('is-show')
      )

  $('.p-books__show-person .p-books__show-portlait-image-container').on 'click', (e) ->
    togglePersonFinder(e)

  $('.l-main__search-person-container-control-buttons .c-button__panel-close').on 'click', (e) ->
    e.preventDefault()
    togglePersonFinder(e)

  selectThePerson = (e) ->
    # 名前と部署の取得
    clickedItem = $(e.target).parents('.p-book__search-person-list-item')
    id   = clickedItem.children('.p-book__search-person-id').text()
    textContainer = clickedItem.children('.p-book__search-person-text-container')
    name = textContainer.children('span:first-child').text()
    dept = textContainer.children('span:last-child').text()

    # ターゲットに情報を設定
    $('.p-books__persion-id').val(id)
    $('.p-books__show-person .p-books__show-portlaits-name').val(name)
    $('.p-books__show-person .p-books__show-relevant-name').val(dept)
    $('.p-books__show-person .p-books__show-portlait-image-placeholder').css({
      'opacity': 0,
      'background-image': 'url("/assets/profile-image-sample1")',
      'box-shadow': 'none'
    }).animate({'opacity': 1}, 300).children('i.fa').css('display', 'none')
    
  $('.p-book__search-person-list-item').on 'click', (e) ->
    selectThePerson(e)
    
# ==========================================================================
if location.pathname.match('')
  $(document).ready(ready)
  $(document).on('page:load', ready)
