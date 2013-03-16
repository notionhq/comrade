class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:github]
  

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :name, :avatar, :github, :login
  # attr_accessible :title, :body
  
  
  def self.find_for_github_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      puts "YUP RIGHT HERE!!"
      puts auth.to_yaml
      user = User.create(provider:auth.provider,
                           uid:auth.uid,
                           name:auth.info.name,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20],
                           avatar:auth.info.image,
                           github:auth.info.urls.GitHub,
                           login:auth.extra.raw_info.login
                           )
    end
    user
  end
end
