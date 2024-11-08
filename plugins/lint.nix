{
  programs.nixvim.plugins = {
    lint = {
      enable = true;
      lintersByFt = {
        text = ["vale"];
        markdown = ["vale"];
        dockerfile = ["hadolint"];
        terraform = ["tflint"];
        python = ["pylint"];
      };
    };
  };
}
