#########################################################
# Driver orientado a Chilexpress
#########################################################
module Transaction
  module Chilexpress

    #########################################################
    # Description
    # @return: Hash que contiene data (empty array) y success (boolean)
    #########################################################
    def self.process(data)

      begin
        data[:destinationZones].each do |dest_zone|
          shipping = Chilexpress.get_shipping(data[:originZone], dest_zone)
          # return { data: [], success: false } if failed?(file_list, 'MkFile.get')
          p shipping
        end

        # return { data: [], success: true }
      rescue Exception => e
        # catch_exception('Clone::File', {msg: e.message, bkt: e.backtrace}, :rollback)
        # return { data: [], success: false }
      end

    end


    #########################################################
    # Metodo para eliminar todos los archivos y sus content_log
    #########################################################
    def self.rollback()
      # current_files_list = MkFile.get($destination_access_token, $destination_mk_id)
      # current_files_list[:data].each do |current_file|
      #   MkFile.delete($destination_access_token, $destination_mk_id, current_file[:id])
      #   MkContentLog.delete($destination_access_token, current_file[:id], 'file')
      # end
    end

  end
end