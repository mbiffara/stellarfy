# Stellarfy
Stellarfy is a Rails engine with the necessary tools to interact with Stellar Anchors and Stellar Horizon API in a easy way.  
It's mainly developed by [Pactta](https://www.pactta.com) for it's Payments API.  
It's built on top of the effort made by Astroband by developing the [Ruby Stellar SDK](https://github.com/astroband/ruby-stellar-sdk)

It includes models and interactors logic for SEP-1, SEP-10, SEP-10 w/memo, SEP-12 & SEP-38

## Dependencies
This engine works only with Postgresql at the moment. The reason for this is that we stored serialized data in jsonb columns.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "stellarfy"
```

And then execute:
```bash
$ bundle
```

**Mount Engine within your app**
Mount the stellarfy engine in your main app's routes.rb file
```
mount Stellarfy::Engine => '/stellarfy'
```

**Install Migrations**
```
rails stellarfy:install:migrations
```

## Usage
How to use my plugin.

## Contributing
Feel free to open a PR that will be reviewed by the team at [Pactta](https://www.pactta.com)

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
