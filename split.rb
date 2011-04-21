#!/usr/bin/env ruby

count = 0
of = nil
filename = nil

File.open( "mein-ddr-leben.html", "r" ).lines.each do |line|
  if /<h3>(.+)<\/h3>/.match(line)
    title = $1

    unless of.nil?
      of.close
      system("~/bin/html2text.py #{filename} > #{ filename.gsub( '.html', '.markdown' ) } && rm -f #{filename}")
    end

    count += 1
    filename = "kapitel/" + count.to_s.rjust( 2, "0" ) + ".html"
    yaml = <<EOT
---<br>
layout: chapter<br>
title: #{title}<br>
chapter: #{count}<br>
---<br>

EOT

    of = File.open( filename, "w" )
    of.puts yaml
  end

  of.puts line unless of.nil?
end

of.close unless of.nil?
