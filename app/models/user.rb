class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    if User.count == 0
      self.role ||= :admin
    else
      self.role ||= :user
    end
  end

  def self.create_with_omniauth(auth)
    Rails.logger.info "New user from auth hash:\n#{auth.inspect}"
    create! do |user|
      user.uid = auth.uid
      user.provider = auth.provider
      if info = auth.info
        user.username = info.nickname
        user.name = info.name
        user.first_name = info.first_name
        user.last_name = info.last_name
        user.email = info.email
      end
    end
  end

end
