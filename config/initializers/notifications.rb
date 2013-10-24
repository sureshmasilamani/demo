
ActiveSupport::Notifications.subscribe do |name, start, finish, id, payload|
  Rails.logger.debug(["Notification:", name, start, finish, id, payload].join(" "))
end

