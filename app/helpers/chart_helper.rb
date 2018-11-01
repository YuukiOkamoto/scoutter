module ChartHelper
  def get_days_from_today(count)
    count.step(1, -1).map { |d| Date.today.ago((d - 1).days).strftime('%m/%d') }
  end
end
