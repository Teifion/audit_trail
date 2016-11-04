# Purpose and usage
I wanted to create an incredibly simple plugin for a Phoenix site. It is nearly a completely unmodified "mix phoenix.gen.html". The reason for it is I wanted to see if this was the best possible way to create modular sections/functions for a phoenix project so I'd be able to export it to my other projects and for other people to use in their own projects.

A single function is made available as:

    Centaur.AuditTrailLib.add_audit_trail(user_id, action, details, ip \\ "")

It will take the variables and create an audit trail entry in the database. Because it's just a standard phoenix.gen.html it is woefully inadequate as an actual audit trail system since it has no access control and allows deletion of logs. However, it should serve the purpose of acquiring feedback on how to share a phoenix module.


# Installation
My application is named Centaur, you will need to perform a find-replace on Centaur and whatever your application name is.

    $ mix ecto.gen.migration create_audit_trails_table

Now edit the migration file to be the following:

    defmodule Centaur.Repo.Migrations.CreateAuditTrail do
      use Ecto.Migration

      def change do
        create table(:audit_trails) do
          add :action, :string
          add :details, :string
          add :ip, :string
          add :user_id, references(:users)
          
          timestamps()
        end

      end
    end

**Update router.ex**

    scope "/audit_trail", Centaur do
      pipe_through :browser
      
      resources "/", AuditTrailController
    end

**Move files**

    /audit_trail -> /web/audit_trail
    
    /templates/audit_trail -> /web/templates/audit_trail
    
    /test/audit_trail -> /test/audit_trail

**Migrate**

    mix ecto.migrate
    
**Try out the module**

    mix phoenix.server
    
    Point browser to: http://localhost:4000/audit_trail
