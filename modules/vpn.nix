{ config, pkgs, ... }:

{

#nixpkgs.config.permittedInsecurePackages = [
              #  "openssl-1.1.1w"
            #  ];
environment.systemPackages = with pkgs; [
    openvpn
 ];
 nixpkgs.overlays = [
    (final: prev: {
      openvpn = prev.openvpn.override {
       # openssl = prev.openssl_1_1;
       openssl = prev.openssl_legacy;
      };
    })
  ];
  
services.openvpn.servers = {
   # officeVPN  = {
    #  config = "config /home/luozenan/vpn/tmp.ovpn"; 
     # authUserPass = {
      #   username = "124";
      #	 password = "124";
     # };
      
   # };
    
  };

networking.extraHosts = ''
10.2.2.6 jenkins.cuees.com
10.2.2.6 dashboard.cuees.com
10.2.2.6 prometheus.cuees.com
10.2.2.6 grafana.cuees.com
10.2.2.6 firstoa-admin-api.cuees.com
10.2.2.6 firstoa-admin.cuees.com
10.2.2.162 harbor.cuees.com
10.2.2.166 rancher.cuees.com
10.2.2.6 prometheus.od.com
10.2.2.6 traefik.od.com
10.2.2.6 config.od.com
10.2.2.162 harbor.od.com
10.2.2.6 firstoa-api.cuees.com
10.2.2.6 bizsys-api-f.cuees.com
10.2.2.6 bizsys-f.cuees.com
10.2.2.6 wusoa-beta.cuees.com
10.2.2.6 wusoa-api-beta.cuees.com
'';
}


