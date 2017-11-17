require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it 'set safe code' do
    user = create :user

    # user.send(:ensure_user_key)
    expect(user.user_key.present?).to be_truthy
  end
end
