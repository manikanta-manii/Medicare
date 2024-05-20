module Services
  module Slots
    class DatesFormater
      def initialize
      end

      def call
        formatted_dates = []
        3.times do |i|
          date = Date.today + i
          formatted_dates << format_date(date)
        end
        formatted_dates
      end

      private

      def format_date(date)
        "#{date.strftime("%A")} #{date.strftime("%b")} #{date.day}, #{date.year}"
      end
    end
  end
end
