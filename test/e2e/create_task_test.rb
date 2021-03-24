class CreateTaskTest < Test::Unit::TestCase
  include ServerTestHelper
  include UserFactory

  def test_post_task_success
    create_user!(email: 'test@acme.com')

    server.puts(prepare_request(
      "POST /tasks",
      "Cookie: email=test@acme.com\r\nContent-Length: 32",
      "name=Finish server configuration"
    ))

    assert remove_cr(response).match(/HTTP\/1\.1 301.*?/)
  end
end
