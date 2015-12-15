module NavBarHelper
  def active_for_page(active_page)
    actual_page = "#{controller.controller_name}##{controller.action_name}"
    'active' if actual_page.start_with? active_page
  end
end
