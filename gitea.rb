require "formula"

class Gitea < Formula
  homepage "https://github.com/go-gitea/gitea"
  head "https://github.com/go-gitea/gitea.git"

  stable do
    version "1.10.0"
    url "https://dl.gitea.io/gitea/#{version}/gitea-#{version}-darwin-10.6-amd64"
    sha256 `curl -s https://dl.gitea.io/gitea/#{version}/gitea-#{version}-darwin-10.6-amd64.sha256`.split(" ").first
  end

  devel do
    url "https://dl.gitea.io/gitea/master/gitea-master-darwin-10.6-amd64"
    sha256 `curl -s https://dl.gitea.io/gitea/master/gitea-master-darwin-10.6-amd64.sha256`.split(" ").first
    version "master"
  end

  head do
    url "https://github.com/go-gitea/gitea.git", :branch => "master"
    depends_on "go" => :build
  end

  test do
    system "#{bin}/gitea", "--version"
  end

  def install
    case
    when build.head?
      mkdir_p buildpath/File.join("src", "code.gitea.io")
      ln_s buildpath, buildpath/File.join("src", "code.gitea.io", "gitea")

      ENV.append_path "PATH", File.join(buildpath, "bin")

      ENV["GOPATH"] = buildpath
      ENV["GOHOME"] = buildpath
      ENV["TAGS"] = "bindata sqlite tidb"

      system "cd src/code.gitea.io/gitea && make generate build"

      bin.install "#{buildpath}/gitea" => "gitea"
    else
      bin.install "#{buildpath}/gitea-#{version}-darwin-10.6-amd64" => "gitea"
    end
  end
  
  
  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
        <dict>
          <key>SuccessfulExit</key>
          <false/>
        </dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{bin}/gitea</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>#{var}</string>
        <key>StandardErrorPath</key>
        <string>#{var}/log/gitea.log</string>
        <key>StandardOutPath</key>
        <string>#{var}/log/gitea.log</string>
      </dict>
    </plist>
  EOS
  end
end
