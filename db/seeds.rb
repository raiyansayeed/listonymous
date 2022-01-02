# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

15.times do 
    Category.create(
        title: Faker::Educator.unique.course_name
    )
end

c_count = Category.count
c_all = Category.all

50.times do 
    sl = List.new(
        title: Faker::ChuckNorris.fact
    )

    Random.rand(1..4).times do 
        num_categories = Random.rand(c_count)

        sl.categories << c_all[num_categories]
    end

    Random.rand(3..30).times do 
        sl.text_messages.build(
            content: Faker::TvShows::TheFreshPrinceOfBelAir.quote
        )
    end
    sl.save
end
