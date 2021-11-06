defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users queries" do
    test "when a valid id is given, return the use", %{conn: conn} do
      params = %{name: "Test", email: "test@example.com", password: "testpasswd"}

      {:ok, %User{id: user_id}} = Create.call(params)
      query = """
        {
          getUser(id: "#{user_id}"){
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "test@example.com",
            "name" => "Test"
          }
        }
      }

      assert response == expected_response
    end
  end


  describe "users mutations" do
    test "when all params are valid, create the user", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input: {
            name: "Test", email: "test@example.com", password: "testpasswd"
          }){
            id
            name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{"data" => %{"createUser" => %{"id" => _id, "name" => "Test"}}} = response
    end
  end
end
