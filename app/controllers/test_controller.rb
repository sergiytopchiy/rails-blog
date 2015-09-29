class TestController < ApplicationController
  layout "testing"
  def index
    render "test/index"
  end

  def verify
    @word = params[:word]
    render "verify", layout: false
  end
end
