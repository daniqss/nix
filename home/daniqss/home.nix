{
  pkgs,
  config,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "daniqss";
    homeDirectory = "/home/${config.home.username}";

    stateVersion = "24.11";
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # Desktop
    hyprland
    rofi-wayland
    mako
    hyprpolkitagent
    brightnessctl
    swww
    libnotify
    wl-clipboard

    # Terminal
    zsh
    starship

    # Applications
    chromium
    obsidian
    dropbox
    pavucontrol
    vesktop
    spotify
    blueberry

    # Fonts
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.jetbrains-mono

    # development
    thonny

    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FalntasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/daniqss/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "micro";
    BROWSER = "chromium";
    NIXOS_OZONE_WL = "1";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      "gitkey" = "${pkgs.coreutils}/bin/cat ${config.home.homeDirectory}/Dropbox/keys/github_key.md | ${pkgs.wl-clipboard}/bin/wl-copy";
    };
    history = {
      size = 30000;
      save = 10000;
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      character = {
        success_symbol = "[›](bold green)";
        error_symbol = "[›](bold red)";
      };

      git_status = {
        deleted = "✗";
        modified = "✶";
        staged = "✓";
        stashed = "≡";
      };

      nix_shell = {
        symbol = " ";
        heuristic = true;
      };
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      window.padding = {
        x = 10;
        y = 10;
      };
      window.decorations = "none";
      window.opacity = 0.7;
      scrolling.history = 1000;
      font = {
        normal = {
          family = "Firacode Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "Firacode Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "Firacode Nerd Font";
          style = "Italic";
        };
        size = 14;
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "daniqss";
    userEmail = "danielqueijo14@gmail.com";
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };
  };

  # programs.kitty.enable = true; # required for the default Hyprland config
  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   # set the flake package
  #   package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  #   portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

  #   extraConfig = "${homeDir}/.config/hypr/hyprland.conf";
  # };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
