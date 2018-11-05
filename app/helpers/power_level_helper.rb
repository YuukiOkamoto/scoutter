module PowerLevelHelper
  def get_sum_power(user, period)
    user.sum_powers.find_by(period: period).power
  end

  def rank_count(ranks, rank_counter)
    rank_counter + ranks.current_per_page * (ranks.prev_page || 0) + 1
  end
end
