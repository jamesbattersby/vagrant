require "tempfile"

require "vagrant/util/subprocess"

module VagrantPlugins
  module HostDarwin
    module Cap
      class RDP
        def self.rdp_client(env, rdp_info)
          config = nil
          opts   = {
            "drivestoredirect:s"       => "*",
            "full address:s"           => "#{rdp_info[:host]}:#{rdp_info[:port]}",
            "prompt for credentials:i" => "1",
            "username:s"               => rdp_info[:username],
          }

          # Create the ".rdp" file
          config = Tempfile.new(["vagrant-rdp", ".rdp"])
          opts.each do |k, v|
            config.puts("#{k}:#{v}")
          end
          config.close

          # Launch it
          Vagrant::Util::Subprocess.execute("open", config.path)
        ensure
          config.close if config
        end
      end
    end
  end
end
