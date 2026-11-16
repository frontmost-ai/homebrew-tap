class Frontmost < Formula
  desc "See how AI apps answer your buyers' questions, from the terminal"
  homepage "https://github.com/frontmost-ai/cli"
  url "https://github.com/frontmost-ai/cli/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "175f47d56b7398d69bf4503e6b29258e305dc323d2927dcb77369aeb82836602"
  license "MIT"
  head "https://github.com/frontmost-ai/cli.git", branch: "main"

  bottle do
    root_url "https://github.com/frontmost-ai/homebrew-tap/releases/download/frontmost-0.7.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "114d0269d655195fecb6664c105a4e1531fe993a2c4adbeed3265a9299d088a1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "015ffc7af599f89d351c6839af01b24063f700ed8fb83e5e154051b8186b1ff7"
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
