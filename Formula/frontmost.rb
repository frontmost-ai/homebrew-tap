class Frontmost < Formula
  desc "See how AI apps answer your buyers' questions, from the terminal"
  homepage "https://github.com/frontmost-ai/cli"
  url "https://github.com/frontmost-ai/cli/archive/refs/tags/v0.7.1.tar.gz"
  sha256 "fb5329098c2ff6c509334ada0e52fe2c46733a633c639bebcbd15af4565788f5"
  license "MIT"
  head "https://github.com/frontmost-ai/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/frontmost-ai/homebrew-tap/releases/download/frontmost-0.7.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "d8ea2655976704c5e3bfdb9870f529c54926695dd2c30126a438229097db6d4e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "606fd4575a07fb441d845bd1df8c1abe3a4c25446a8ad94e493568077c024ff9"
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
