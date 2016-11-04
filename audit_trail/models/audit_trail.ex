defmodule Centaur.AuditTrail do
  use Centaur.Web, :model
  
  schema "audit_trails" do
    field :action, :string
    field :details, :string
    field :ip, :string
    
    belongs_to :user, Centaur.General.User
    
    timestamps()
  end
  
  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:action, :details, :ip, :user_id])
    |> validate_required([:action, :details, :ip])
  end
end
