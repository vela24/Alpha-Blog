ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors, with: :threads)
  parallelize(workers: 1)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def sign_in_as(user)
    # must hardcode password you want to use because user.password pulls the user_digest hash which cant be used
    post login_path, params: {session: { email: user.email,  password: "johndoe123"}}
  end
end
