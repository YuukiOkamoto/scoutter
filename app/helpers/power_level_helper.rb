module PowerLevelHelper
  def get_sum_power(user, period)
    case period
    when 'total'
      user.sum_power.total.pluck(:power).first
    when 'week'
      user.sum_power.week.pluck(:power).first
    when 'day'
      user.sum_power.day.pluck(:power).first
    end
  end
end
