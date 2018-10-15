module ChartHelper
  def get_days(count)
    raw 30.step(1, -1).map { |d| Date.today.ago((d - 1).days).strftime('%m/%d') }
  end
end
