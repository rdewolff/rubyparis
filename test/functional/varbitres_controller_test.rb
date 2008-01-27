require File.dirname(__FILE__) + '/../test_helper'
require 'varbitres_controller'

# Re-raise errors caught by the controller.
class VarbitresController; def rescue_action(e) raise e end; end

class VarbitresControllerTest < Test::Unit::TestCase
  fixtures :varbitres

  def setup
    @controller = VarbitresController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = varbitres(:first).id
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

    assert_not_nil assigns(:varbitres)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:varbitre)
    assert assigns(:varbitre).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:varbitre)
  end

  def test_create
    num_varbitres = Varbitre.count

    post :create, :varbitre => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_varbitres + 1, Varbitre.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:varbitre)
    assert assigns(:varbitre).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Varbitre.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Varbitre.find(@first_id)
    }
  end
end
