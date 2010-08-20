module Encosion
  
  class Playlist < Base
    
    attr_reader :id, :name, :short_description, :reference_id, :videos
        
    def initialize(obj)
      @id = obj[:id]
      @name = obj[:name]
      @short_description = obj[:shortDescription]
      @videos = obj[:videos] && obj[:videos].length > 0 ? Encosion::Video.from_array(obj[:videos]) : []
    end
    
    def to_json
      { :id => @id,
        :name => @name,
        :short_description => @short_description,
        :reference_id => @reference_id,
        :videos => @videos }.to_json
    end
    class << self
      
      def find_one(id, options)
        options.merge!({:playlist_id => id})
        response = read('find_playlist_by_id',options)
        return self.parse(response)
      end

      def find_some(ids, options)
        options.merge!({:playlist_ids => ids.join(',')})
        response = read('find_playlists_by_ids',options)
        return response['items'].collect { |item| self.parse(item) }
      end
    
      def find_all(options)
        response = read('find_all_playlists', options)
#        puts response['items'].to_yaml
        puts response['items'].length
        return response['items'].collect { |item| self.parse(item) }
      end
    
      # the actual method that calls a get (user can use this directly if they want to call a method that's not included here)
      def read(method,options)
        # options.merge!(Encosion.options)
        options.merge!({:token => Encosion.options[:read_token]}) unless options[:token]
        get(  Encosion.options[:server],
              Encosion.options[:port],
              Encosion.options[:secure],
              Encosion.options[:read_path],
              Encosion.options[:read_timeout],
              Encosion.options[:retries],
              method,
              options)
      end
    
      # Creates a new Playlist object from a Ruby hash (used to create a video from a parsed API call)
      def parse(obj)
        if obj          
          args = {:id => obj['id'].to_i,
                  :name => obj['name'],
                  :short_description => obj['shortDescription'],
                  :reference_id => obj['referenceID'],
                  :videos => obj['videos']
                  }
          return self.new(args)
        else
          return nil
        end
      end
    
    end
    
  end
  
end