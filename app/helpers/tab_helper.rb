module TabHelper
  def displaying?(controller_name: nil, action_name: nil)
    if controller_name
      check_action_name(action_name)
    elsif action_name
      check_controller_name(controller_name)
    else
      check_controller_name(controller_name) && check_action_name(action_name)
    end
  end

  private

    def check_controller_name(controller_name)
      controller.controller_name == controller_name
    end

    def check_action_name(action_name)
      controller.action_name == action_name
    end
end
