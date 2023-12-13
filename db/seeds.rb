# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

FarmingMethod.create([
    {
        title: 'Free-Range System',
        description: 'Chickens roam freely on the farm, obtaining food and water as they please.'
    },
    {
        title: 'Deep Litter System',
        description: 'Chickens are kept indoors in spacious structures. It allows birds to move freely while providing food and water.'
    },
    {
        title: 'Battery System',
        description: 'Each chicken is kept in a cage with readily available food and water.'
    },
    {
        title: 'Fold System',
        description: 'It involves keeping chickens in structures known as "Folds". Feeding and water troughs are placed outside, and birds feed on wire mesh.'
    }
])

ChickenType.create([
    {
        title: 'Layers',
        description: ''
    },
    {
        title: 'Broilers',
        description: ''
    },
    {
        title: 'Indigenous',
        description: ''
    }
])