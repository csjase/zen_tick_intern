class Ticket
  attr_reader :id, :status, :subject, :updated_at
  def initialize(id, status, subject, updated_at)
    @id = id
    @status = status
    @subject = subject
    @updated_at = updated_at
  end
end