class DeleteTaskTest < Test::Unit::TestCase
  include ServerTestHelper
  include UserFactory
  include TaskFactory

  def test_post_task_success
    user = create_user!(email: 'test@acme.com')
    create_task!(user: user, name: 'My first task!')

    server.print(prepare_request(
      "DELETE /tasks/1",
      "Cookie: email=test@acme.com"
    ))

    assert remove_cr(response).match(/HTTP\/1\.1 206.*?/)
  end
end
