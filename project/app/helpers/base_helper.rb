# Helper methods defined here can be accessed in any controller or view in the application

module Narms
  class App
    module BaseHelper

      # Return double dimensional array
      #  1 dimension => slots for a specific time (nil if no slot for this time over the week)
      #  2 dimension => slots for a specific date (nil if no slot for this date at that time)
      def slots_over_week(schedules, start_at)
       	time = Time.new(start_at.year, start_at.month, start_at.day, 00, 00)
 
        slots_to_display = Array.new

      	# Loop over every bracket of 30 min
      	while time.day == start_at.day do
      		display_row = false

          # For a given hour, look for any fitting slot over the week
          slots_to_display_for_a_time = Array.new
          (0..6).each do |i|
            display_row_for_a_time = false
            schedules.each do |schedule|
              schedule.slots.each do |slot|
                if slot.begin_at == (time + (i * 60*60*24))
                  slots_to_display_for_a_time.push(slot)
                  display_row_for_a_time = true
                  display_row = true
                  break 2
                end
              end
            end
            if display_row_for_a_time == false
              slots_to_display_for_a_time.push(nil)
            end
          end

          # Add the slots to be displayed if some has been found for this time
          if display_row
         	  slots_to_display.push(slots_to_display_for_a_time)
          else
            slots_to_display.push(nil)
          end
          time += 60*30 # Add 30 minutes
        end
        return slots_to_display
      end

      def slots_over_week2(schedules, start_at)
        time = Time.new(start_at.year, start_at.month, start_at.day, 00, 00)
 
        slots_to_display = Array.new

        # Loop over every bracket of 30 min
        while time.day == start_at.day do
          display_row = false

          # For a given hour, look for any fitting slot over the week
          slots_to_display_for_a_time = Array.new
          (0..3).each do |i|
            display_row_for_a_time = false
            schedules.each do |schedule|
              schedule.slots.each do |slot|
                if slot.begin_at == (time + (i * 60*60*24))
                  slots_to_display_for_a_time.push(slot)
                  display_row_for_a_time = true
                  display_row = true
                  break 2
                end
              end
            end
            if display_row_for_a_time == false
              slots_to_display_for_a_time.push(nil)
            end
          end

          # Add the slots to be displayed if some has been found for this time
          if display_row
            slots_to_display.push(slots_to_display_for_a_time)
          else
            slots_to_display.push(nil)
          end
          time += 60*30 # Add 30 minutes
        end
        return slots_to_display
      end
    end

    helpers BaseHelper
  end
end
