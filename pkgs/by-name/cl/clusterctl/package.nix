{
  lib,
  buildGoModule,
  fetchFromGitHub,
  installShellFiles,
  testers,
  clusterctl,
}:

buildGoModule rec {
  pname = "clusterctl";
  version = "1.10.1";

  src = fetchFromGitHub {
    owner = "kubernetes-sigs";
    repo = "cluster-api";
    rev = "v${version}";
    hash = "sha256-8clNhU9RxQ63zBaNnvftp4+wUG33bL8KCxbgzJwJdPo=";
  };

  vendorHash = "sha256-iProsOETP9ahyemF2tHUVmoiqjG+ghjZkHb6PAhygb4=";

  subPackages = [ "cmd/clusterctl" ];

  nativeBuildInputs = [ installShellFiles ];

  ldflags =
    let
      t = "sigs.k8s.io/cluster-api/version";
    in
    [
      "-X ${t}.gitMajor=${lib.versions.major version}"
      "-X ${t}.gitMinor=${lib.versions.minor version}"
      "-X ${t}.gitVersion=v${version}"
    ];

  postInstall = ''
    # errors attempting to write config to read-only $HOME
    export HOME=$TMPDIR

    installShellCompletion --cmd clusterctl \
      --bash <($out/bin/clusterctl completion bash) \
      --fish <($out/bin/clusterctl completion fish) \
      --zsh <($out/bin/clusterctl completion zsh)
  '';

  passthru.tests.version = testers.testVersion {
    package = clusterctl;
    command = "HOME=$TMPDIR clusterctl version";
    version = "v${version}";
  };

  meta = {
    changelog = "https://github.com/kubernetes-sigs/cluster-api/releases/tag/${src.rev}";
    description = "Kubernetes cluster API tool";
    mainProgram = "clusterctl";
    homepage = "https://cluster-api.sigs.k8s.io/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ qjoly ];
  };
}
