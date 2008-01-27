require File.dirname(__FILE__) + '/../test_helper'
require 'sportifs_controller'

# Re-raise errors caught by the controller.
class SportifsController; def rescue_action(e) raise e end; end

class SportifsControllerTest < Test::Unit::TestCase
  fixtures :sportifs

  def setup
    @controller = SportifsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = sportifs(:first).id
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

    assert_not_nil assigns(:sportifs)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:sportif)
    assert assigns(:sportif).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:sportif)
  end

  def test_create
    num_sportifs = Sportif.count

    post :create, :sportif => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_sportifs + 1, Sportif.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:sportif)
    assert assigns(:sportif).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Sportif.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Sportif.find(@first_id)
    }
  end
end
