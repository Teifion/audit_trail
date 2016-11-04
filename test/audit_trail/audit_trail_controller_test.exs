defmodule Centaur.AuditTrailControllerTest do
  use Centaur.ConnCase

  alias Centaur.AuditTrail
  @valid_attrs %{action: "some content", details: "some content", ip: "some content", timestamp: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, audit_trail_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing audit trails"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, audit_trail_path(conn, :new)
    assert html_response(conn, 200) =~ "New audit trail"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, audit_trail_path(conn, :create), audit_trail: @valid_attrs
    assert redirected_to(conn) == audit_trail_path(conn, :index)
    assert Repo.get_by(AuditTrail, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, audit_trail_path(conn, :create), audit_trail: @invalid_attrs
    assert html_response(conn, 200) =~ "New audit trail"
  end

  test "shows chosen resource", %{conn: conn} do
    audit_trail = Repo.insert! %AuditTrail{}
    conn = get conn, audit_trail_path(conn, :show, audit_trail)
    assert html_response(conn, 200) =~ "Show audit trail"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, audit_trail_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    audit_trail = Repo.insert! %AuditTrail{}
    conn = get conn, audit_trail_path(conn, :edit, audit_trail)
    assert html_response(conn, 200) =~ "Edit audit trail"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    audit_trail = Repo.insert! %AuditTrail{}
    conn = put conn, audit_trail_path(conn, :update, audit_trail), audit_trail: @valid_attrs
    assert redirected_to(conn) == audit_trail_path(conn, :show, audit_trail)
    assert Repo.get_by(AuditTrail, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    audit_trail = Repo.insert! %AuditTrail{}
    conn = put conn, audit_trail_path(conn, :update, audit_trail), audit_trail: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit audit trail"
  end

  test "deletes chosen resource", %{conn: conn} do
    audit_trail = Repo.insert! %AuditTrail{}
    conn = delete conn, audit_trail_path(conn, :delete, audit_trail)
    assert redirected_to(conn) == audit_trail_path(conn, :index)
    refute Repo.get(AuditTrail, audit_trail.id)
  end
end
