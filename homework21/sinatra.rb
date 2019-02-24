require 'sinatra'
    get '/homework21' do
      content_type :json
      data = {text1: params[:text1], text2: params[:text2], text3: params[:text3], radio: params[:radio]}
      data.to_json
    end