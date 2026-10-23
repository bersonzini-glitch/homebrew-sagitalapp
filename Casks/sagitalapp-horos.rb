cask "sagitalapp-horos" do
  version "1.3.0"
  sha256 "0b3d6d7cf1c13588591d1c2207b8c3e29c53364d73c0691851d67cff798f6900"

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

  artifact "SpinopelvicParams.horosplugin",
           target: "~/Library/Application Support/Horos/Plugins/SpinopelvicParams.horosplugin"

  # A copy put there by the .pkg installer or by the plugin's own updater would block the move.
  preflight_steps do
    remove "Library/Application Support/Horos/Plugins/SpinopelvicParams.horosplugin", base: :home, recursive: true
  end

  # Horos refuses to load a quarantined plugin, and install steps have no xattr action yet.
  postflight do # rubocop:disable Cask/InstallSteps
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine",
                          File.expand_path("~/Library/Application Support/Horos/Plugins/SpinopelvicParams.horosplugin")]
  end

  caveats <<~EOS
    Cerrá Horos con Cmd+Q y volvé a abrirlo. El plugin está en
      Plugins → ROI Tools → SagitalApp – Parámetros espinopélvicos…
  EOS
end
