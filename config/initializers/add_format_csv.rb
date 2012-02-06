ActionController::Renderers.add :csv do |rows, options|
  csv_string = CSV.generate do |csv|
    rows.each do |row|
      csv << row
    end
  end
  filename = options[:filename] || "data-#{Time.now.strftime('%Y%m%d-%H%M%S')}"
  send_data csv_string, :type => Mime::CSV, :disposition => "attachment; filename=#{filename}.csv"
end

