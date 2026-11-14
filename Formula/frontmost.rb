class Frontmost < Formula
  desc "See how AI apps answer your buyers' questions, from the terminal"
  homepage "https://github.com/frontmost-ai/cli"
  url "https://github.com/frontmost-ai/cli/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "8169cc085625ce23276d7a497d4a29d42b6b589cfe7b69a97003b73831faa447"
  license "MIT"
  head "https://github.com/frontmost-ai/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/frontmost-ai/homebrew-tap/releases/download/frontmost-0.4.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "6addb21c6b120944ee3779b1c212447808011f3e0e92d8525d7e1d6b103b6c22"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "df20273b7839585536720a6551d2eb08d0e5bc5c04fc03c18d318a64b0817552"
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
