#!/bin/sh

touch log/sidekiq.log
bundle exec rake assets:precompile
kill -s QUIT `cat tmp/unicorn.pid`
bundle exec unicorn  -c config/unicorn.rb -E production -D
