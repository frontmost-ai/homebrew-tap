class Frontmost < Formula
  desc "See how AI apps answer your buyers' questions, from the terminal"
  homepage "https://github.com/frontmost-ai/cli"
  url "https://github.com/frontmost-ai/cli/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "1e792f0c3dc6716e2ff9f99e638bea82412d0a3b4c05a863a6bdf93354397fad"
  license "MIT"
  head "https://github.com/frontmost-ai/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/frontmost-ai/homebrew-tap/releases/download/frontmost-0.5.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "c14726895140df0b215ce0a7eb23c20b33e79fce5cb9a4b37f70e4a5f7fd16ae"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7a5e7ac2a4a124551e927ff0f9a5f42974f05468c1352b001dc2bc482e49ca79"
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
