class Item < DSpace::Rest::Item

end

module DSpace
  module Rest
    class Item
      # TODO trigger evaluation upon reload
      def metadata(keys = [])
        all_metadata
        return @metadata if keys.empty?
        md = {}
        keys.each { |k| md[k] = @metadata[k] }
        return md
      end

      def all_metadata()
        return @metadata if @metadata
        @metadata = {}
        getdata = get('metadata')
        # TODO DSpace:Rest:DSpaceObj,get return UNDEFINED object
        # in hind sight weshould change that
        if getdata.respond_to?(:each) then
          getdata.each do |md|
            key, val = md['key'], md['value']
            if (@metadata.has_key?(key)) then
              unless (@metadata[key].is_a? Array)
                @metadata[key] = [@metadata[key]]
              end
              @metadata[key] << val
            else
              @metadata[key] = val
            end
          end
        end
        return @metadata
      end
    end
  end
end
