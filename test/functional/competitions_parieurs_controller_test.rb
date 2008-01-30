require File.dirname(__FILE__) + '/../test_helper'
require 'competitions_parieurs_controller'

# Re-raise errors caught by the controller.
class CompetitionsParieursController; def rescue_action(e) raise e end; end

class CompetitionsParieursControllerTest < Test::Unit::TestCase
  fixtures :competitions_parieurs

  def setup
    @controller = CompetitionsParieursController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = competitions_parieurs(:first).id
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

    assert_not_nil assigns(:competitions_parieurs)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:competitions_parieur)
    assert assigns(:competitions_parieur).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:competitions_parieur)
  end

  def test_create
    num_competitions_parieurs = CompetitionsParieur.count

    post :create, :competitions_parieur => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_competitions_parieurs + 1, CompetitionsParieur.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:competitions_parieur)
    assert assigns(:competitions_parieur).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      CompetitionsParieur.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      CompetitionsParieur.find(@first_id)
    }
  end
end
