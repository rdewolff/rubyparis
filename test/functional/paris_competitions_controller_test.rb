require File.dirname(__FILE__) + '/../test_helper'
require 'paris_competitions_controller'

# Re-raise errors caught by the controller.
class ParisCompetitionsController; def rescue_action(e) raise e end; end

class ParisCompetitionsControllerTest < Test::Unit::TestCase
  fixtures :paris_competitions

  def setup
    @controller = ParisCompetitionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = paris_competitions(:first).id
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

    assert_not_nil assigns(:paris_competitions)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:paris_competition)
    assert assigns(:paris_competition).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:paris_competition)
  end

  def test_create
    num_paris_competitions = ParisCompetition.count

    post :create, :paris_competition => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_paris_competitions + 1, ParisCompetition.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:paris_competition)
    assert assigns(:paris_competition).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      ParisCompetition.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      ParisCompetition.find(@first_id)
    }
  end
end
