require_relative 'tickets'    # You need to create this file!
require_relative 'tickets_controller'  # You need to create this file!
require_relative 'router'

controller = Controller.new(cookbook)
router = Router.new(controller)

# Start the app
router.run
