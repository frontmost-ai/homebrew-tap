class Frontmost < Formula
  desc "See how AI apps answer your buyers' questions, from the terminal"
  homepage "https://github.com/frontmost-ai/cli"
  url "https://github.com/frontmost-ai/cli/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "f15d6dcace63a6023204a60ff963843cd7302f94488b6c51b3082a4c7f75cb1d"
  license "MIT"
  head "https://github.com/frontmost-ai/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/frontmost-ai/homebrew-tap/releases/download/frontmost-0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "904eee2f21eaad937a69cee80c12f0c15b0a08a658c8ab1976576b8db529460c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9fec55a959dcbab18cc68719732a17c73ee28ac14a1b568f82f36e32f93fb574"
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
