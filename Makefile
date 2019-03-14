run-test-pa11y:
	docker-compose up -d
	docker-compose exec app rake db:create db:migrate
	docker-compose exec app bundle exec rails assets:precompile
	sleep 10
	cd client && yarn run test-pa11y

stop-application:
	docker-compose down
