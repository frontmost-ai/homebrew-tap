class Frontmost < Formula
  desc "See how AI apps answer your buyers' questions, from the terminal"
  homepage "https://github.com/frontmost-ai/cli"
  url "https://github.com/frontmost-ai/cli/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "62174680e9e5ff48ca1583cbe5008deaccee0f13efa7f85b4cde0162497c630f"
  license "MIT"
  head "https://github.com/frontmost-ai/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/frontmost-ai/homebrew-tap/releases/download/frontmost-0.6.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "ce9b5d202320c571d6d24485f5dcacc6ccd54fa8eb33b2fc3847f3e4b8dd583a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bdafa882e1409ea3388b1d71e99e9511af24292f37c1b4971009dfae0c2c74dd"
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
