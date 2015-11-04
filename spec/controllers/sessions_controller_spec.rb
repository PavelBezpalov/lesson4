require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      get 'new'
      expect(response).to render_template('new')
    end

  end

  describe "POST #create" do
    context 'with valid user' do
      let!(:user) { User.create(name: 'Pavel',
                         email: 'pavel.bezpalov@cyber-wizard.com',
                         password: '12345678',
                         password_confirmation: '12345678') }

      it 'redirects to the posts path' do
        post :create, email: 'pavel.bezpalov@cyber-wizard.com', password: '12345678'
        expect(response).to redirect_to(posts_path)
      end

      it 'finds the user' do
        expect(User).to receive(:find_by).with({email: 'pavel.bezpalov@cyber-wizard.com'}).and_return(user)
        post :create, email: 'pavel.bezpalov@cyber-wizard.com', password: '12345678'
      end

      it 'authenticates the user' do
        # RSpec Mocks http://www.relishapp.com/rspec/rspec-mocks/v/3-3/docs/configuring-responses/returning-a-value
        allow(User).to receive(:find_by_email).and_return(user)
        expect(user).to receive(:authenticate)
        post :create, email: 'pavel.bezpalov@cyber-wizard.com', password: '12345678'
      end

      it 'sets the user_id in the session' do
        post :create, email: 'pavel.bezpalov@cyber-wizard.com', password: '12345678'
        expect(session[:user_id]).to eq(user.id)
      end

      it 'sets the flash success message' do
        post :create, email: 'pavel.bezpalov@cyber-wizard.com', password: '12345678'
        expect(flash[:success]).to eq('Your successfully logging in!')
      end
    end

    # Shared examples http://www.relishapp.com/rspec/rspec-core/v/3-3/docs/example-groups/shared-examples
    shared_examples 'denied login' do
      it 'renders the new template' do
        post :create, email: email, password: password
        expect(response).to render_template('new')
      end

      it 'sets the flash error message' do
        post :create, email: email, password: password
        expect(flash[:error]).to eq('There was a problem logging in. Please check your email and password.')
      end
    end

    context 'without user credentials' do
      let(:email) { '' }
      let(:password) { '' }
      it_behaves_like 'denied login'
    end

    context 'with not existed email' do
      let(:email) { 'not.found@email.com' }
      let(:password) { 'somepassword' }
      it_behaves_like 'denied login'
    end

    context 'with incorrect password' do
      let!(:user) { User.create(name: 'Pavel',
                                email: 'pavel.bezpalov@cyber-wizard.com',
                                password: '12345678',
                                password_confirmation: '12345678') }
      let(:email) { user.email }
      let(:password) { 'incorrect' }
      it_behaves_like 'denied login'
    end
  end
end
