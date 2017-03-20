class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
    name = "torinist"
    render text: "Hello, #{name}, Welcome to Ruby!"
  end

end
