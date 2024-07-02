{
  # Configuration for the firewall to allow all UDP ports from the HDHomeRun device for streaming. (Replace XXX.XXX.XXX.XXX with your HDHomeRun IP)
  networking.firewall.extraCommands = "iptables -I nixos-fw -s XXX.XXX.XXX.XXX -p udp -j nixos-fw-accept"; 
  # Simple config for Jellyfin itself, no really complex config needed.
  services = {
    jellyfin = {
      enable = true;
    };
  };
}
