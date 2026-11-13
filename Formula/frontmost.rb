class Frontmost < Formula
  desc "See how AI apps answer your buyers' questions, from the terminal"
  homepage "https://github.com/frontmost-ai/cli"
  url "https://github.com/frontmost-ai/cli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "4eeb7ec06cb616cf170d610a8fdcf818be865c3b36e83cedb413a166ebc86699"
  license "MIT"
  head "https://github.com/frontmost-ai/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/frontmost-ai/homebrew-tap/releases/download/frontmost-0.1.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "80ea30e15ec7fb951e115a2723c86e0e6a0ca21206f82377bde678c34c9123f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "41555a6118ee20705350f903b2cf6fabd201b5e662f8de7b840b3f974ee02541"
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
