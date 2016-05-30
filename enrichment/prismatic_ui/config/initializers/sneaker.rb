Sneakers.configure amqp: (ENV['RABBITMQ_URL'] || 'amqp://guest:guest@localhost:5672'),
                   vhost: (ENV['RABBITMQ_VHOST'] || '/'),
                   workers: (ENV['JOB_QUEUE_WORKERS'] ? ENV['JOB_QUEUE_WORKERS'].to_i : 1),
                   threads: (ENV['JOB_QUEUE_THREADS'] ? ENV['JOB_QUEUE_THREADS'].to_i : 1),
                   #log: log, #not usable yet until we implement respond_to?(:info, :error, etc)
                   # handler: Sneakers::Handlers::OneshotBugsnag,
                   hooks: {
                       before_fork: -> {
                          log.info('Worker: Disconnect from the database')
                          ActiveRecord::Base.connection_pool.disconnect!
                       },
                       after_fork: -> {
                         config = Rails.application.config.database_configuration[Rails.env]
                         config['reaping_frequency'] = ENV['DB_REAP_FREQ'] || 10 # seconds
                         config['pool'] = ENV['DB_POOL'] || 5
                         ActiveRecord::Base.establish_connection(config)
                         log.info('Worker: Reconnect to the database')
                       }
                   },
                   timeout_job_after: 86400
ActiveJob::Base.logger = log
