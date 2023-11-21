**Setup**

To run this project

```
cp .example_env .env
```

put your IPSTACK_ACCESS_KEY, and preferred credentials in `.env` file

```
sudo DOCKER_BUILDKIT=0 docker-compose up -d --build
sudo docker ps
```

find container ID od assignment-app and run

```
sudo docker exec -it <ID> bash
```

and then

```
RAILS_ENV=production bundle exec rake db:create db:schema:load
RAILS_ENV=production bundle exec rake db:migrate
```

Please be cautious, since for the sake of testing production on localhost (which, I suspect will be the case here) ``config.force_ssl`` is set to ``false``

**Assumptions**

I made this API using Rails and Grape, which is a lightweight framework for building REST-like APIs. It's conventions are really simple and overall I think it's a great addition to every API-based RoR project.

In developer-client environment, I would strongly suggest to proceed with this project as it is:

- One GET request for retrieving geolocation data from the Ipstack API and caching/storing it in Postgres
- One DELETE request for removing any previously saved data

Code is checked using custom Rubocop config.

***Not finished parts***

I wish I had more time to do a whole lot of testing. Unfortunately I had a really rough week and my time is strongly limited. 

For what it's worth, I created a basic setup with FactoryBot and RSpec.

Originally I planned to use Casette for recording/mocking all http communication with Ipstack.

**Code**

Main business logic lies in services in ``services`` dir. 
``api`` dir contains endpoints and simple validation


