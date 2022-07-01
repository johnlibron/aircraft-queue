class Aircraft
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  TYPE_OPTIONS = %w(Passenger Cargo)
  SIZE_OPTIONS = %w(Small Large)

  attr_accessor :name, :type, :size

  validates :name, presence: true
  validates :type, :inclusion => {:in => TYPE_OPTIONS}
  validates :size, :inclusion => {:in => SIZE_OPTIONS}

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end
