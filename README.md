# PaperTrail::Sinatra

Register this module inside your Sinatra application to gain access to
controller-level methods used by PaperTrail.

To configure PaperTrail for usage with [Sinatra][12], your `Sinatra` app must be
using `ActiveRecord` 3 or 4. There is no released version of sinatra yet that is
compatible with AR 5. We expect sinatra 2.0 to support AR 5, but it will have
breaking changes that will require changes to PaperTrail.

It is also recommended to use the
[Sinatra ActiveRecord Extension][13] or something similar for managing your
applications `ActiveRecord` connection in a manner similar to the way `Rails`
does. If using the aforementioned `Sinatra ActiveRecord Extension`, steps for
setting up your app with PaperTrail will look something like this:

1. Add PaperTrail to your `Gemfile`.

  `gem 'paper_trail'`

2. Generate a migration to add a `versions` table to your database.

    `bundle exec rake db:create_migration NAME=create_versions`

3. Copy contents of [create_versions.rb][14]
into the `create_versions` migration that was generated into your `db/migrate` directory.

4. Run the migration.

    `bundle exec rake db:migrate`

5. Add `has_paper_trail` to the models you want to track.

PaperTrail provides a helper extension that acts similar to the controller mixin
it provides for `Rails` applications.

It will set `PaperTrail.whodunnit` to whatever is returned by a method named
`user_for_paper_trail` which you can define inside your Sinatra Application. (by
default it attempts to invoke a method named `current_user`)

If you're using the modular [`Sinatra::Base`][15] style of application, you will
need to register the extension:

```ruby
# bleh_app.rb
require 'sinatra/base'

class BlehApp < Sinatra::Base
  register PaperTrail::Sinatra
end
```
