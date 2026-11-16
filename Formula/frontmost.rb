class Frontmost < Formula
  desc "See how AI apps answer your buyers' questions, from the terminal"
  homepage "https://github.com/frontmost-ai/cli"
  url "https://github.com/frontmost-ai/cli/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "524435330e9106d6c358a89030ab5c3f834fba6e3325d64ce69ede3ff40c5c09"
  license "MIT"
  head "https://github.com/frontmost-ai/cli.git", branch: "main"

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
