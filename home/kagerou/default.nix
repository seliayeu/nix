{ config, pkgs, inputs, lib, ... }:
{
  imports = [ inputs.mnw.homeManagerModules.default ];
  home.username = "dotuncle";
  home.homeDirectory = "/home/dotuncle";
  home.packages = with pkgs; [
    neovim
    inputs.zen-browser.packages."${stdenv.hostPlatform.system}".default
    tofi
    kitty
    git
    zoxide
    eza
    bat
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term-slab
    noto-fonts-cjk-sans
    noto-fonts
    gammastep
    takao
    wpaperd
    vesktop
    obsidian
    anki-bin
    mpv
    tmux
    libnotify
    glib
    tiny
    syncthing
    pass
    unzip
    zip
    gnupg1
    pinentry-curses
    yazi
    waybar
    ticktick
    zenity
    zotero
    xfce.thunar
    slurp
    grim
    wezterm
    tldr
    ripgrep
    fzf
    fortune
    waypipe
    man-pages
    man-pages-posix
  ];
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      keybindings = lib.mkOptionDefault {
        "${modifier}+space" = "exec tofi-drun | xargs swaymsg exec --";
        "${modifier}+Return" = "exec wezterm";
        "${modifier}+Ctrl+Shift+h" = "move workspace to output left";
        "${modifier}+Ctrl+Shift+k" = "move workspace to output up";
        "${modifier}+Ctrl+Shift+j" = "move workspace to output down";
        "${modifier}+Ctrl+Shift+l" = "move workspace to output right";
        "${modifier}+Shift+f" = "bar mode toggle";
        "${modifier}+comma" = "layout toggle tabbed stacking";
        "${modifier}+period" = "layout toggle default split";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "Alt+Shift+4" = "exec slurp | grim -g - - | wl-copy";
      };
      input = {
      	"9610:4103:SINOWEALTH_Wired_Gaming_Mouse" = {
          accel_profile = "flat";
          pointer_accel = "0.5";
        };
      };
      assigns = {
        "1" = [{ app_id = "wezterm"; }];
        "2" = [{ app_id = "zen-beta"; }];
      };
      gaps = {
        inner = 4;
        outer = 4;
      };
      terminal = "wezterm";
      startup = [
        { command = "wezterm"; }
        { command = "zen-beta"; }
        { command = "swaymsg workspace 2"; }
      ];
      colors = {
        focused = {
          border = "#b19565";
          background = "#101010";
          text = "#c9af82";
          indicator = "#917a53";
          childBorder = "#b19565";
        };
        focusedInactive = {
          border = "#574a35";
          background = "#101010";
          text = "#c9af82";
          indicator = "#574a35";
          childBorder = "#574a35";
        };
        unfocused  = {
          border = "#4b4239";
          background = "#101010";
          text = "#c9af82";
          indicator = "#574a35";
          childBorder = "#4b4239";
        };
      };
      floating = {
        criteria = [
          { class = "ticktick"; }
          { class = "Anki"; }
          { app_id = "Thunar"; }
        ];
      };
      bars = [{
        command = "waybar";
        position = "bottom";
      }];
    };
    extraConfig = ''
      default_border pixel
      default_floating_border pixel
    '';
  };
  programs.tofi = {
    enable = true;
    settings = {
      font = "Iosevka Nerd Font Mono";
      font-size = 12;
      prompt-text = " ";
      hide-cursor = false;
      history = true;
      outline-width = 0;
      border-width = 2;
      height = 500;
      width = 350;
      min-input-width = 100;
      padding-left = 30;
      padding-top = 20;
      prompt-padding = 5;
      result-spacing = 5;

      background-color = "#1d2021dd";
      border-color = "#b19565";
      selection-color = "#ebdbb2";
      text-color = "#706955";
      prompt-color = "#a88984";

      padding = 5;
    };
  };
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        font = wezterm.font {
          family = 'Iosevka Nerd Font Mono',
          weight = 'Medium',
          harfbuzz_features = { 'liga=0' },
        },
        font_size = 10.5,
        window_padding = {
          left = 8,
          right = 8,
          top = 4,
          bottom = 4,
        },
        color_scheme = "GruvboxDarkHard",
        window_background_opacity = 0.8,
        audible_bell = "Disabled",
        enable_tab_bar = false,
        front_end = "WebGpu",
      }
    '';
  };
  programs.kitty = {
    enable = true;
    font = {
      size = 11;
      name = "Iosevka Nerd Font Mono";
    };
    themeFile = "gruvbox-dark-hard";
    settings = {
      window_padding_width = "2 5";
      background_opacity = 0.8;
      enable_audio_bell = false;
    };
    shellIntegration.enableZshIntegration = true;
  };
  programs.git = {
    enable = true;
    settings.user = {
      email = "dan.seliayeu@gmail.com";
      name = "Danila Seliayeu";
    };
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      cat = "bat";
      cd = "z";
      ls = "eza";
    };
    initContent = ''
      autoload -U select-word-style
      select-word-style bash
      eval "$(zoxide init zsh)"
      setopt rmstarsilent
    '';
    sessionVariables = {
      EDITOR = "nvim";
      SUDO_EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
  services.wpaperd = {
    enable = true;
    settings = {
      default = {
        path = "~/wallpapers";
      };
    };
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  services.gammastep = {
    enable = true;
    latitude = 53.631611;
    longitude = -113.323975;
    temperature = {
      day = 6500;
      night = 2500;
    };
  };
  services.mako = {
    enable = true;
    settings = {
      max-visible=1;
      anchor="top-right";
      font="Iosevka Nerd Font Mono";
      icons=1;
      markup=1;
      padding=5;
      background-color="#689d6a";
      progress-color="#ebdbb2";
      text-color="#1d2021";
      border-color="#ebdbb2";
      border-size=5;
      border-radius=2;
    };
  };
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        identityFile = "~/.ssh/id_rsa";
        addKeysToAgent = "yes";
        serverAliveInterval = 60;
      };
      "innis" = {
        user = "seliayeu";
        hostname = "innisfree.cs.ualberta.ca";
      };
      "heldar" = {
        user = "danila.seliayeu";
        proxyJump = "innis";
      };
      "cdol01" = {
        user = "seliayeu";
        proxyJump = "innis";
        forwardX11 = true;
        forwardX11Trusted = true;
      };
      "cdol02" = {
        user = "seliayeu";
        proxyJump = "innis";
        forwardX11 = true;
        forwardX11Trusted = true;
      };
      "cdol03" = {
        user = "seliayeu";
        proxyJump = "innis";
      };
      "cdol04" = {
        user = "seliayeu";
        proxyJump = "innis";
      };
      "narval" = {
        user = "seliayeu";
        hostname = "narval.alliancecan.ca";
      };
    };
  };
  programs.mnw = {
    enable = true;
    desktopEntry = false;
    appName = "nvim";
    initLua = ''
      require("lz.n").load("plugins")
      require("config")
    '';
    extraBinPath = with pkgs; [
      nixd
      statix
      nil
      lua-language-server
      stylua
      clang-tools
      ripgrep
      fd
    ];
    plugins = {
      start = with pkgs; [
        vimPlugins.lz-n
        vimPlugins.nvim-lspconfig
        vimPlugins.gruvbox-nvim
        {
          pname = "snacks.nvim";
          version = "2.28.0";
          name = "snacks.nvim-2.28.0";
          src = pkgs.fetchFromGitHub {
            owner = "folke";
            repo = "snacks.nvim";
            tag = "v2.28.0";
            hash = "sha256-Kr8NbQ4V0ShJktqQDygd6NN6A6szkcVMlTxhQjjs/AE=";
          };
        }
      ];
      dev.config = {
        pure = ../../nvim;
        impure = "/home/dotuncle/.config/nixos/nvim";
      };
    };
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  programs.tiny = {
    enable = true;
    settings = {
      servers = [
        {
          addr = "irc.oftc.net";
          port = 6697;
          tls = true;
          realname = "dan";
          nicks = [ "dotuncle" ];
          join = [ "#tiny" ];
          nickserv_ident = {
            command = ''pass show "irc/oftc-dotuncle"'';
          };
        }
        {
          addr = "irc.libera.chat";
          port = 6697;
          tls = true;
          realname = "dan";
          nicks = [ "dotuncle" ];
          join = [ "#lobsters #tmux #soju #neovim" ];
          sasl = {
            username = "dotuncle";
            password = {
              command = ''pass show "irc/liberachat-dotuncle"'';
            };
          };
        }
        {
          addr = "vancouver-ca.newnet.net";
          port = 6697;
          tls = true;
          realname = "dan";
          nicks = [ "dotuncle" ];
          join = [ "#meta #club #tildetel" ];
          sasl = {
            username = "dotuncle";
            password = {
              command = ''pass show "irc/newnet-dotuncle"'';
            };
          };
        }
        {
          addr = "irc.tilde.chat";
          port = 6697;
          tls = true;
          realname = "dan";
          nicks = [ "dotuncle" ];
          join = [ "#meta #team" ];
          sasl = {
            username = "dotuncle";
            password = {
              command = ''pass show "irc/tildechat-dotuncle"'';
            };
          };
        }
      ];
      layout = "aligned";
      defaults = {
        nicks = [ "dotuncle" ];
        realname = "dan";
        join = [];
        tls = false;
      };
    };
  };
  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";
    };
    package = pkgs.pass;
  };
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.waybar = {
    enable = true;
    style = builtins.readFile waybar/style.css;
    settings = [{
      ipc = true;
      layer = "top";
      spacing = 0;
      height = 0;
      margin-top = 0;
      margin-right = 0;
      margin-bottom = 0;
      margin-left = 0;
      modules-left = [
        "sway/workspaces"
      ];
      modules-center = [
        "clock"
      ];
      modules-right = [
        "tray"
        "cpu_text"
        "cpu"
        "memory"
        "network"
        "pulseaudio"
      ];
      "sway/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
        tooltip = false;
      };
      tray = {
        spacing = 10;
        tooltip = false;
      };
    }];
  };
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g extended-keys on
      set -as terminal-features 'xterm*:extkeys'
    '';
  };
  services.syncthing = {
    enable = true;
  };
  services.gpg-agent = {
    enable = true;
    pinentry.program = "pinentry-curses";
    pinentry.package = pkgs.pinentry-curses;
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "zen-beta.desktop";
      "x-scheme-handler/http" = "zen-beta.desktop";
      "x-scheme-handler/https" = "zen-beta.desktop";
      "x-scheme-handler/about" = "zen-beta.desktop";
      "x-scheme-handler/unknown" = "zen-beta.desktop";
    };
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
  gtk = {
    gtk2 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };
  home.stateVersion = "25.05";
}
