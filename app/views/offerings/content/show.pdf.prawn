# array of Outcome Key
arrKey = []
@offering.outcomes.each do |outcome|
  arrKey.push(outcome.key)
end

content_groups = @offering.content_groups.each do |group|

  allRows = []  # 2D array of all Rows

  titleRow = [group.name] # title row include name and Outcome keys
  titleRow.concat(arrKey)

  allRows.push(titleRow)

  #  add rows, each row is a content and mapping value
  group.content.each do |content|
    aRow = []
    aRow.push(content.title)
    content.mappings.each do |mapping|
      aRow.push(mapping.value)
    end
    allRows.push(aRow)
  end

  pdf.table(allRows, :row_colors => ["FFFFFF","DDDDDD"])
end

