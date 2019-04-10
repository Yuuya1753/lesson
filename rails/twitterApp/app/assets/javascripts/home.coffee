# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(window).on 'scroll', () ->
    doch = $(document).innerHeight()
    winh = $(window).innerHeight()
    bottom = doch - winh
    if bottom <= $(window).scrollTop()
      console.log("test")
      $.ajax
        url  : '/home/append'
        type : 'post'
        data : { "tweets_id": $(".id:last").text() }
      .done (data) ->
        $(".tweet").append(data)
        console.log(data)
      .fail (data) -> alert 'fail'