{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "github-markdown-toc-go";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "ekalinin";
    repo = "github-markdown-toc.go";
    rev = "v${version}";
    hash = "sha256-hCkahhnTAF17ctJTL83wZxZiKGDzIKLwWKTTnwYQ3cs=";
  };

  vendorHash = "sha256-K5yb7bnW6eS5UESK9wgNEUwGjB63eJk6+B0jFFiFero=";

  meta = {
    homepage = "https://github.com/ekalinin/github-markdown-toc.go";
    description = "Easy TOC creation for GitHub README.md (in go)";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ dannixon ];
    mainProgram = "gh-md-toc";
  };
}
