require File.dirname(__FILE__) + '/../test_helper'
require 'administrateurs_controller'

# Re-raise errors caught by the controller.
class AdministrateursController; def rescue_action(e) raise e end; end

class AdministrateursControllerTest < Test::Unit::TestCase
  fixtures :administrateurs

  def setup
    @controller = AdministrateursController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = administrateurs(:first).id
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

    assert_not_nil assigns(:administrateurs)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:administrateur)
    assert assigns(:administrateur).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:administrateur)
  end

  def test_create
    num_administrateurs = Administrateur.count

    post :create, :administrateur => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_administrateurs + 1, Administrateur.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:administrateur)
    assert assigns(:administrateur).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Administrateur.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Administrateur.find(@first_id)
    }
  end
end
