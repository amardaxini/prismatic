require 'sneakers'
require 'sneakers/runner'

#override the work method to checkout a new database connection
class ActiveJob::QueueAdapters::SneakersAdapter::JobWrapper


  def work_with_checkout_new_database_connection(*args)
    ActiveRecord::Base.connection_pool.with_connection do
      work_without_checkout_new_database_connection(*args)
    end
  end

  alias_method_chain :work, :checkout_new_database_connection

end

task :environment
 
namespace :sneakers do
  desc 'Start work (set JOB_QUEUES=default,image_upload)'
  task :run_worker  => :environment do

    ActiveRecord::Base.connection_pool.disconnect! #disconnect from the database. The child worker will reconnect

    workers = ENV['JOB_QUEUES'].split(',').map do |q|
      queue_name = q.strip
      worker_klass = "ActiveJobQueue_#{queue_name}"
      Sneakers.const_set(worker_klass, Class.new(ActiveJob::QueueAdapters::SneakersAdapter::JobWrapper) do
        from_queue queue_name
      end)
    end
    r = Sneakers::Runner.new(workers)
    r.run
  end
end