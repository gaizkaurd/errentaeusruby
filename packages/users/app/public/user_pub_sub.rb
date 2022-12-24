UserPubSub = PubSubManager.new
UserPubSub.register_event('user.logged_in') do
  user_id Integer
  ip String
  provider String
  time String
  action 0
end

UserPubSub.register_event('user.refresh_token') do
  user_id Integer
  ip String
  time String
  action 1
end

UserPubSub.register_event('user.logout') do
  user_id Integer
  ip String
  action 2
end

UserPubSub.register_event('user.blocked') do
  user_id Integer
  action 3
end

UserPubSub.register_event('user.updated') do
  user_id Integer
  action 4
end

UserPubSub.subscribe('user.logged_in', LogAccountLoginJob)
UserPubSub.subscribe('user.refresh_token', LogAccountLoginJob)
UserPubSub.subscribe('user.logout', LogAccountLoginJob)
UserPubSub.subscribe('user.blocked', LogAccountLoginJob)
UserPubSub.subscribe('user.updated', LogAccountLoginJob)