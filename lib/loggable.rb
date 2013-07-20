module Loggable
  require 'logger'

  def logger
    @logger ||= setup_logger
  end

  def setup_logger
    filename = 'log/libstatus.log'
    old_files_max = 1
    max_file_size = 1024000

    Logger.new filename, old_files_max, max_file_size
  end

  def log_info args
    logger.info args
  end

  def log_error args
    logger.error args
  end

  def log_fatal args
    logger.fatal args
  end
end
