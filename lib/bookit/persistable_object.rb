# super-meta object persistence class to Redis
require 'redis'
require 'active_model'

module Bookit
  class PersistableObject
    include ActiveModel::Serialization

    attr_accessor :attributes, :id
    cattr_writer :namespace

    class << self 
      def namespace
        @namespace || self
      end

      def key(id)
        "#{namespace}:%s" % id
      end

      # specifically use the generic initializer to rebuild object
      def find(id)
        return nil unless redis.exists key(id)

        new redis.hgetall(key(id)).to_options
      end

      def last_id
        redis.get key("LAST_ID")
      end

      def last
        find last_id
      end

      def redis(host="localhost", port=6379)
        @redis ||= Redis.new(host: host, port: port)
      end      
    end

    def initialize(params = {})
      @attributes = params
      @id = params[:id] || nil
    end

    def redis
      self.class.redis
    end

    def read_attribute_for_validation(key)
      @attributes[key]
    end
    alias :[] :read_attribute_for_validation

    def key(id=@id)
      self.class.key(id)
    end

    # store in redis
    def persist
      @attributes[:id] = @id = incr_key

      redis.hmset key, *serializable_hash.flatten
      self
    end

    def clear
      redis.del key
    end

    private
    def incr_key
      redis.incr key("LAST_ID")
    end
  end
end

