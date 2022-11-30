# frozen_string_literal: true

require 'csv'

def organize_mp3(csv_data)
  sizes = {} # stores the sizes of the last album of each blog
  data = {} # final data

  csv_data.each do |row|
    blog_url = row['url']
    current_size = row['size in kilobytes'].to_i
    filename = row['filename']

    unless data[blog_url]
      data[blog_url] = [[]]
      sizes[blog_url] = 0
    end

    if sizes[blog_url] + current_size > 120 * 1024
      data[blog_url] << []
      sizes[blog_url] = 0
    end

    sizes[blog_url] += current_size
    data[blog_url].last << [filename, current_size]
  end

  data
end

def organize_mp3_from_csv_file(path:)
  organize_mp3(CSV.new(File.open(path), headers: true).read)
end
