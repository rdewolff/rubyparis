require File.dirname(__FILE__) + '/../test_helper'
require 'rubyparis_controller'

# Re-raise errors caught by the controller.
class RubyparisController; def rescue_action(e) raise e end; end

class RubyparisControllerTest < Test::Unit::TestCase
  def setup
    @controller = RubyparisController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
