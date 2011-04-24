#!/usr/bin/env ruby

require "yaml"
require "htmlentities"

coder = HTMLEntities.new
images = YAML.load( File.open("__originale/bildquellen.yaml") )
files = Dir.entries("_posts").select { |fn| fn.match(/markdown$/) }
alignment = "left"

files.each do |fn|
  fn = "_posts/#{fn}"
  
  lines = File.open(fn).readlines
  lines.map! do |line|
    line.gsub( /\(\((\d{3})( \+Link)?\)\)/ ) do |m|
      num = $1.to_i.to_s
      num_s = $1
      image = images[num]
      title = ( image["title"] || "" ).gsub( '"', '\"' )
      title = coder.encode( title, :hexadecimal )
      url = ( image["url"] || "" ).gsub( /&(?!amp;)/, "&amp;" )
      alignment = ( alignment == "left" ) ? "right" : "left"
      
      [
        "<figure class=\"#{alignment}\">",
          "<a href=\"/bilder/#{num_s}.jpg\" title=\"Klicken f&uuml;r Grossansicht\" rel=\"facebox\">",
            "<img title=\"#{title}\" src=\"/bilder/thumb-#{num_s}.png\">",
          "</a>",
          "<figcaption>",
            title,
            url != "" ? " <small><a href=\"#{url}\">(Quelle)</a></small>" : "",
          "</figcaption>",
        "</figure>\n"
      ].join("")
    end
  end

  f = File.open( fn, "w" )
  lines.each { |l| f.puts l }
  f.close
end
