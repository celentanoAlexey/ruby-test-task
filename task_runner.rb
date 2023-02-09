# frozen_string_literal: true
require_relative 'smb_client'

smb_client  = SMBClient.new('smb://192.***.**.*', 'Oleksii', '512312')


upload_entry_name = "1_level_folder"

if smb_client.upload_entity(upload_entry_name)
  smb_client.logger.debug("'#{upload_entry_name}' folder has been uploaded")
else
  smb_client.logger.debug("#{upload_entry_name} can't be uploaded")
end



# smb_client.disconnect
