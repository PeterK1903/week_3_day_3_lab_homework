require('pg')
require('pry')
require_relative('../db/sql_runner.rb')

class Album

attr_accessor :title, :release_year
attr_reader :id, :artist_id

def initialize(options)
  @id = options['id'].to_i if options['id']
  @title = options['title']
  @release_year = options['release_year'].to_i
  @artist_id = options['artist_id'].to_i
end

def save()
  sql = "INSERT INTO albums
      (title, release_year, artist_id)
      VALUES
      ($1,$2,$3)
      RETURNING *"
  values = [@title, @release_year, @artist_id]
  result = SqlRunner.run(sql, values)
  @id = result[0]["id"].to_i
end

def self.all
sql = "SELECT * FROM albums;"
album = SqlRunner.run(sql)
return album.map{|album| Album.new(album)}
end

def update()
  sql = "UPDATE albums SET
      (title, release_year, artist_id)
      =
      ($1,$2,$3)
      WHERE id = $4"
  values = [@title, @release_year, @artist_id, @id]
  result = SqlRunner.run(sql, values)
  return result.map{|album| Album.new(album)}
end

def self.delete()
  sql = "DELETE FROM albums;"
  values = [@id]
  result = SqlRunner.run(sql)
end

def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    results = SqlRunner.run(sql, values)
    artist_data = results.first
    artist = Artist.new(artist_data)
    return artist
  end



end
