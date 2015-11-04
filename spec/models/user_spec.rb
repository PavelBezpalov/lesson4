require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:posts) }

  let(:valid_attributes) {
    {name: 'Pavel',
     email: 'pavel.bezpalov@cyber-wizard.com',
     password: '12345678',
     password_confirmation: '12345678'
    }
  }

  context 'validations' do
    let(:user) { User.new(valid_attributes) }

    before do
      User.create(valid_attributes)
    end

    it 'requires an email' do
      expect(user).to validate_presence_of(:email)
    end

    it 'requires a unique email' do
      expect(user).to validate_uniqueness_of(:email)
    end

    it 'requires the email address to look like an email' do
      user.email = 'pavel'
      expect(user).to_not be_valid
    end

    context '#downcase_email' do
      it 'makes the email attribute lower case' do
        user = User.new(name: 'Pavel', email: 'TRATATATA@AGRESSOR.COM')
        expect { user.downcase_email }.to change { user.email }.
            from('TRATATATA@AGRESSOR.COM').
            to('tratatata@agressor.com')
      end

      it 'downcases an email before saving' do
        user = User.new(valid_attributes)
        user.email = 'TRATATATA@AGRESSOR.COM'
        expect(user.save).to be_truthy
        expect(user.email).to eq('tratatata@agressor.com')
      end
    end
  end
end
