require('pg')
require_relative('../db/sql_runner.rb')

class Artist

attr_accessor :first_name, :last_name
attr_reader :id

def initialize(options)
  @id = options['id'].to_i if options['id']
  @first_name = options['first_name']
  @last_name = options['last_name']
  @age = options['age'].to_i
end

def save()
  sql = "INSERT INTO artists
        (first_name, last_name, age)
        VALUES
        ($1, $2, $3)
        RETURNING *"
  values = [@first_name, @last_name, @age]
  result = SqlRunner.run(sql, values)
  @id = result[0]["id"].to_i
end

def self.all
sql = "SELECT * FROM artists;"
artists = SqlRunner.run(sql)
return artists.map{|artist| Artist.new(artist)}

end

def update()
  sql = " UPDATE artists SET (
      first_name,
      last_name,
      age)
      =
      ($1,$2,$3)
      WHERE id = $4"
      values = [@first_name, @last_name, @age, @id]
      result = SqlRunner.run(sql, values)
      return result.map{|artist| Artist.new(artist)}
end

def self.delete()
  sql = "DELETE FROM artists;"
  values = [@id]
  result = SqlRunner.run(sql)
end

def album()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    album_data = results.first
    album = Album.new(album_data)
    return album
  end

end
