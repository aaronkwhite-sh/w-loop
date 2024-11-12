class Micropost < ActiveRecord::Base
  include SimpleHashtag::Hashtaggable
  after_initialize :defaults
  #has_many :metoos, dependent: :destroy
  #has_many :followups, dependent: :destroy
  #has_many :favorites, dependent: :destroy
  include PgSearch
  multisearchable against: [:content, :typeofcall, :company, :areaofapparray]
  pg_search_scope :partial_search,
    :against => {
      :content => 'A',
      :typeofcall => 'B',
      :company  => 'C',
      :areaofapparray  => 'D'
    },
    :using => {
      :tsearch => {:prefix => true}
    }

  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 500 }
  validates :user_id, presence: true
  validates :typeofcall, presence: true
  validates :company, presence: true
  validates :areaofapparray, presence: true

  def defaults
    self.min = '5' if self.min.nil?
    self.mood = '2' if self.mood.nil?
  end

  # Returns microposts from the users being followed by the given user.
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end

  def self.from_users_fav_by(user)
    fav_ids = "SELECT micropost_id FROM favorites
                         WHERE user_id = :user_id"
    where("id IN (#{fav_ids})",
          user_id: user.id)
  end

   def self.from_users_followup_by(user)
    followup_ids = "SELECT micropost_id FROM followups
                         WHERE user_id = :user_id"
    where("id IN (#{followup_ids})",
          user_id: user.id)
  end

   def self.from_users_metoo_by(user)
    metoo_ids = "SELECT micropost_id FROM metoos
                         WHERE user_id = :user_id"
    where("id IN (#{metoo_ids})",
          user_id: user.id)
  end

  def self.from_users_myposts_by(user)
    mypost_ids = "SELECT id FROM microposts
                         WHERE user_id = :user_id"
    where("id IN (#{mypost_ids})",
          user_id: user.id)
  end
end
