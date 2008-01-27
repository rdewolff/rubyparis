require File.dirname(__FILE__) + '/../test_helper'
require 'personnes_controller'

# Re-raise errors caught by the controller.
class PersonnesController; def rescue_action(e) raise e end; end

class PersonnesControllerTest < Test::Unit::TestCase
  fixtures :personnes

  def setup
    @controller = PersonnesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = personnes(:first).id
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

    assert_not_nil assigns(:personnes)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:personne)
    assert assigns(:personne).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:personne)
  end

  def test_create
    num_personnes = Personne.count

    post :create, :personne => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_personnes + 1, Personne.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:personne)
    assert assigns(:personne).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Personne.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Personne.find(@first_id)
    }
  end
end
