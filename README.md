# README

## Development
### Dependencies

- ruby 3.0.2
- postgresql database
- redis

### Important gems:

- [Typhoeus](https://github.com/typhoeus/typhoeus) HTTP requests in parallel

Assuming you work on macOS and use [rbenv](http://http://rbenv.org/):
1. Install dependencies listed in the [dependencies section](#dependencies)

    ```shell
    rbenv install 3.0.2 && rbenv local 3.0.2
    brew update
    brew install redis
    ```

2. Run migrations:

    ```shell
    bundle exec rake db:create && bundle exec rake db:migrate && bundle
    ```

  ### Running the app

  - Rails server: `bundle exec rails s`
  - Sidekiq worker: `bundle exec sidekiq`

  ### Using POSTMAN collection for testing locally:
    - my POSTMAN collection is in `public\Claim API.postman_collection.json` directory - upload it directly to your Postman
