cask "sagitalapp-horos" do
  version "1.4.0"
  sha256 "46b0c4ea632c2292be69610cfc6cfd4146cb710d467c9383fd6d855e093687dd"

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

  uninstall delete: "~/Library/Application Support/Horos/Plugins/SpinopelvicParams.horosplugin"

  caveats <<~EOS
    Cerrá Horos con Cmd+Q y volvé a abrirlo. El plugin está en
      Plugins → ROI Tools → SagitalApp – Parámetros espinopélvicos…
  EOS
end
