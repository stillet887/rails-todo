require "rails_helper"

RSpec.describe TasksController, :type => :controller do
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
      task1, task2 = Task.create(title: 'task description 1'), Task.create(title: 'task description 2')
      get :index

      expect(assigns(:tasks)).to match_array([task1, task2])
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
      expect(Task.all.count).to eq(0)
      valid_title = 'long task description'

      post :create, :task => {:title => valid_title}

      expect(Task.all.count).to eq(1)
      expect(assigns(:task)[:title]).to eq(valid_title)
    end

    it "create with invalid title" do
      expect(Task.all.count).to eq(0)
      invalid_title = 'too small'

      post :create, :task => {:title => invalid_title}

      expect(Task.all.count).to eq(0)
    end
  end

  describe "GET #edit" do
    it "responds successfully with an HTTP 200 status code" do
      task = Task.create(title: 'task description')

      get :edit, :id => task[:id]
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      task = Task.create(title: 'task description')

      get :edit, :id => task[:id]
      expect(response).to render_template("edit")
    end
  end

  describe "PUT #update" do
    it "update with valid title" do
      task = Task.create(title: 'task description', status: false)
      new_valid_title = 'new task description'

      put :update, :id => task[:id], :task => {:title => new_valid_title, :status => true}
      task.reload

      expect(task[:title]).to eq(new_valid_title)
    end

    it "update with invalid title" do
      task = Task.create(title: 'old description', status: false)
      new_invalid_title = 'too small'

      put :update, :id => task[:id], :task => {:title => new_invalid_title, :status => true}
      task.reload

      expect(task[:title]).to eq('old description')
    end
  end

  describe "DELETE #destroy" do
    it "delete task" do
      task = Task.create(title: 'task description', status: false)

      delete :destroy, :id => task[:id]
      expect(Task.find_by(id: task[:id])).to eq(nil)
    end
  end
end