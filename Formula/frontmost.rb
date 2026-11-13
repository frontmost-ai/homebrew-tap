class Frontmost < Formula
  desc "See how AI apps answer your buyers' questions, from the terminal"
  homepage "https://github.com/frontmost-ai/cli"
  url "https://github.com/frontmost-ai/cli/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "bc1bb42effde8b0c5c8afaea2dfeb7e182c3d973956f472a02fa6b9039f32b12"
  license "MIT"
  head "https://github.com/frontmost-ai/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/frontmost-ai/homebrew-tap/releases/download/frontmost-0.1.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "2256b7565717eeafddb45c8e7ab8f5340a301562a5fc68495bc18c16bdb670d4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "845fa8926b451bcf494f9292ed6072ecd5ef47d0573aaf634e051ba69e49317b"
  end

  depends_on "node"

  def install
    libexec.install "bin", "src", "openapi.json", "package.json"
    (bin/"frontmost").write <<~SH
      #!/bin/bash
      exec "#{formula_opt_bin("node")}/node" "#{libexec}/bin/frontmost.js" "$@"
    SH
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/frontmost --version")
  end
end
