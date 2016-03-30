# Handles errors, such as 404 (File Not Found) and 500 (Internal Server Error)
class ErrorsController < ApplicationController
  # Handle 404 - File Not Found Errors
  def file_not_found
  end

  # Handle 422 - Unprocessable Entity Errors
  def unprocessable
  end

  # Handle 500 - Internal Server Errors
  def internal_server_error
  end
end
