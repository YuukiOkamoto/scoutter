module RankHelper
  def my_rank_query
    count =
      @users.each_with_index do |user, i|
        break i if user.id == current_user.id
      end
    page_number = (count - 1) / @ranks.current_per_page + 1
    order = (count - 1) % @ranks.current_per_page + 1
    if order == @ranks.current_per_page
      page_number += 1
      order = nil
    end
    { page: page_number, anchor: order }
  end
end
