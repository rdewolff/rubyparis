require File.dirname(__FILE__) + '/../test_helper'
require 'equipes_controller'

# Re-raise errors caught by the controller.
class EquipesController; def rescue_action(e) raise e end; end

class EquipesControllerTest < Test::Unit::TestCase
  fixtures :equipes

  def setup
    @controller = EquipesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = equipes(:first).id
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

    assert_not_nil assigns(:equipes)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:equipe)
    assert assigns(:equipe).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:equipe)
  end

  def test_create
    num_equipes = Equipe.count

    post :create, :equipe => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_equipes + 1, Equipe.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:equipe)
    assert assigns(:equipe).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Equipe.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Equipe.find(@first_id)
    }
  end
end
