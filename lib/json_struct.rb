class JSONStruct < Struct
  def self.from_hash hsh
    self.new.tap do |obj|
      obj.members.each{|m| obj[m] = hsh[m.to_s]}
    end
  end

  def self.from_json json
    data = JSON.load(json)
    if data.is_a? Array
      data.map{ |d| from_hash(d) }
    else
      from_hash(data)
    end
  end
end
