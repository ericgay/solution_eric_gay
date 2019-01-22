class ShaManager
  def self.connection=(value)
    @@connection = value
  end

  def to_hash(text)
    Digest::SHA2.new(256).hexdigest(text).tap do |hash|
      save(hash, text)
    end
  end

  def to_text(hash)
    get(hash)
  end

  private

  def save(key, value)
    redis.set(key, value)
  end

  def get(key)
    redis.get(key)
  end
  
  def redis
    @redis ||= Redis.new(@@connection)
  end
end
