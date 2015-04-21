Given /^the date is(?:|currently) (.+)$/ do |time|
  new_time = Time.zone.parse(time)
  Timecop.freeze(new_time)
end
