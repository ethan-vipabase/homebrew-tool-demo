class ToolDemo < Formula
    desc "Tool demo for devops"
    homepage "https://github.com/ethan-vipabase/homebrew-tool-demo.git"
    url "https://github.com/ethan-vipabase/homebrew-tool-demo/releases/download/v1.0/tool_demo_v1.0_macos.zip"
    sha256 "678592b63f545f84160db8adac533e6722afe79253059da851be757ecaa0d181"
    version "1.0.0"

    def install
        bin.install "tool_demo"
        #Post-install: chmod +x auto.
    end

    test do
        system "#{bin}/tool_demo", "help"
        assert_match "Usage: tool_demo", shell_oput("#{bin}/tool_demo help")
    end

end
