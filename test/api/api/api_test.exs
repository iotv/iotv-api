defmodule Api.ApiTest do
  use Api.DataCase

  alias Api.Api

  describe "users" do
    alias Api.Api.User

    @valid_attrs %{email: "some email", real_name: "some real_name", user_name: "some user_name"}
    @update_attrs %{email: "some updated email", real_name: "some updated real_name", user_name: "some updated user_name"}
    @invalid_attrs %{email: nil, real_name: nil, user_name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Api.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Api.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Api.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Api.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.real_name == "some real_name"
      assert user.user_name == "some user_name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Api.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Api.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.real_name == "some updated real_name"
      assert user.user_name == "some updated user_name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Api.update_user(user, @invalid_attrs)
      assert user == Api.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Api.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Api.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Api.change_user(user)
    end
  end
end