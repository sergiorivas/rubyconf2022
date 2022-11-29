# frozen_string_literal: true

require_relative '../organize_mp3'

RSpec.describe 'organize_mp3' do
  context 'when comes from a file' do
    it 'can read the file' do
      # File content:
      # url,email,filename,size in kilobytes
      # http://murazik.io/mandi.konopelski,ray@nikolaus-pagac.net,twilight_laser/laborum.mp3,8107
      # http://murazik.io/mandi.konopelski,laurinda.hilll@rice.io,glow_inspiration/distinctio.mp3,6121

      current_folder = File.dirname(__FILE__)
      path = File.join(current_folder, 'file.csv')
      result = organize_mp3_from_csv_file(path: path)
      expect(result).is_a? Hash
      expect(result['http://murazik.io/mandi.konopelski'][0].size).to eq(2)
    end
  end

  context 'it handles csv data' do
    it 'manages different urls and creates the result' do
      csv_data = [
        { 'url' => 'blog1.com', 'email' => 'email1@gmail.com', 'filename' => '1.mp3', 'size in kilobytes' => 100 },
        { 'url' => 'blog2.com', 'email' => 'email2@gmail.com', 'filename' => '2.mp3', 'size in kilobytes' => 200 }
      ]

      expected = {
        'blog1.com' => [
          [
            ['1.mp3', 100]
          ]
        ],
        'blog2.com' => [
          [
            ['2.mp3', 200]
          ]
        ]
      }

      expect(organize_mp3(csv_data)).to eq(expected)
    end

    it 'creates two albums when reach the limit' do
      csv_data = [
        { 'url' => 'blog1.com', 'email' => 'email1@gmail.com', 'filename' => '1.mp3', 'size in kilobytes' => 122_000 },
        { 'url' => 'blog1.com', 'email' => 'email1@gmail.com', 'filename' => '2.mp3', 'size in kilobytes' => 800 },
        { 'url' => 'blog1.com', 'email' => 'email1@gmail.com', 'filename' => '3.mp3', 'size in kilobytes' => 300 }
      ]

      expected = {
        'blog1.com' => [
          [
            ['1.mp3', 122_000],
            ['2.mp3', 800]
          ],
          [
            ['3.mp3', 300]
          ]
        ]
      }

      expect(organize_mp3(csv_data)).to eq(expected)
    end
  end
end
