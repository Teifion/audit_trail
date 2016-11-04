defmodule Centaur.AuditTrailController do
  use Centaur.Web, :controller
  
  alias Centaur.AuditTrail
  
  def index(conn, _params) do
    audit_trails = Repo.all(AuditTrail)
    render(conn, "index.html", audit_trails: audit_trails)
  end

  def new(conn, _params) do
    changeset = AuditTrail.changeset(%AuditTrail{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"audit_trail" => audit_trail_params}) do
    changeset = AuditTrail.changeset(%AuditTrail{}, audit_trail_params)
    
    case Repo.insert(changeset) do
      {:ok, _audit_trail} ->
        conn
        |> put_flash(:info, "Audit trail created successfully.")
        |> redirect(to: audit_trail_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    audit_trail = Repo.get!(AuditTrail, id)
    render(conn, "show.html", audit_trail: audit_trail)
  end

  def edit(conn, %{"id" => id}) do
    audit_trail = Repo.get!(AuditTrail, id)
    changeset = AuditTrail.changeset(audit_trail)
    render(conn, "edit.html", audit_trail: audit_trail, changeset: changeset)
  end

  def update(conn, %{"id" => id, "audit_trail" => audit_trail_params}) do
    audit_trail = Repo.get!(AuditTrail, id)
    changeset = AuditTrail.changeset(audit_trail, audit_trail_params)

    case Repo.update(changeset) do
      {:ok, audit_trail} ->
        conn
        |> put_flash(:info, "Audit trail updated successfully.")
        |> redirect(to: audit_trail_path(conn, :show, audit_trail))
      {:error, changeset} ->
        render(conn, "edit.html", audit_trail: audit_trail, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    audit_trail = Repo.get!(AuditTrail, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(audit_trail)

    conn
    |> put_flash(:info, "Audit trail deleted successfully.")
    |> redirect(to: audit_trail_path(conn, :index))
  end
end
