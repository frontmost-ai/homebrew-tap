class Frontmost < Formula
  desc "See how AI apps answer your buyers' questions, from the terminal"
  homepage "https://github.com/frontmost-ai/cli"
  url "https://github.com/frontmost-ai/cli/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "1998a9e14b80fd1f01b1cd7839b4a492ece03605edf68455a57b638ca4484480"
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
