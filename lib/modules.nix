{lib, ...}: rec {
  mkModuleWithOptions = {
    config,
    name,
    moduleConfig,
    default ? false,
    extraOptions ? {},
    extraCondition ? true,
  }: let
    namePathList = lib.splitString "." name;

    modulePath = ["my"] ++ namePathList;
    enableOptionPath = modulePath ++ ["enable"];

    moduleOptions =
      {
        enable = lib.mkOption {
          inherit default;
          type = lib.types.bool;
          description = "Enable [${name}] module";
        };
      }
      // extraOptions;
  in {
    options = lib.setAttrByPath modulePath moduleOptions;

    config =
      lib.mkIf (lib.getAttrFromPath enableOptionPath config && extraCondition)
      moduleConfig;
  };

  mkModule' = config: name: extraOptions: moduleConfig:
    mkModuleWithOptions {inherit config name extraOptions moduleConfig;};

  mkModule = config: name: moduleConfig: mkModule' config name {} moduleConfig;

  mkEnabledModule' = config: name: extraOptions: moduleConfig:
    mkModuleWithOptions {
      inherit config name extraOptions moduleConfig;
      default = true;
    };

  mkEnabledModule = config: name: moduleConfig:
    mkEnabledModule' config name {} moduleConfig;

  mkDesktopModule' = config: name: extraOptions: moduleConfig:
    mkModuleWithOptions {
      inherit config name extraOptions moduleConfig;
      extraCondition = config.isDesktop;
    };

  mkDesktopModule = config: name: moduleConfig:
    mkDesktopModule' config name {} moduleConfig;

  mkServiceModule' = config: name: extraOptions: moduleConfig: let
    serviceName = "services.${name}";
    namePathList = lib.splitString "." serviceName;
    modulePath = ["modules"] ++ namePathList;
  in
    mkModuleWithOptions {
      inherit config moduleConfig;
      name = serviceName;
      # Defines overrides for nginx-related properties
      extraOptions = let
        domain = lib.getAttrFromPath (modulePath ++ ["domain"]) config;
      in
        {
          domain = lib.mkOption {
            default = builtins.head config.modules.nginx.domains;
            type = lib.types.str;
            description = "Domain for [${name}] service";
          };
          cert = lib.mkOption {
            default = "/var/lib/acme/${domain}/cert.pem";
            type = lib.types.str;
            description = "Certificate for [${name}] service";
          };
          key = lib.mkOption {
            default = "/var/lib/acme/${domain}/key.pem";
            type = lib.types.str;
            description = "Certificate for [${name}] service";
          };
        }
        // extraOptions;
    };

  mkServiceModule = config: name: moduleConfig:
    mkServiceModule' config name {} moduleConfig;
}
