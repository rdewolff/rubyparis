require File.dirname(__FILE__) + '/../test_helper'
require 'matchs_controller'

# Re-raise errors caught by the controller.
class MatchsController; def rescue_action(e) raise e end; end

class MatchsControllerTest < Test::Unit::TestCase
  fixtures :matchs

  def setup
    @controller = MatchsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = matchs(:first).id
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

    assert_not_nil assigns(:matchs)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:match)
    assert assigns(:match).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:match)
  end

  def test_create
    num_matchs = Match.count

    post :create, :match => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_matchs + 1, Match.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:match)
    assert assigns(:match).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Match.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Match.find(@first_id)
    }
  end
end
