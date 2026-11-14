class Frontmost < Formula
  desc "See how AI apps answer your buyers' questions, from the terminal"
  homepage "https://github.com/frontmost-ai/cli"
  url "https://github.com/frontmost-ai/cli/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "db453ebee1c2a04a94e8bab80626d0ebdcf35014fd1be8b0561db9c8f0c93767"
  license "MIT"
  head "https://github.com/frontmost-ai/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/frontmost-ai/homebrew-tap/releases/download/frontmost-0.3.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "cde135e09f2e8e7d8ef0d16dd4e18071bf44ec8d699b5e398c3c4744d2c1e252"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "07eec543864591e892de734bc21c0e7c4a473ff47ae52d577854471ba84eedfd"
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
