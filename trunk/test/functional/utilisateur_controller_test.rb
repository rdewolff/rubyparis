require File.dirname(__FILE__) + '/../test_helper'
require 'utilisateur_controller'

# Re-raise errors caught by the controller.
class UtilisateurController; def rescue_action(e) raise e end; end

class UtilisateurControllerTest < Test::Unit::TestCase
  def setup
    @controller = UtilisateurController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
