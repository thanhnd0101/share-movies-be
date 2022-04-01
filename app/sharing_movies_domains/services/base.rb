class Services::Base

  def initialize(*args, &block)
  end

  def self.call(*args, &block)
    new(*args, &block).call
  end
end
