class Frontmost < Formula
  desc "See how AI apps answer your buyers' questions, from the terminal"
  homepage "https://github.com/frontmost-ai/cli"
  url "https://github.com/frontmost-ai/cli/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "0b1c7a66875048654d51d067effe26be9b0728cc6dd86d3bf7320b4521a7a352"
  license "MIT"
  head "https://github.com/frontmost-ai/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/frontmost-ai/homebrew-tap/releases/download/frontmost-0.1.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "36ba63ee054212bbecf66d55fceb127955ec4ec5f11e5a0b9f3b1afe305ae4ea"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6b943d73a18f59ad7263c9b9cdee7aa65180bb77d46c1a365d79966323133dc8"
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
