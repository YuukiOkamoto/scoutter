module ChartHelper
  def get_days(count)
    count.step(1, -1).map { |d| Date.today.ago((d - 1).days).strftime('%m/%d') }.to_json.html_safe
  end
end
