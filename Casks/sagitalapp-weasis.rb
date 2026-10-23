cask "sagitalapp-weasis" do
  version "1.6.1"
  sha256 "495c89e7da95bb07a4da495762556c83825f510ceaa104b5a5aaf25d87b90307"

  url "https://github.com/bersonzini-glitch/weasis-parametros-espinopelvicos/releases/download/v#{version}/Instalar-SagitalApp-Weasis-Mac.pkg"
  name "SagitalApp para Weasis"
  desc "Weasis plugin for spinopelvic sagittal parameters (PI, PT, SS, LL, SVA, T1PA)"
  homepage "https://github.com/bersonzini-glitch/weasis-parametros-espinopelvicos"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  pkg "Instalar-SagitalApp-Weasis-Mac.pkg"

  # Same as "Desinstalar Espinopelvico Weasis.command": the per-user files the package's
  # postinstall created, and JAVA_TOOL_OPTIONS without the plugin's setting.
  uninstall script:  {
              executable: "/bin/bash",
              args:       ["-c", <<~SH],
                AGENT="$HOME/Library/LaunchAgents/com.columnaspine.weasis-espinopelvico.plist"
                launchctl bootout "gui/$(id -u)" "$AGENT" 2>/dev/null
                rm -f "$AGENT" "$HOME/.weasis/plugins/espinopelvico.json" "$HOME"/.weasis/plugins/weasis-espinopelvico-*.jar
                REST=$(launchctl getenv JAVA_TOOL_OPTIONS | sed -E 's#-Dfelix\\.extended\\.config\\.properties=[^ ]*espinopelvico\\.json##; s/^ +//; s/ +$//')
                if [ -n "$REST" ]; then launchctl setenv JAVA_TOOL_OPTIONS "$REST"; else launchctl unsetenv JAVA_TOOL_OPTIONS; fi
              SH
              sudo:       false,
            },
            pkgutil: "com.columnaspine.weasis.spinopelvic",
            delete:  "/Library/Application Support/WeasisEspinopelvico"

  caveats <<~EOS
    Cerrá Weasis y volvé a abrirlo. Abrí una radiografía de perfil (DICOM o JPG/PNG)
    y buscá la pestaña SagitalApp en la barra lateral derecha del visor.
  EOS
end
