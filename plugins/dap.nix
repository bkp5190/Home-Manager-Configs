{
  programs.nixvim.plugins = {
    dap.enable = true;
    dap-go.enable = true;
    dap-ui.enable = true;
    dap-virtual-text.enable = true;
    neotest = {
      enable = true;
      adapters.go.enable = true;
    };
  };
}
