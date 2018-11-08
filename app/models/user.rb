class User < ApplicationRecord
  authenticates_with_sorcery!
  has_one_attached :icon

  has_many :sum_powers

  has_many :power_levels
  has_many :authentications, dependent: :destroy
  has_many :activities, dependent: :destroy

  belongs_to :character

  delegate :name, :introduction, to: :character, prefix: true

  validates :name, presence: true
  validates :twitter_id, presence: true

  # TwitterProfileImageの画質向上
  before_create -> { self.image = self.image.to_s.sub('_normal', '') }

  scope :power_rank, -> do
    joins(:sum_powers)
      .includes(:character, :sum_powers)
      .order('sum_powers.power desc, users.id desc')
  end
  scope :merge_power, ->(period) { merge(SumPower.where_period(period)) }

  def uid(provider: 'twitter')
    authentications.set_uid(provider)
  end

  def daily_power
    power_levels.daily.sum(:power)
  end

  def weekly_power
    power_levels.weekly.sum(:power)
  end

  def total_power
    power_levels.sum(:power)
  end

  def today_increase_power
    power_levels.daily&.first&.power || 0
  end

  def up_to_next_character
    character.maximum + 1 - power_levels.sum(:power)
  end

  def get_activities_for(kind_key)
    activities.find_or_initialize_by(action_id: Action.kinds[kind_key])
  end

  def get_sum_powers(period)
    sum_powers.find_by(period: SumPower.periods[period]).power
  end

  def refresh_by_twitter
    self.name = twitter_api.user_name
    self.twitter_id = twitter_api.twitter_id
    self.image = twitter_api.profile_image
    save if changed?
  end

  def twitter_api
    TwitterAPI.new(self)
  end
end
