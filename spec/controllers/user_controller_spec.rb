require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  describe 'GET index' do
    let!(:user1) { FactoryGirl.create(:user) }
    let!(:user2) { FactoryGirl.create(:user) }

    before(:each) do
      login_user
      get :index
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'renders an index template' do
      expect(response).to render_template('index')
    end

    it 'populates an array of users' do
      expect(assigns(:users)).to include(user1, user2)
    end
  end

  describe 'GET show' do
    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      login_user
      get :show, { id: user.id }
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'renders a show template' do
      expect(response).to render_template('show')
    end

    it 'assigns the user to @user' do
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'GET admin_new' do
    before(:each) do
      login_admin
      get :admin_new
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'renders a new template' do
      expect(response).to render_template('admin_new')
    end

    it 'assigns the new User to @user' do
      expect(assigns(:user)).to be_kind_of(User)
    end
  end

  describe 'POST admin_create' do
    before(:each) { login_admin }

    context 'with valid attributes' do
      it 'creates a new user' do
        expect{ post :admin_create, user: FactoryGirl.attributes_for(:user) }.to change(User, :count).by(1)
      end

      it 'redirects to the new user' do
        post :admin_create, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to User.last
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new user' do
        expect{ post :admin_create, user: FactoryGirl.attributes_for(:user, first_name: nil) }.to_not change(User, :count)
      end

      it 're-renders the new method' do
        post :admin_create, user: FactoryGirl.attributes_for(:user, first_name: nil)
        expect(response).to render_template :admin_new
      end
    end
  end

  describe 'PUT update' do
    before(:each) do
      login_user
      @user = @current_user
    end

    context 'valid attributes' do
      it 'located the requested @user' do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user)
        expect(assigns(:user)).to eq(@user)
      end

      it "changes @user's attributes" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, first_name: 'John', last_name: 'Johns')
        @user.reload
        expect(@user.first_name).to eq('John')
        expect(@user.last_name).to eq('Johns')
      end

      it 'redirects to the updated user' do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to @user
      end
    end

    context 'invalid attributes' do
      it 'locates the requested @user' do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, first_name: nil)
        expect(assigns(:user)).to eq(@user)
      end
    
      it "does not change @user's attributes" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, first_name: nil, last_name: 'Johns')
        @user.reload
        expect(@user.first_name).to eq(@current_user.first_name)
        expect(@user.last_name).to eq(@current_user.last_name)
      end

      it 're-renders the edit method' do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, first_name: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'PUT admin_update' do
    before(:each) do
      login_admin
      @user = FactoryGirl.create(:user)
    end

    context 'valid attributes' do
      it 'located the requested @user' do
        put :admin_update, id: @user, user: FactoryGirl.attributes_for(:user)
        expect(assigns(:user)).to eq(@user)
      end

      it "changes @user's attributes" do
        put :admin_update, id: @user, user: FactoryGirl.attributes_for(:user, first_name: 'John', last_name: 'Johns')
        @user.reload
        expect(@user.first_name).to eq('John')
        expect(@user.last_name).to eq('Johns')
      end

      it 'redirects to the admin_updated user' do
        put :admin_update, id: @user, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to @user
      end
    end

    context 'invalid attributes' do
      it 'locates the requested @user' do
        put :admin_update, id: @user, user: FactoryGirl.attributes_for(:user, first_name: nil)
        expect(assigns(:user)).to eq(@user)
      end
    
      it "does not change @user's attributes" do
        users_first_name = @user.first_name
        users_last_name = @user.last_name
        put :admin_update, id: @user, user: FactoryGirl.attributes_for(:user, first_name: nil, last_name: 'Johns')
        @user.reload
        expect(@user.first_name).to eq(users_first_name)
        expect(@user.last_name).to eq(users_last_name)
      end

      it 're-renders the edit method' do
        put :admin_update, id: @user, user: FactoryGirl.attributes_for(:user, first_name: nil)
        expect(response).to render_template :admin_edit
      end
    end
  end

  describe 'DELETE destroy' do
    before(:each) do
      login_user
      @user = @current_user
    end
    
    it 'deletes the user' do
      expect{ delete :destroy, id: @user }.to change(User, :count).by(-1)
    end

    it 'redirects to users#index' do
      delete :destroy, id: @user
      expect(response).to redirect_to users_url
    end
  end

  describe 'GET show_users_posts' do
    before(:each) { login_user }

    it 'renders user/:id/posts template' do
      user = FactoryGirl.create(:user)
      get :show_users_posts, id: user.id
      expect(response).to render_template :show_users_posts
    end

    it 'locates the requested @posts' do
      user = FactoryGirl.create(:user)
      post1 = FactoryGirl.create(:post, user: user)
      post2 = FactoryGirl.create(:post, user: user)
      get :show_users_posts, id: user.id
      expect(assigns(:posts)).to eq([post1, post2]) 
    end
  end
end
