ActionController::Renderers.add :csv do |collection, options|
  csv_string = CSV.generate do |csv|
    csv << collection.export_headings
    collection.all.each do |obj|
      csv << obj.export_fields
    end
  end

  filename = options[:filename] || "data-#{Time.now.strftime('%Y%m%d-%H%M%S')}"

  send_data csv_string, :type => Mime::CSV, :disposition => "attachment; filename=#{filename}.csv"
end

