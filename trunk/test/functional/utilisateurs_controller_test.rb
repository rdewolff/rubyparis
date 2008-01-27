require File.dirname(__FILE__) + '/../test_helper'
require 'utilisateurs_controller'

# Re-raise errors caught by the controller.
class UtilisateursController; def rescue_action(e) raise e end; end

class UtilisateursControllerTest < Test::Unit::TestCase
  fixtures :utilisateurs

  def setup
    @controller = UtilisateursController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = utilisateurs(:first).id
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

    assert_not_nil assigns(:utilisateurs)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:utilisateur)
    assert assigns(:utilisateur).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:utilisateur)
  end

  def test_create
    num_utilisateurs = Utilisateur.count

    post :create, :utilisateur => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_utilisateurs + 1, Utilisateur.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:utilisateur)
    assert assigns(:utilisateur).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Utilisateur.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Utilisateur.find(@first_id)
    }
  end
end
