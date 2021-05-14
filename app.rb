require_relative 'ticket'    # You need to create this file!
require_relative 'tickets_controller'  # You need to create this file!
require_relative 'router'
require_relative 'repository'


controller = Controller.new(ticket)
router = Router.new(controller)

# Start the app
router.run
