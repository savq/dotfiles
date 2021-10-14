{
  packageOverrides = pkgs: with pkgs; {
    savqPackages = pkgs.buildEnv {
      name = "savq-packages";
      paths = [
        arduino-cli
        gforth
        # julia   # outdated. build fails for 1.5?
        # llvm    # ?
        # python
        rust-analyzer
        rustup

        ripgrep
        tab-rs
        tectonic
        tokei
        zola

        nix-zsh-completions
        zsh-autosuggestions
        zsh-syntax-highlighting
      ];

      pathsToLink = [ "/share" "/bin" "/etc" ];
      extraOutputsToInstall = [ "man" "doc" ];
    };
  };
}

# https://nixos.org/manual/nixpkgs/unstable/#sec-declarative-package-management
