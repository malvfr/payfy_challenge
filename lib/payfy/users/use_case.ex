defmodule Payfy.Users.UseCase do
  alias Payfy.Users

  def create_user(params) do
    Users.Mutator.create_user(params)
  end

  def get_user_by_id(id) do
    Users.Loader.by_id(id)
  end

  def get_all() do
    Users.Loader.get_all()
  end
end
