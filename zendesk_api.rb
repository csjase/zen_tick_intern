class Zendesk_TicketAPI 
  attr_reader :tickets
  def initialize(base_url, aut_header)
    @base_url =  base_url
    @aut_header = aut_header
    @tickets = {}
  end

  # def get_tickets
  #   current_index = 0
  #   tickets = []
  #   response = HTTParty.get("#{@base_url}/requests.json", headers: {"Authorization" => "#{@aut_header}"})
  #   whole_json = JSON.parse(response.body)
  #   requests_list = whole_json["requests"]
  #   requests_list.each do |request_item|
  #     t = Ticket.new(request_item["id"], 
  #                    request_item["status"], 
  #                    request_item["subject"],
  #                    request_item["updated_at"])
  #     tickets << t
  #     @tickets[request_item["id"]] = current_index #creating a hash map
  #     current_index += 1
  #   end
  # end

  def get_tickets(per_page,page)
    tickets = []
    response = HTTParty.get("#{@base_url}/tickets.json?per_page=#{per_page}&page=#{page}", headers: {"Authorization" => "#{@aut_header}"})
    whole_json = JSON.parse(response.body)
    requests_list = whole_json["tickets"]
    requests_list.each do |request_item|
      t = Ticket.new(request_item["id"], 
                     request_item["status"], 
                     request_item["subject"],
                     request_item["updated_at"])
      tickets << t
    end
    return tickets
  end

  def get_ticket(id)
    response = HTTParty.get("#{@base_url}/tickets/#{id}.json", headers: {"Authorization" => "#{@aut_header}"})
    whole_json = JSON.parse(response.body)
    request_item = whole_json["ticket"]
    t = Ticket.new(request_item["id"], 
                   request_item["status"], 
                   request_item["subject"],
                   request_item["updated_at"])
    return t
  end
end