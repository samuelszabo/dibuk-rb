# Dibuk

TODO: describe your gem

## todo

- [ ] test wrong_email
- [ ] test sandbox with requests
- [ ] test Response errors
- [ ] test Response links (urls object)
- [ ] ~ cleanup Links @@formats

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dibuk'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install dibuk

## Terms

* **Seller** - Dibuk`s client, eshop, reseller, ..
* **User** - end customer, Seller`s customer
* **Order** - order which User made in eshop

## Usage


### 1. Create a client

```ruby
client = Dibuk::Client.new(seller_id: 'string', signature: 'string', sandbox: true)
``` 

### 2. Set an User

```ruby
user = Dibuk::User.new(
    id: '123',  # user id from your database
    email: 'john.doe@example.com',
    name: 'John',
    surname: 'Doe'
)
```

### 3. Set an Item

```ruby
item = Dibuk::Item.new(
    id: '15351',  # item id from our catalog
    order_id: '12345641', # user\`s order id
    payment_id: 'int',  # payment_channel
    price: '12.5',  # selling price
    currency: 'EUR',  # currency
    unique_id: '13512151'  # unique id of combination order and item, eg. orders_items.id
)
```

### 4. Create a license (buy)
This function will create license. It need to be called just once of each item and user. Repeated call with same date will not create new license and still return success.
```ruby
response = client.license(user, item)
response.success?
# => true
```

### 5a. Send an ebook to email
This function use Dibuk\`s server to send ebook by email.
We support @kindle.com and @pocket email addresses.

```ruby
response = client.send(user, item, 'kindle.email@example.com')
response.success?
# => true
```

### 5b. Get a download links

Returns links to direct download of current users\`s files. It is limited in time urls related to current user (eg. ebook contains user\`s info). You can use it to download from server or directly redirect user to them.

```ruby
response = client.links(user, item)
response.success?
# => true
response.all
# => {"pdf"=>'https://download.link/pdf?hash', "epub"=>'https://download.link/epub?hash'}
response.epub
# => 'https://download.link/epub?hash' 
```

### Errors

```ruby
response.error_code
# => "todo"

response.limit_exceeded?
# => "todo"

response.not_buyed?
# you need to create license prior to send or get links
```


### Example
```ruby
client = Dibuk::Client.new(seller_id: 'string', signature: 'string', sandbox: true)

user = Dibuk::User.new(
    id: '123',  # user id from your database
    email: 'john.doe@example.com',
    name: 'John',
    surname: 'Doe'
)

item = Dibuk::Item.new(
    id: '15351',  # item id from our catalog
    order_id: '12345641', # user\`s order id
    payment_id: 'int',  # payment_channel
    price: '12.5',  # selling price
    currency: 'EUR',  # currency
    unique_id: '13512151'  # unique id of combination order and item, eg. orders_items.id
)

licensed = client.license(user, item)
# licensed.success? => true

sent = client.send(user, item, 'kindle.email@example.com')
# sent.success? => true
# sent.wrong_email? =>  
# sent.not_available_format? => 

links = client.links(user, item)
# links.success? => true
# links.all => {"pdf"=>'https://download.link/pdf?hash', "epub"=>'https://download.link/epub?hash'}
# links.epub => 'https://download.link/epub?hash'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dibukeu/client-rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/dibukeu/client-rb/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Dibuk project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/dibukeu/client-rb/blob/master/CODE_OF_CONDUCT.md).
