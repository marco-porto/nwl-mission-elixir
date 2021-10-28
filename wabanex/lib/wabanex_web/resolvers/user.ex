defmodule  WabanexWeb.Resolvers.User do
  def get(%{id: user_id},_context), do: Wabanex.Users.Get.call(id)
end
