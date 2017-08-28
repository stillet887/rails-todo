require "rails_helper"

RSpec.describe TasksController, :type => :controller do
  include FactoryGirl::Syntax::Methods
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the posts into @tasks" do
      Task.all.destroy_all
      tasks = create_list(:task, 2)
      get :index

      expect(assigns(:tasks)).to match_array(tasks)
    end
  end

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    it "create with valid title" do
      task_count_before = Task.all.count
      valid_title = Faker::ElderScrolls.dragon

      post :create, params: {task: {title: valid_title}}

      expect(Task.all.count).to eq(task_count_before + 1)
      expect(Task.last[:title]).to eq(valid_title)
    end

    it "create with invalid title" do
      task_count_before = Task.all.count
      invalid_title = Faker::ElderScrolls.dragon[0..3]

      post :create, params: {task: {title: invalid_title}}

      expect(Task.all.count).to eq(task_count_before)
    end
  end

  describe "GET #edit" do
    it "responds successfully with an HTTP 200 status code" do
      task = create(:task)

      get :edit, params: {id: task[:id]}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      task = create(:task)

      get :edit, params: {id: task[:id]}
      expect(response).to render_template("edit")
    end
  end

  describe "PUT #update" do
    it "update with valid title" do
      task = create(:task)
      new_valid_title = Faker::ElderScrolls.dragon

      put :update, params: {id: task[:id], task: {title: new_valid_title, status: true}}
      task.reload

      expect(task[:title]).to eq(new_valid_title)
    end

    it "update with invalid title" do
      old_title = Faker::ElderScrolls.dragon
      task = create(:task, title: old_title)
      new_invalid_title = Faker::ElderScrolls.dragon[0..3]

      put :update, params: {id: task[:id], task: {title: new_invalid_title, status: true}}
      task.reload

      expect(task[:title]).to eq(old_title)
    end
  end

  describe "DELETE #destroy" do
    it "delete task" do
      task = create(:task)

      delete :destroy, params: {id: task[:id]}
      expect(Task.find_by(id: task[:id])).to eq(nil)
    end
  end
end