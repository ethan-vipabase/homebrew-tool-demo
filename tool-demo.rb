class ToolDemo < Formula # Class name match file name (ToolDemo -> tool-demo.rb). It is kebab-case.
    desc "An sample for a devops tool"
    homepage "https://github.com/ethan-vipabase/homebrew-tool-demo" # link GitHub repo
    url "https://github.com/ethan-vipabase/homebrew-tool-demo/releases/download/v1.0.1/tool-demo-v1.0.1-macos.zip" #l link to the binary zip file. Its content is extracted to opt/homebrew/cellar/tool-demo/[1.0.1]/bin
    sha256 "80ebd65910de0f88b4f39e5c7a9c068bb063ca17040664a475308a365408d5b3" # sha256 checksum of the zip file
    license "Apache-2.0"
    version "1.0.1"

    def install
        bin.install "tool-demo" # file name of the binary tool inside the zip file. This will copy the file to /opt/homebrew/Cellar/tool-demo/[1.0.1]/bin/tool-demo
        #Post-install: (brew will auto chmod +x for the binary file)

        # or if the file is a script, you can also do:
        #bin.install "tool-demo.sh" => "tool-demo"
    end

    test do
        system "#{bin}/tool-demo", "help"
        assert_match "Usage: tool-demo", shell_oput("#{bin}/tool-demo help")
    end

end
