namespace :data do
  desc "Setup all data"

  task setup: :environment do
    # Fetch lyrics
    Song.fetch_all

    # Create ElasticSearch indices
    Song.create_index

    # Index songs in ElasticSearch
    Song.import

    # Import Vocabs
    Vocabulary.import

    # Build vocab/songs indices
    Vocabulary.build_occurrences
  end

end
