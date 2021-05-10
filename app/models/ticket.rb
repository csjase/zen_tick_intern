class Ticket
  attr_reader :id, :status, :subject 
  def initialize(id, status, subject)
    @id = id
    @status = status
    @subject = subject
  end
end
