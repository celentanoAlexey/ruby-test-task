# frozen_string_literal: true
require 'sambal'
require 'logger'

class SMBClient
  attr_reader :logger
  attr_accessor :client

  def initialize(host, user, password)
    # options = {
    #   host: host,
    #   user: user,
    #   share: 'Public/Documents',
    #   password: password
    # }

    @logger = Logger.new(STDOUT)

    # @client = Sambal::Client.new options

    logger.debug("connection to smb has been established")
  end

  def create_folder(shared_folder)
    client.mkdir(shared_folder)

    logger.debug("folder #{shared_folder} has been created")
  end

  def navigate_into_folder(shared_folder)
    client.cd(shared_folder)

    logger.debug("Navigated into folder: #{shared_folder}")
  end

  def upload_entity(shared_folder)
    # return false if client.exists?(shared_folder)

    # create_folder(shared_folder)
    # navigate_into_folder(shared_folder)

    # here 'Dir[shared_folder + "/**/*"]' (same as Dir.glob is used to recursively grab all entries in the folder)
    entries = Dir[shared_folder + "/**/*"]

    entries.each do |entity|
      # client.put(entity, entity)

      if File.file?(entity)
        logger.debug("file '#{entity}' has been uploaded")
      elsif File.directory? entity
        logger.debug("folder '#{entity}' has been uploaded")
      end
    end

    def disconnect
      # client.close
      logger.debug("connection to smb closed")
    end
  end
end