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


  ### MVP:

  - 1 Register and get claim

  ```
    Customer needs to provide his email, first and last name, and a list of flights from his itinerary.
    We want to validate the email that customer entered.
    Flight needs to have: departure airport code (IATA), arrival airport code (IATA), airline code (IATA), flight number and the
    departure date.
    Itinerary must have at least 1 flight.
  ```

  - 2 Claim eligibility

  ```
    We want to calculate the eligibility for the claim using the following algorithm:
    If any of the flights in the claim are delayed by more than 180 minutes,
    or are cancelled, we consider the whole claim as eligible.
    We want to calculate the eligibility for every claim that is registered with us, and be able to return it via API anytime.
  ```

  - 3 Claim notification

  ```
    We want to notify the system about any newly-created eligible claim
  ```

  - 4 Claim download

  ```
    Our Ops Agents often need to download data for the whole batch of claims.
    They want to be able to download all the eligible claims for the provided flight identifier.
    They want to download it in the CSV format.
    If any flight from the claim matches the identifier, the claim should be returned.
    The particular format is needed by one of the tools that they use, so it cannot be changed.
  ```

  ### Contract Interface:

  **POST /api/claims**
  ----
  Creates a new claim and returns the claim_id.
  * **Data Params**  
  ```
  {
    email*: string
    first_name*: string
    last_name*: string
    flights: [
      airlineCode*: string
      flightNumber*: string
      departureDate*: string
      departureAirportCode*: string
      arrivalAirportCode*: string
    ]
  }
  ```
  * **Headers**  
  Content-Type: application/json  
  * **Success Response:**  
  * **Code:** 200  
  **Content:**  `{ claim_id: string }`
  * **Error Response:**  
  * **Code:** 400
  **Content:**  `{ message: string }`

  **GET /api/claims/:id**
  ----
  Returns the specified claim state (`in_progress`, `rejected`, `eligible`)
  * **URL Params**
  Required: id=[integer]
  `id` means `flight_identifier`
  * **Headers**  
  Content-Type: application/json  
  * **Success Response:**  
  * **Code:** 200  
  **Content:**  `{ state: string }`
  * **Error Response:**  
  * **Code:** 404  
  **Content:**  `{ message: string }`

  **GET /api/flights/:id**
  ----
  Returns the CSV by default
  * **URL Params**
  Required: id=[integer]
  `id` means `flight_identifier`
  * **Headers**  
  Content-Type: application/json  
  * **Success Response:**  
  * **Code:** 200  
  **Content:**  `claim_id,email,first_name,last_name,flight_identifiers
61c76837-f88d-4d61-91dc-4b25792eb8dc,test@example.com,Jon,Snow,"[""SK-2550-20201228-MAN-ARN""]"`


  ### TODO:
  - error handling and logging
  - tests
  - move API docs to Swagger
  - improve results
  - load tests
  - rubocop & brakeman
