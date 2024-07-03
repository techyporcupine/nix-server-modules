{
  # Configuration for the firewall to allow all UDP ports from the HDHomeRun device for streaming. (Replace XXX.XXX.XXX.XXX with your HDHomeRun IP)
  networking.firewall.extraCommands = "iptables -I nixos-fw -s XXX.XXX.XXX.XXX -p udp -j nixos-fw-accept"; 
  # Simple config for Jellyfin itself, no really complex config needed.
  services = {
    jellyfin = {
      enable = true;
      # We are simply doing this so that Jellyfin has access to all the directories that you normally would. If you already had Jellyfin previously, you may need to change the ownership of `/var/lib/jellyfin` and `/var/cache/jellyfin`
      # TODO: ADD IN YOUR USERNAME
      user = "yourusername";
      group = "users";
    };
  };

  # This section is dedicated to an XMLTV config. This is only needed if you are setting up an HDHomeRun.
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
    oci-containers = {
      backend = "podman";
      containers = {
        zap2xml = {
          image = "shuaiscott/zap2xml";
          # TODO: CHANGE PATH, THEN ADD PATH AS XMLTV FILE IN JELLYFIN
          volumes = [ "/path/to/location/where/you/want/xmltv/file:/data" ];
          autoStart = true;
          environment = {
            XMLTV_FILENAME = "xmltv.xml";
            OPT_ARGS = "-I -D";
          };
          environmentFiles = ["FIXME: PUT IN PATH TO FILE WITH USERNAME AND PASSWORD FOR ZAP2IT"];
          extraOptions = [
            "--pull=newer" # Pull if the image on the registry is newer than the one in the local containers storage
          ];
        };
      };
    };
  };
}
