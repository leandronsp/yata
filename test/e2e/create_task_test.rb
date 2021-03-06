class CreateTaskTest < Test::Unit::TestCase
  include ServerTestHelper
  include UserFactory

  def test_post_task_success
    create_user!(email: 'test@acme.com')

    server.print(prepare_request(
      "POST /tasks",
      "Cookie: email=test@acme.com\r\nContent-Type: application/json\r\nContent-Length: 38",
      "{\"name\":\"Finish server configuration\"}"
    ))

    assert remove_cr(response).match(/HTTP\/1\.1 200.*?/)
  end
end
