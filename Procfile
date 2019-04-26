web: bundle exec rails server -p $PORT
worker: bundle exec rake jobs:work
clock: bundle exec clockwork lib/clock.rb
release: bundle exec rails db:migrate
