require File.dirname(__FILE__) + '/../test_helper'
require 'entraineurs_controller'

# Re-raise errors caught by the controller.
class EntraineursController; def rescue_action(e) raise e end; end

class EntraineursControllerTest < Test::Unit::TestCase
  fixtures :entraineurs

  def setup
    @controller = EntraineursController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = entraineurs(:first).id
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

    assert_not_nil assigns(:entraineurs)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:entraineur)
    assert assigns(:entraineur).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:entraineur)
  end

  def test_create
    num_entraineurs = Entraineur.count

    post :create, :entraineur => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_entraineurs + 1, Entraineur.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:entraineur)
    assert assigns(:entraineur).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Entraineur.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Entraineur.find(@first_id)
    }
  end
end
