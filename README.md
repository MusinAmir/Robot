# Robot for https://target.my.com (authorization and ad unit creation)
Using Watir, phantomjs, sidekiq, redis
To run robot: ruby robot/lib/robot.rb 

```ruby
robot = Robot.new("your login", "your password")
# authorizing in https://target-sandbox.my.com
robot.authorize 
# creating ad unit
robot.create_ad_unit("app_name", "app_url")
# getting all ad units from account
robot.get_all_ad_units 
# closing session
robot.logout 
```