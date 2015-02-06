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

  def attributes_from_omniauth=(auth)
    self.uid ||= auth.uid
    self.provider ||= auth.provider

    if info = auth.info
      self.username = info.nickname
      self.name = info.name
      self.first_name = info.first_name
      self.last_name = info.last_name
      self.email = info.email
    end

    if extra = auth.extra and
      raw_info = extra.raw_info and
      member = raw_info.member

      self.membership_created_at = Time.at(member.created_at)
      self.unrestricted_access = member.unrestricted_access
      self.stripe_customer_id = member.stripe_customer_id
    end
  end

end
