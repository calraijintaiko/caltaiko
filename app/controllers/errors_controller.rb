# Handles errors, such as 404 (File Not Found) and 500 (Internal Server Error)
class ErrorsController < ApplicationController
  def file_not_found
  end

  def unprocessable
  end

  def internal_server_error
  end
end
