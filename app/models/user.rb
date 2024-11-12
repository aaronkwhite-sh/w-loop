class User < ActiveRecord::Base
  include PgSearch
  multisearchable against: [:name, :email]
  pg_search_scope :partial_usersearch,
    :against => {
      :name => 'A',
      :email => 'B'
    },
    :using => {
      :tsearch => {:prefix => true}
    }

  has_many :metoos, dependent: :destroy
  has_many :followups, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update



  def add_company(company)
    update_attributes companies: companies + [ company ]
  end

  def feed
    Micropost.from_users_followed_by(self)
  end

  def favs
    Micropost.from_users_fav_by(self)
    #Favorite.where(user_id: self)
  end

  def metoos
    Micropost.from_users_metoo_by(self)
  end

  def followups
    Micropost.from_users_followup_by(self)
  end

  def myposts
    Micropost.from_users_myposts_by(self)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          #email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          email: auth.extra.raw_info.email,
          #email_verified: auth.extra.raw_info.email_verified,
          avatar: auth.extra.raw_info.picture,
          provider: "Google",
          
          password: Devise.friendly_token[0,20]

        )
        if auth.extra.raw_info.hd == "workiva.com"
          user.skip_confirmation!
          user.save!
        #else
        #  redirect_to root
        end

      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end
end