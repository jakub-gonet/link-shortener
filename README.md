# Link shortener

Just a simple, handcrafted and human-readable link shortener.
It creates shorts by taking random words from dictionary in pattern: 
`<adjective>-<adjective>-<animal name>`

## *[Live demo](https://url-shortener-rb.herokuapp.com)*

Available endpoints:
- `GET /r/:shortened_url`, redirects to given shortened URL
- `GET /stats`, gives aggregated info about shorts views day by day 
- `GET /stats/:shortened_url`, given views info about single shortened URL
- `GET /urls`, show last 30 shortened URLs
- `POST /urls`, creates new shortened URL
- `GET  /urls/:shortened_url`, gives info about givens short

# Additional info
Ruby version, RoR version, used gems:
- Ruby 2.6.1
- Ruby on Rails 5
- Rubocop
- Rspec
- Rdoc
- Simplecov

Used docker and docker compose to setup dev env

Images stored via Git LFS (Heroku doesn't handle Git LFS :<)

# Prerequisites
- PC (blessed by a priest using holy water)`
- Git
- Docker
- Docker-compose

# Installation
```ruby
git clone https://github.com/jakub-gonet/link-shortener.gitcd link-shortener
cd link-shortener
docker-compose build
```

To run the server on `localhost` use `docker-compose up`

# Remarks
Things that could be done better:
- UI (frontend is awful)
- Frontend should be split from backend (REST API server + some webpack frontend)
- URL accesses are saved in real time, directly into DB - should've used Redis for performance or some event based queue to write them in batches
- `.env` shouldn't be stored in VCS
- Project structure is mostly cleaned up, but it can be improved
- Implementing feature tests using Selenium or other tool