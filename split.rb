#!/usr/bin/env ruby

count = 0
of = nil

File.open( "mein-ddr-leben.html", "r" ).lines.each do |line|
  if /<h3>(.+)<\/h3>/.match(line)
    of.close unless of.nil?

    title = $1
    count += 1
    filename = "chapters/" + count.to_s.rjust( 2, "0" ) + ".html"
    yaml = <<EOT
---
layout: chapter
title: #{title}
chapter: #{count}
---

EOT

    of = File.open( filename, "w" )
    of.puts yaml
  end

  of.puts line unless of.nil?
end

of.close unless of.nil?
