class Frontmost < Formula
  desc "See how AI apps answer your buyers' questions, from the terminal"
  homepage "https://github.com/frontmost-ai/cli"
  url "https://github.com/frontmost-ai/cli/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "9e6b8c2eeccbd36e17640b4f5c195c6bf4a9ecad954867966866344f6a3250c4"
  license "MIT"
  head "https://github.com/frontmost-ai/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/frontmost-ai/homebrew-tap/releases/download/frontmost-0.3.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "2d4e992a16ded7f9fd32e44ee37f2fdab6756bcd80900c769751427d6c74ec40"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cf0122346d07782f869589527aa0b7710ffafd278a93e40df6baf28b890b97cd"
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
