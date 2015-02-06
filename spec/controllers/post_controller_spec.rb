require 'rails_helper'

RSpec.describe PostsController, :type => :controller do
  describe 'GET index' do
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

    it 'populates an array of posts' do
      post1 = FactoryGirl.create(:post)
      post2 = FactoryGirl.create(:post)
      expect(assigns(:posts)).to eq([post1, post2])
    end
  end

  describe 'GET show' do
    let(:post) { FactoryGirl.create(:post) }

    before(:each) do
      login_user
      get :show, { id: post.id }
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'renders a show template' do
      expect(response).to render_template('show')
    end

    it 'assigns the post to @post' do
      expect(assigns(:post)).to eq(post)
    end
  end

  describe 'GET new' do
    before(:each) do
      login_user
      get :new
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'renders a new template' do
      expect(response).to render_template('new')
    end

    it 'assigns the new Post to @post' do
      expect(assigns(:post)).to be_kind_of(Post)
    end
  end

  describe 'POST create' do
    before(:each) { login_user }

    context 'with valid attributes' do
      it 'creates a new post' do
        expect{ post :create, post: FactoryGirl.attributes_for(:post) }.to change(Post, :count).by(1)
      end

      it 'redirects to the new post' do
        post :create, post: FactoryGirl.attributes_for(:post)
        expect(response).to redirect_to Post.last
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new post' do
        expect{ post :create, post: FactoryGirl.attributes_for(:post, title: nil) }.to_not change(Post, :count)
      end

      it 're-renders the new method' do
        post :create, post: FactoryGirl.attributes_for(:post, title: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT update' do
    before(:each) do
      login_user
      @post = FactoryGirl.create(:post, user: @current_user, title: 'Post', content: 'New content')
    end

    context 'valid attributes' do
      it 'located the requested @post' do
        put :update, id: @post, post: FactoryGirl.attributes_for(:post)
        expect(assigns(:post)).to eq(@post)
      end

      it "changes @post's attributes" do
        put :update, id: @post, post: FactoryGirl.attributes_for(:post, title: 'Test post', content: 'Test content')
        @post.reload
        expect(@post.title).to eq('Test post')
        expect(@post.content).to eq('Test content')
      end

      it 'redirects to the updated post' do
        put :update, id: @post, post: FactoryGirl.attributes_for(:post)
        expect(response).to redirect_to @post
      end
    end

    context 'invalid attributes' do
      it 'locates the requested @post' do
        put :update, id: @post, post: FactoryGirl.attributes_for(:post, title: nil)
        expect(assigns(:post)).to eq(@post)
      end
    
      it "does not change @post's attributes" do
        put :update, id: @post, post: FactoryGirl.attributes_for(:post, title: 'Test post', content: nil)
        @post.reload
        expect(@post.title).to_not eq('Test post')
        expect(@post.content).to eq('New content')
      end

      it 're-renders the edit method' do
        put :update, id: @post, post: FactoryGirl.attributes_for(:post, title: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    before(:each) do
      login_user
      @post = FactoryGirl.create(:post, user: @current_user)
    end
    
    it 'deletes the post' do
      expect{ delete :destroy, id: @post }.to change(Post, :count).by(-1)
    end

    it 'redirects to posts#index' do
      delete :destroy, id: @post
      expect(response).to redirect_to posts_url
    end
  end
end
