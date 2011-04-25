require 'juicer'

namespace :juicer do
  desc 'Merges stylesheets'
  task :css do
    sh 'juicer merge --force _site/css/master.css'
  end
end

desc "Upload zu DH"
task :deploy do
  sh "rsync -aHvP --exclude .git/ _site/ dreamhost:mein-ddr-leben.de/"
end