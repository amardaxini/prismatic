require_relative './settings'
ES_LOGGER = (Settings.elasticsearch.logging ? log : nil)
ES_TRACER = (Settings.elasticsearch.tracing ? log : nil)
ES_SEARCH_CLIENT = Elasticsearch::Client.new host: ENV['ELASTICSEARCH_URL'], logger: ES_LOGGER, tracer: ES_TRACER, adapter: :net_http_persistent
Searchkick.client = ES_SEARCH_CLIENT

