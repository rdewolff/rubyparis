require File.dirname(__FILE__) + '/../test_helper'
require 'arbitres_controller'

# Re-raise errors caught by the controller.
class ArbitresController; def rescue_action(e) raise e end; end

class ArbitresControllerTest < Test::Unit::TestCase
  fixtures :arbitres

  def setup
    @controller = ArbitresController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = arbitres(:first).id
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

    assert_not_nil assigns(:arbitres)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:arbitre)
    assert assigns(:arbitre).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:arbitre)
  end

  def test_create
    num_arbitres = Arbitre.count

    post :create, :arbitre => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_arbitres + 1, Arbitre.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:arbitre)
    assert assigns(:arbitre).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Arbitre.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Arbitre.find(@first_id)
    }
  end
end
