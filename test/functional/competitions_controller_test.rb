require File.dirname(__FILE__) + '/../test_helper'
require 'competitions_controller'

# Re-raise errors caught by the controller.
class CompetitionsController; def rescue_action(e) raise e end; end

class CompetitionsControllerTest < Test::Unit::TestCase
  fixtures :competitions

  def setup
    @controller = CompetitionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = competitions(:first).id
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

    assert_not_nil assigns(:competitions)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:competition)
    assert assigns(:competition).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:competition)
  end

  def test_create
    num_competitions = Competition.count

    post :create, :competition => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_competitions + 1, Competition.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:competition)
    assert assigns(:competition).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Competition.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Competition.find(@first_id)
    }
  end
end
