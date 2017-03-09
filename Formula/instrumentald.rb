class Instrumentald < Formula
  head "https://github.com/Instrumental/instrumentald.git"
  desc "A server agent that provides system monitoring and service monitoring. It's fast, reliable, runs on anything *nix, is simple to configure and deploy, and has a small memory footprint."
  homepage "https://github.com/Instrumental/instrumentald"
  url "https://github.com/Instrumental/instrumentald/releases/download/v1.0.1/instrumentald_1.0.1_osx.tar.gz"
  version "1.0.1"
  sha256 "932e7a8e9c17b157d272793961988c3da484b866fbcd19de9c13adca8d0d6abe"

  def install
    # The binary will think it's in one place (/usr/local/bin/), but the lib
    # files it wants are actually somewhere else (/usr/local/Cellar/instrumentald/VERSION/bin)
    # Rather than making a custom version of this executable for homebrew, let's
    # just edit-in-place to make do right
    inreplace "opt/instrumentald/instrumentald" do |s|
      s.gsub! /SELFDIR=.*/, "SELFDIR=\"#{bin}\""
    end

    bin.install Dir["opt/instrumentald/*"]
  end

  def post_install
    FileUtils.chmod 0666, "#{bin}/lib/vendor/Gemfile.lock"

    ohai "instrumentald is \e[32mready to go!\e[0m"
    ohai "  instrumentald -k <PROJECT_TOKEN>"

    opoo "You need an Instrumental account and a project key to run instrumentald. More info: \e[4m\e[33mhttps://instrumentalapp.com/docs/instrumentald/getting-started\e[0m"
  end
end
