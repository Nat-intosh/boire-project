class CsvImportService
    require 'csv'
  
    def call(file)
      opened_file = File.open(file)
      options = { headers: true, col_sep: ',' }
      CSV.foreach(opened_file, **options) do |row|
  
        # map the CSV columns to your database columns
        card_hash = {}
        card_hash[:title] = row['Title']
        card_hash[:desc] = row['Explanation']
        card_hash[:card_type] = row['type']
        Card.create(card_hash)
        
      end
    end
  end