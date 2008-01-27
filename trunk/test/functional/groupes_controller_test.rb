require File.dirname(__FILE__) + '/../test_helper'
require 'groupes_controller'

# Re-raise errors caught by the controller.
class GroupesController; def rescue_action(e) raise e end; end

class GroupesControllerTest < Test::Unit::TestCase
  fixtures :groupes

  def setup
    @controller = GroupesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = groupes(:first).id
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

    assert_not_nil assigns(:groupes)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:groupe)
    assert assigns(:groupe).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:groupe)
  end

  def test_create
    num_groupes = Groupe.count

    post :create, :groupe => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_groupes + 1, Groupe.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:groupe)
    assert assigns(:groupe).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Groupe.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Groupe.find(@first_id)
    }
  end
end
