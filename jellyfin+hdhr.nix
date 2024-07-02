{
  networking.firewall.extraCommands = "iptables -I nixos-fw -s 10.0.0.148 -p udp -j nixos-fw-accept"; 
  services = {
    jellyfin = {
      enable = true;
    };
  };
}
