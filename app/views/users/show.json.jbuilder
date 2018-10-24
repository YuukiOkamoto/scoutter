json.data do
  json.array! @data_xxx_days
end
json.labels do
  json.array! get_days_from_today(@period)
end
