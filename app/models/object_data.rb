class ObjectData

  attr_accessor :data

  def initialize( h={})
    @data = {}
    h.each do |k,v|
      @data[k] = v #ObjectData.new(v)
    end
  end

  def [](key)
    if ! @data.has_key?(key)
      puts "************************************  Define [#{key}]"
    end
    @data[key]
  end

  def method_missing( m, *args, &block)
    if ! @data.has_key?(m)
      puts "************************************  Define .#{m}"
    end
    @data[m]
  end

  def respond_to? name
    @data.has_key?(m)
  end
end
