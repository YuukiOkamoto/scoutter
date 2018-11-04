class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :action

  def create_or_update_for_twitter
    total_count = TwitterAPI.get_count(user, action.kind.to_sym)
    # 初回ログイン時は昨日の総数が不明のため、現時点の総数をいれる
    yesterday_value = total_count if new_record?
    latest_value = total_count
    save
  end
end
