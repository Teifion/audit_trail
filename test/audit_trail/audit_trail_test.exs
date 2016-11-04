defmodule Centaur.AuditTrailTest do
  use Centaur.ModelCase

  alias Centaur.AuditTrail

  @valid_attrs %{action: "some content", details: "some content", ip: "some content", timestamp: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = AuditTrail.changeset(%AuditTrail{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = AuditTrail.changeset(%AuditTrail{}, @invalid_attrs)
    refute changeset.valid?
  end
end
