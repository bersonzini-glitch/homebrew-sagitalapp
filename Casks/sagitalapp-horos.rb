cask "sagitalapp-horos" do
  version "1.6.0"
  sha256 "2642a2a5b6c4aca86f2ce140d8ba888af042577661db9ecec2b11f09d4783e39"

  url "https://github.com/bersonzini-glitch/horos-parametros-espinopelvicos/releases/download/v#{version}/SpinopelvicParams.horosplugin.zip"
  name "SagitalApp para Horos"
  desc "Horos plugin for spinopelvic sagittal parameters (PI, PT, SS, LL, SVA, T1PA)"
  homepage "https://github.com/bersonzini-glitch/horos-parametros-espinopelvicos"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on :macos

  # Copied by a script rather than an artifact so the quarantine flag Homebrew sets on downloads can be
  # cleared (Horos refuses to load a quarantined plugin), replacing any copy from the .pkg or the
  # plugin's own updater.
  installer script: {
    executable: "/bin/bash",
    args:       ["-c", <<~SH],
      set -e
      DEST="$HOME/Library/Application Support/Horos/Plugins"
      mkdir -p "$DEST"
      rm -rf "$DEST/SpinopelvicParams.horosplugin"
      cp -R "#{staged_path}/SpinopelvicParams.horosplugin" "$DEST/"
      xattr -dr com.apple.quarantine "$DEST/SpinopelvicParams.horosplugin"
    SH
  }

  # A script rather than `delete`, which runs through sudo and would ask for a password.
  uninstall script: {
    executable: "/bin/rm",
    args:       ["-rf", "#{Dir.home}/Library/Application Support/Horos/Plugins/SpinopelvicParams.horosplugin"],
    sudo:       false,
  }

  caveats <<~EOS
    Cerrá Horos con Cmd+Q y volvé a abrirlo. El plugin está en
      Plugins → ROI Tools → SagitalApp – Parámetros espinopélvicos…
  EOS
end
