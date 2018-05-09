## Contributing

```
git clone
bundle
mkdir db
sqlite3 db/test.sqlite3
.read spec/create_db.sql
bundle exec rubocop

# Test specific dependency versions
BUNDLE_GEMFILE=spec/gemfiles/pt9_sinatra2.rb bundle
BUNDLE_GEMFILE=spec/gemfiles/pt9_sinatra2.rb bundle exec rspec
```
