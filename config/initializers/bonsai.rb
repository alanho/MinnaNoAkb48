ENV['ELASTICSEARCH_URL'] = ENV['BONSAI_URL']

# Connect to specific Elasticsearch cluster
ELASTICSEARCH_URL = ENV['ELASTICSEARCH_URL'] || 'http://localhost:9200'

Elasticsearch::Model.client = Elasticsearch::Client.new url: ELASTICSEARCH_URL