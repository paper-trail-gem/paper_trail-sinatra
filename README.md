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

PaperTrail provides some helper extensions that acts similar to the controller mixin
it provides for `Rails` applications.

In your helpers you can override these methods:

```ruby
# Returns the user who is responsible for any changes that occur.
# Defaults to current_user.
user_for_paper_trail

# Returns any information about the controller or request that you want
# PaperTrail to store alongside any changes that occur.
info_for_paper_trail

# Returns `true` (default) or `false` to turn PaperTrail on/off for per request.
paper_trail_enabled_for_request
```

If you're using the modular [`Sinatra::Base`][4] style of application, you will
need to register the extension:

```ruby
# bleh_app.rb
require 'sinatra/base'

class BlehApp < Sinatra::Base
  register PaperTrail::Sinatra
end
```

[1]: http://www.sinatrarb.com
[2]: https://github.com/janko-m/sinatra-activerecord
[3]: https://raw.github.com/airblade/paper_trail/master/lib/generators/paper_trail/templates/create_versions.rb
[4]: http://www.sinatrarb.com/intro.html#Modular%20vs.%20Classic%20Style
