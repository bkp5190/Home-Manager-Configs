{
  programs.nixvim.plugins = {
    packer = {
      enable = true;
      plugins = [ "~/Code/Sandbox/rduck.nvim" ];
    };
  };
}
