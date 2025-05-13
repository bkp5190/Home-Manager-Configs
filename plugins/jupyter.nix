{ pkgs, ... }: {
  programs.nixvim.plugins = {
    molten = {
      settings = {
        use_border_highlights = true;
        output_virt_lines = true;
        virt_lines_off_by_1 = true;
        image_provider = "image.nvim";
      };
      enable = true;
    };
    image = {
      settings = {
        backend = "kitty";
      };
      enable = true;
    };
    quarto = {
      settings = {
        codeRunner = {
          default_method = "molten";
        };
      };
      enable = true;
    };
    jupytext = {
      settings = {
        style = "markdown";
        output_extension = "md";
        force_ft = "markdown";
      };
      enable = true;
      package = pkgs.vimUtils.buildVimPlugin {
        pname = "jupytext.nvim";
        version = "0.0.0";
        src = pkgs.fetchgit {
          url = "https://github.com/bkp5190/jupytext.nvim";
          branchName = "deprecated-healthcheck";
          rev = "695295069a3aac0cf9a1b768589216c5b837b6f1";
          sha256 = "sha256-W6fkL1w2dYSjpAYOtBTlYjd2CMYPB596NQzBylIVHrE=";
        };
      };
    };
    otter.enable = true;
  };
}
