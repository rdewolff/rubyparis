require File.dirname(__FILE__) + '/../test_helper'
require 'ventraineurs_controller'

# Re-raise errors caught by the controller.
class VentraineursController; def rescue_action(e) raise e end; end

class VentraineursControllerTest < Test::Unit::TestCase
  fixtures :ventraineurs

  def setup
    @controller = VentraineursController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = ventraineurs(:first).id
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

    assert_not_nil assigns(:ventraineurs)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:ventraineur)
    assert assigns(:ventraineur).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:ventraineur)
  end

  def test_create
    num_ventraineurs = Ventraineur.count

    post :create, :ventraineur => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_ventraineurs + 1, Ventraineur.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:ventraineur)
    assert assigns(:ventraineur).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Ventraineur.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Ventraineur.find(@first_id)
    }
  end
end
