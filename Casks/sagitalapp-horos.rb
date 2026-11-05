cask "sagitalapp-horos" do
  version "1.10.1"
  sha256 "eca7fed22f00393b7ecf6ae3d2fb7e302772fe69a42093bc156968ea50446779"

  url "https://github.com/bersonzini-glitch/horos-parametros-espinopelvicos/releases/download/v#{version}/SpinopelvicParams.horosplugin.zip"
  name "SagitalApp para Horos y OsiriX"
  desc "Horos and OsiriX plugin for spinopelvic sagittal parameters (PI, PT, SS, LL, SVA, T1PA)"
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
      SRC="#{staged_path}/SpinopelvicParams.horosplugin"
      # The same bundle runs in OsiriX, which wants the .osirixplugin extension in its own folder.
      for DEST in "$HOME/Library/Application Support/Horos/Plugins/SpinopelvicParams.horosplugin" \
                  "$HOME/Library/Application Support/OsiriX/Plugins/SpinopelvicParams.osirixplugin"; do
        mkdir -p "$(dirname "$DEST")"
        rm -rf "$DEST"
        cp -R "$SRC" "$DEST"
        xattr -dr com.apple.quarantine "$DEST"
      done
    SH
  }

  # A script rather than `delete`, which runs through sudo and would ask for a password.
  uninstall script: {
    executable: "/bin/rm",
    args:       ["-rf", "#{Dir.home}/Library/Application Support/Horos/Plugins/SpinopelvicParams.horosplugin",
                 "#{Dir.home}/Library/Application Support/OsiriX/Plugins/SpinopelvicParams.osirixplugin"],
    sudo:       false,
  }

  caveats <<~EOS
    Cerrá Horos u OsiriX con Cmd+Q y volvé a abrirlo. El plugin está en
      Plugins → ROI Tools (Herramientas ROI) → SagitalApp – Parámetros espinopélvicos…
  EOS
end
