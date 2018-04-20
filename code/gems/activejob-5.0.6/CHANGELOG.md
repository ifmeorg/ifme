## Rails 5.0.6 (September 07, 2017) ##

*   No changes.


## Rails 5.0.6.rc1 (August 24, 2017) ##

*   No changes.


## Rails 5.0.5 (July 31, 2017) ##

*   No changes.


## Rails 5.0.5.rc2 (July 25, 2017) ##

*   No changes.


## Rails 5.0.5.rc1 (July 19, 2017) ##

*   No changes.


## Rails 5.0.4 (June 19, 2017) ##

*   No changes.


## Rails 5.0.3 (May 12, 2017) ##

*   No changes.


## Rails 5.0.2 (March 01, 2017) ##

*   No changes.


## Rails 5.0.1 (December 21, 2016) ##

*   No changes.


## Rails 5.0.1.rc2 (December 10, 2016) ##

*   No changes.


## Rails 5.0.1.rc1 (December 01, 2016) ##

*   Added instance variable `@queue` to JobWrapper.

    This will fix issues in [resque-scheduler](https://github.com/resque/resque-scheduler) `#job_to_hash` method,
    so we can use `#enqueue_delayed_selection`, `#remove_delayed` method in resque-scheduler smoothly.

    *mu29*


## Rails 5.0.0 (June 30, 2016) ##

*   Enable class reloading prior to job dispatch, and ensure Active Record
    connections are returned to the pool when jobs are run in separate threads.

    *Matthew Draper*

*   Tune the async adapter for low-footprint dev/test usage. Use a single
    thread pool for all queues and limit to 0 to #CPU total threads, down from
    2 to 10*#CPU per queue.

    *Jeremy Daer*

*   Change the default adapter from inline to async. It's a better default as tests will then not mistakenly
    come to rely on behavior happening synchronously. This is especially important with things like jobs kicked off
    in Active Record lifecycle callbacks.

    *DHH*

*   Fixed serializing `:at` option for `assert_enqueued_with`
    and `assert_performed_with`.

    *Wojciech Wnętrzak*

*   Support passing array to `assert_enqueued_jobs` in `:only` option.

    *Wojciech Wnętrzak*

*   Add job priorities to Active Job.

    *wvengen*

*   Implement a simple `AsyncJob` processor and associated `AsyncAdapter` that
    queue jobs to a `concurrent-ruby` thread pool.

    *Jerry D'Antonio*

*   Implement `provider_job_id` for `queue_classic` adapter. This requires the
    latest, currently unreleased, version of queue_classic.

    *Yves Senn*

*   `assert_enqueued_with` and `assert_performed_with` now returns the matched
    job instance for further assertions.

    *Jean Boussier*

*   Include `I18n.locale` into job serialization/deserialization and use it around
    `perform`.

    Fixes #20799.

    *Johannes Opper*

*   Allow `DelayedJob`, `Sidekiq`, `qu`, and `que` to report the job id back to
    `ActiveJob::Base` as `provider_job_id`.

    Fixes #18821.

    *Kevin Deisz*, *Jeroen van Baarsen*

*   `assert_enqueued_jobs` and `assert_performed_jobs` in block form use the
    given number as expected value. This makes the error message much easier to
    understand.

    *y-yagi*

*   A generated job now inherits from `app/jobs/application_job.rb` by default.

    *Jeroen van Baarsen*

*   Add ability to configure the queue adapter on a per job basis.

    Now different jobs can have different queue adapters without conflicting with
    each other.

    Example:

        class EmailJob < ActiveJob::Base
          self.queue_adapter = :sidekiq
        end

        class ImageProcessingJob < ActiveJob::Base
          self.queue_adapter = :delayed_job
        end

    *tamird*

*   Add an `:only` option to `perform_enqueued_jobs` to filter jobs based on
    type.

    This allows specific jobs to be tested, while preventing others from
    being performed unnecessarily.

    Example:

        def test_hello_job
          assert_performed_jobs 1, only: HelloJob do
            HelloJob.perform_later('jeremy')
            LoggingJob.perform_later
          end
        end

    An array may also be specified, to support testing multiple jobs.

    Example:

        def test_hello_and_logging_jobs
          assert_nothing_raised do
            assert_performed_jobs 2, only: [HelloJob, LoggingJob] do
              HelloJob.perform_later('jeremy')
              LoggingJob.perform_later('stewie')
              RescueJob.perform_later('david')
            end
          end
        end

    Fixes #18802.

    *Michael Ryan*

*   Allow keyword arguments to be used with Active Job.

    Fixes #18741.

    *Sean Griffin*

*   Add `:only` option to `assert_enqueued_jobs`, to check the number of times
    a specific kind of job is enqueued.

    Example:

        def test_logging_job
          assert_enqueued_jobs 1, only: LoggingJob do
            LoggingJob.perform_later
            HelloJob.perform_later('jeremy')
          end
        end

    *George Claghorn*

*   `ActiveJob::Base.deserialize` delegates to the job class.

    Since `ActiveJob::Base#deserialize` can be overridden by subclasses (like
    `ActiveJob::Base#serialize`) this allows jobs to attach arbitrary metadata
    when they get serialized and read it back when they get performed.

    Example:

        class DeliverWebhookJob < ActiveJob::Base
          def serialize
            super.merge('attempt_number' => (@attempt_number || 0) + 1)
          end

          def deserialize(job_data)
            super
            @attempt_number = job_data['attempt_number']
          end

          rescue_from(TimeoutError) do |exception|
            raise exception if @attempt_number > 5
            retry_job(wait: 10)
          end
        end

    *Isaac Seymour*

Please check [4-2-stable](https://github.com/rails/rails/blob/4-2-stable/activejob/CHANGELOG.md) for previous changes.
