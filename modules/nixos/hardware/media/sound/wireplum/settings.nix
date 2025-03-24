{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.lists) singleton;

  inherit (config.my) machine;
in {
  # WirePlumber is a modular session / policy manager for PipeWire
  services.pipewire.wireplumber.extraConfig = mkMerge [
    {
      # Tell wireplumber to be more verbose
      "10-log-level-debug" = {
        "context.properties"."log.level" = "D"; # output debug logs
      };

      # Default volume is by default set to 0.4
      # instead set it to 1.0
      "10-default-volume" = {
        "wireplumber.settings"."device.routes.default-sink-volume" = 1.0;
      };

      "60-hdmi-lowprio" = {
        "monitor.alsa.rules" = singleton {
          matches = singleton {"api.alsa.path" = "hdmi:.*";};

          actions.update-props = {
            "node.name" = "Low Priority HDMI";
            "node.nick" = "Low Priority HDMI";
            "node.description" = "Low Priority HDMI";
            "priority.session" = 100;
            "node.pause-on-idle" = true;
          };
        };
      };

      "60-onboard-card" = {
        "monitor.alsa.rules" = singleton {
          matches = [{"media.class" = "Audio/Device";}];

          actions.update-props = {
            "node.name" = "Onboard Audio";
            "node.description" = "Onboard Audio";
            "node.nick" = "Onboard Audio";
          };
        };
      };
    }

    (mkIf machine.hasBluetooth {
      "10-bluez" = {
        "monitor.bluez.rules" = singleton {
          matches = singleton {"device.name" = "~bluez_card.*";};
          actions = {
            update-props = {
              "bluez5.roles" = [
                "hsp_hs"
                "hsp_ag"
                "hfp_hf"
                "hfp_ag"
              ];
              "bluez5.enable-msbc" = true;
              "bluez5.enable-sbc-xq" = true;
              "bluez5.enable-hw-volume" = true;

              # Set quality to high quality instead of the default of auto
              "bluez5.a2dp.ldac.quality" = "hq";
            };
          };
        };
      };
    })
  ];
}
