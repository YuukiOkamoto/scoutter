module PowerLevelHelper
  def get_sum_power(user, period)
    user.sum_power.find_by(period: period).power
  end

  def prev_page_last_rank(ranks)
    (ranks.current_page - 1) * 25 + 1
  end
end
