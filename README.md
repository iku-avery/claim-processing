# README

## Development
### Dependencies

- ruby 3.0.2
- postgresql database
- redis

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
