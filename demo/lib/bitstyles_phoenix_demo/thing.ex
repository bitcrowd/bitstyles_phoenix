defmodule BitstylesPhoenixDemo.Thing do
  use Ecto.Schema

  import Ecto.Changeset

  embedded_schema do
    field(:name, :string)
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
