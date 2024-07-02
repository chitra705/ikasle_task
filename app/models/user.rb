class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable
  after_create :send_welcome_email

  enum role:{ 
    admin: 0,
    manager: 1,
    team_lead: 2,
    team_member: 3 
  }

  def self.create_user(incoming_values)
    user = User.new(incoming_values)
    user.save!
  end

  def self.update_user(user_id,incoming_values)
    user = User.find_by(id:user_id)
    user.email     = incoming_values["email"]
    user.user_role = incoming_values["user_role"]
    user.save!    
  end

  def delete_user(user_id)
    user = User.find_by(id:user_id)
    user.delete()
  end

  def get_all
    User.all
  end


  private

  def send_welcome_email
    WelcomeMailer.welcome_email(self).deliver_later
  end
end
