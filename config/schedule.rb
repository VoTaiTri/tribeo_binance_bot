set :environment, ENV['RAILS_ENV']

every 3.minutes do
  runner 'Form::HuobiPro.new.tribeo'
end
