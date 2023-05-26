class SftpCreateController < ApplicationController
    def index    
    end

    def initialize(host, user, password)
        @host = host
        @user = user
        @password = password
      end
    
      def connect
        sftp_client.connect!
      rescue Net::SSH::RuntimeError
        puts "Failed to connect to #{@host}"
      end
    
      def disconnect
        sftp_client.close_channel
        ssh_session.close
      end
    
      def sftp_client
        @sftp_client ||= Net::SFTP::Session.new(ssh_session)
      end
    
      private
    
      def ssh_session
        @ssh_session ||= Net::SSH.start(@host, @user, @password)
      end
    
    
    end

    # sftptogo_url = ENV['SFTPTOGO_URL']
    # begin
    #   uri = URI.parse(sftptogo_url)
    # rescue URI::InvalidURIError
    #   puts 'Bad SFTPTOGO_URL'
    # end

    # puts @host
    # puts @user
    # puts ENV['HOST']
    # puts ENV['SFTPUSER']
    # puts ENV['PASSWORD']
    # sftp = SftpCreateController.new(ENV['HOST'], ENV['SFTPUSER'], ENV['PASSWORD'])
    # sftp.connect
    #     # disconnect
    #     sftp.disconnect

  
    uri = URI.parse(ENV['SFTPTOGO_URL'])
    puts uri 
    
    Net::SFTP.start(uri.host, uri.user, :password => uri.password) do |sftp|
      # download a file or directory from the remote host
      sftp.download!("/path/to/remote", "/path/to/local")
    end