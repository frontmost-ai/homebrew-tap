class Frontmost < Formula
  desc "See how AI apps answer your buyers' questions, from the terminal"
  homepage "https://github.com/frontmost-ai/cli"
  url "https://github.com/frontmost-ai/cli/archive/refs/tags/v0.6.2.tar.gz"
  sha256 "1d0d761eb7559f074c6e77510fd8e8444a2ae8cda51fc76c1c3fd9f2a9d40e2c"
  license "MIT"
  head "https://github.com/frontmost-ai/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/frontmost-ai/homebrew-tap/releases/download/frontmost-0.6.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "f32579570b328c72d719de0c61205c24fcfa3b3fad59582b7accc24524f31845"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "690786cbaaccdb3fad8e663fbcd7db22bc77e77592a961297561d271c95474d8"
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
