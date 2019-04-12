# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

count_new_tweets = ->
  $.ajax
    url  : '/home/count_tweets'
    type : 'post'
    data : { "tweets_id": $(".id:first").text() }
  .done (data) ->
    $("#count-new-tweets").html(data)
    console.log(data)
  .fail (data) -> alert 'fail'

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

  setInterval count_new_tweets, 10000
