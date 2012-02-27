module EventsHelper
  
  def status_options
     statuses = [
       ["up", 1],
       ["warning", 2],
       ["mainenance", 3],
       ["down", 4],
     ]
   end
  
end
