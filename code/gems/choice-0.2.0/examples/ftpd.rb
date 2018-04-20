$:.unshift "../lib"
$:.unshift "lib"
require 'choice'

port = 21
PROGRAM_VERSION = 4

Choice.options do
  #banner "Usage: ftpd.rb [options]"
  
  header ""
  header "Specific options:" 
  
  option :host do
    short '-h'
    long '--host=HOST'
    desc "The hostname or ip of the host to bind to"
    desc "(default 127.0.0.1)"
    default '127.0.0.1'
  end

  option :port do
    short '-p'
    long '--port=PORT'
    desc "The port to listen on (default 21)"
    cast Integer
    default port
  end

  option :clients do
    short '-c'
    long '--clients=NUM'
    cast Integer
    desc "The number of connections to allow at once (default 5)"
    default 5
  end

  option :protocol do
    short '-l'
    long '--protocol=PROTOCOL'
    desc "The protocol to use (default ftp)"
    valid %w[ftp sftp]
    default 'ftp'
  end
      
  option :yaml_cfg do
    long '--config=FILE'
    desc 'Load configuration from YAML file'
  end
  
  option :sample do
    long '--sample'
    desc "See a sample YAML config file"
    action do
      puts "See!"
      exit
    end
  end
  
  option :debug do
    short '-d'
    long '--debug[=LEVEL]'
    desc 'Turn on debugging mode'
  end  
  
   separator ''
   separator 'Common options: '

  option :help do
    long '--help'
    desc 'Show this message'
  end

  option :version do
    short '-v'
    long '--version'
    desc 'Show version'
    action do
      puts "ftpd.rb FTP server v#{PROGRAM_VERSION}"
      exit      
    end
  end
  
end

print "Choices: "
puts Choice.choices.inspect
