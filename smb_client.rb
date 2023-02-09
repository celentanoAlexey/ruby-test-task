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

  def upload_entity(entity)
    # return false if client.exists?(shared_folder)

    # create_folder(shared_folder)
    # navigate_into_folder(shared_folder)


    entries = Dir[entity + '/*']
    entries.each do |entry|
      if File.directory? entry
        # client.put(entry, entry)
        logger.debug("uploading folder: #{entry}")
        upload_entity(entry)
      elsif File.file? entry
        if matches_filter_criteria(entry)
          # client.put(entry, entry)
          logger.debug("uploading file: #{entry}")
        end
      end
    end
    end

    def matches_filter_criteria(filename)
      extension_pattern = '.bat'
      filename_pattern = '1234'

      (File.extname(filename).eql? extension_pattern) && (File.basename(filename).start_with?(filename_pattern))
    end


  def disconnect
    # client.close
    logger.debug("connection to smb closed")
  end
end

