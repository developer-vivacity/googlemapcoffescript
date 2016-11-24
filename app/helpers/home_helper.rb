module HomeHelper
  def map_locations
    {
      ddjw:  [41.9151097, -87.70237789999],
      hotel: [42.662645, -83.248014000],
      hotel_center: [42.67387866, -83.23805764]
    }
  end

  def google_map_tag(options={})
    options.reverse_merge!(width: 600, height: 300, mark_center: true, zoom: 10)
    static_map_tag = image_tag(static_map_url(options), width: options[:width], height: options[:height], alt: "Map for #{options[:address]}")
    content_tag(:div, static_map_tag, id: options[:id],
      data: {
        googlemap: true,
        size: "#{options[:width]}x#{options[:height]}",
        address: options[:address],
        marker: true,
        zoom:   options[:zoom]
      }
    ).html_safe
  end

  def static_map_url(options)
    map_params = [].tap do |p|
      p << ["size",    "#{options[:width]}x#{options[:height]}"]
      p << ["zoom",    options[:zoom]]
      p << ["center",  options[:address]]
      p << ["markers", options[:address]] if options[:mark_center]
      p << ["maptype", "roadmap"]
      p << ["sensor",  "false"]
    end

    "http://maps.google.com/maps/api/staticmap?" + map_params.map { |p| k,v=*p; "#{k}=#{CGI.escape(v.to_s)}"  }.join("&")
  end
end
