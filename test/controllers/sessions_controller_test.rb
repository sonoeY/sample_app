require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  test "should get new" do
    get login_path #Sessionsコントローラのテストで名前付きルーティングを使うようにする
    assert_response :success
  end
end
