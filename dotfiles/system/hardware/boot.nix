{ config, lib, ... }:
{
  boot.loader = lib.mkForce {
    	timeout = 7;
    	grub = {
    		enable = true;
    		devices = ["nodev"];
    		efiSupport = true;
    		useOSProber = true;
    		configurationLimit = 5;
    		default = "0";
    		extraEntries = ''
    			menuentry "Reboot" {
    				reboot
    			}
    			menuentry "Poweroff" {
    				halt
    			};
    		'';
    	};
    	efi = {
    		canTouchEfiVariables = true;
    		efiSysMountPoint = "/boot/efi";
    	};
      systemd-boot.enable = false;
    };
}