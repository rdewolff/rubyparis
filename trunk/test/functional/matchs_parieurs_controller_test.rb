require File.dirname(__FILE__) + '/../test_helper'
require 'matchs_parieurs_controller'

# Re-raise errors caught by the controller.
class MatchsParieursController; def rescue_action(e) raise e end; end

class MatchsParieursControllerTest < Test::Unit::TestCase
  fixtures :matchs_parieurs

  def setup
    @controller = MatchsParieursController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = matchs_parieurs(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:matchs_parieurs)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:matchs_parieur)
    assert assigns(:matchs_parieur).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:matchs_parieur)
  end

  def test_create
    num_matchs_parieurs = MatchsParieur.count

    post :create, :matchs_parieur => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_matchs_parieurs + 1, MatchsParieur.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:matchs_parieur)
    assert assigns(:matchs_parieur).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      MatchsParieur.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      MatchsParieur.find(@first_id)
    }
  end
end
