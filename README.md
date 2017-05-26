# PaperTrail::Sinatra

Register this module inside your Sinatra application to gain access to
controller-level methods used by PaperTrail.

To configure PaperTrail for usage with [Sinatra][1], your `Sinatra` app must be
using `ActiveRecord` 3, 4, or 5.

It is recommended to use the
[Sinatra ActiveRecord Extension][2] or something similar for managing your
application's `ActiveRecord` connection in a manner similar to the way `Rails`
does. If using the aforementioned `Sinatra ActiveRecord Extension`, steps for
setting up your app with PaperTrail will look something like this:

1. Add PaperTrail to your `Gemfile`.

```
gem 'paper_trail'
gem 'paper_trail-sinatra'
```

2. Generate a migration to add a `versions` table to your database.

    `bundle exec rake db:create_migration NAME=create_versions`

3. Copy contents of [create_versions.rb][3]
into the `create_versions` migration that was generated into your `db/migrate` directory.

4. Run the migration.

    `bundle exec rake db:migrate`

5. Add `has_paper_trail` to the models you want to track.

PaperTrail provides a helper extension that acts similar to the controller mixin
it provides for `Rails` applications.

It will set `PaperTrail.whodunnit` to whatever is returned by a method named
`user_for_paper_trail` which you can define inside your Sinatra Application. (by
default it attempts to invoke a method named `current_user`)

If you're using the modular [`Sinatra::Base`][4] style of application, you will
need to register the extension:

```ruby
# bleh_app.rb
require 'sinatra/base'

class BlehApp < Sinatra::Base
  register PaperTrail::Sinatra
end
```

## Contributing

```
git clone
bundle
mkdir db
sqlite3 db/test.sqlite3
.read spec/create_db.sql
bundle exec rspec
```

[1]: http://www.sinatrarb.com
[2]: https://github.com/janko-m/sinatra-activerecord
[3]: https://raw.github.com/airblade/paper_trail/master/lib/generators/paper_trail/templates/create_versions.rb
[4]: http://www.sinatrarb.com/intro.html#Modular%20vs.%20Classic%20Style
