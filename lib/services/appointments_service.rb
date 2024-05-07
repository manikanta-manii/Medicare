module Services
    class AppointmentsService
        def initialize(appointment=nil)
             @appointment=appointment
        end
        
        def download
            Services::Appointments::Downloader.new(@appointment).call
        end
    end
end