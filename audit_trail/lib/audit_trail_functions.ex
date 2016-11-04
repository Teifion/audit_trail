defmodule Centaur.AuditTrailLib do
  alias Centaur.Repo
  alias Centaur.AuditTrail
  
  def add_audit_trail(user_id, action, details, ip \\ "") do
    AuditTrail.changeset(%AuditTrail{
      user_id: user_id,
      action: action,
      details: details,
      ip: ip
    })
    |> Repo.insert
  end
end