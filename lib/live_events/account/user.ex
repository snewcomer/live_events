defmodule LiveEvents.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :ph_number, :integer
    field :owner, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :ph_number, :owner])
    |> validate_required([:name, :email, :owner])
  end
end
