require File.dirname(__FILE__) + '/../test_helper'
require 'paris_matchs_controller'

# Re-raise errors caught by the controller.
class ParisMatchsController; def rescue_action(e) raise e end; end

class ParisMatchsControllerTest < Test::Unit::TestCase
  fixtures :paris_matchs

  def setup
    @controller = ParisMatchsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = paris_matchs(:first).id
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

    assert_not_nil assigns(:paris_matchs)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:paris_match)
    assert assigns(:paris_match).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:paris_match)
  end

  def test_create
    num_paris_matchs = ParisMatch.count

    post :create, :paris_match => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_paris_matchs + 1, ParisMatch.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:paris_match)
    assert assigns(:paris_match).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      ParisMatch.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      ParisMatch.find(@first_id)
    }
  end
end
