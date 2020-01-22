require('pry')
require_relative('../models/albums.rb')
require_relative('../models/artists.rb')


artist1 = Artist.new({ 'first_name' => 'Frank', 'last_name' => 'Turner', 'age' => '39'})
artist1.save

album1 = Album.new({'title' => 'Poetry of the deed', 'release_year' => '2009', 'artist_id' => artist1.id})
album2 = Album.new({'title' => 'Punkrock', 'release_year' => '2005', 'artist_id' => artist1.id})
album1.save
album2.save


artist1.first_name = "Bruno"
# artist1.age = 44
artist1.update()
#
album1.title = "Punkrock campfire"
album1.update
#
# Album.delete

binding.pry
nil
