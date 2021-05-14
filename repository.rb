class Repository
  attr_reader :tickets

  def initialize
    @tickets = []
  end

  def add(ticket)
    @tickets << ticket
  end
end
