module PowerLevelHelper
  def rank_count(ranks, rank_counter)
    rank_counter + ranks.current_per_page * (ranks.prev_page || 0) + 1
  end
end
