namespace :parser do
  desc "TODO"

  task :wer, [:delay] => :environment do |t, args|
    request_delay = args[:delay] || 0

    puts "parser started with delay #{request_delay}, please wait ..."

    parser = ParseDrugsInfoJob.new
    parser.perform request_delay

    puts "parser done ..."
  end

end
