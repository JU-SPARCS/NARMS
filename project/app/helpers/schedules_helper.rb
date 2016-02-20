# Helper methods defined here can be accessed in any controller or view in the application

module Narms
  class App
    module SchedulesHelper
      def get_schedules_from_worker_profile(worker_profile, start_at, end_at)

        schedules = Schedules::Worker
          .where(:worker_profile_id => worker_profile.id)
          .where("end > ?", start_at)
          .where("begin < ?", end_at)
          .order(:begin)

        return schedules
      end
    end
    helpers SchedulesHelper
  end
end
