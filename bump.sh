#!/bin/zsh
# Points a cask at a release: ./bump.sh horos 1.4.0  or  ./bump.sh weasis 1.4.0
set -euo pipefail
cd "${0:A:h}"
case $1 in
  horos)
    REPO=horos-parametros-espinopelvicos
    ASSET=SpinopelvicParams.horosplugin.zip
    ;;
  weasis)
    REPO=weasis-parametros-espinopelvicos
    ASSET=Instalar-SagitalApp-Weasis-Mac.pkg
    ;;
  *)
    echo "uso: $0 horos|weasis VERSION"
    exit 1
    ;;
esac
SHA=$(curl -sfL "https://github.com/bersonzini-glitch/${REPO}/releases/download/v$2/${ASSET}" | shasum -a 256 | cut -d' ' -f1)
sed -i '' -E "s/^  version \".*\"/  version \"$2\"/; s/^  sha256 \".*\"/  sha256 \"${SHA}\"/" Casks/sagitalapp-"$1".rb
git diff --stat
