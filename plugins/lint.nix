{
  programs.nixvim.plugins = {
    lint = {
      enable = true;
      lintersByFt = {
        text = ["vale"];
        json = ["jsonlint"];
        markdown = ["vale"];
        dockerfile = ["hadolint"];
        terraform = ["tflint"];
        python = ["pylint"];
      };
    };
  };
}
