# SagitalApp — Homebrew

Instalá los plugins de **SagitalApp** (parámetros espinopélvicos: PI, PT, SS, LL, PI−LL, SVA, T1PA y cifosis torácica) en Mac con [Homebrew](https://brew.sh).

## Horos (Mac con chip Apple)

```bash
brew install --cask bersonzini-glitch/sagitalapp/sagitalapp-horos
```

Después cerrá Horos con **Cmd+Q** y volvé a abrirlo: **Plugins → ROI Tools → SagitalApp – Parámetros espinopélvicos…**

## Weasis

```bash
brew install --cask bersonzini-glitch/sagitalapp/sagitalapp-weasis
```

Pide la contraseña de la Mac (usa el instalador del plugin). Después cerrá Weasis y volvé a abrirlo: la pestaña **SagitalApp** aparece en la barra lateral derecha del visor, con DICOM o con imágenes JPG/PNG.

## Actualizar y desinstalar

```bash
brew upgrade --cask sagitalapp-horos sagitalapp-weasis
brew uninstall --cask sagitalapp-horos sagitalapp-weasis
```

Los plugins también avisan solos cuando hay una versión nueva.

## Código fuente

- [SagitalApp para Horos](https://github.com/bersonzini-glitch/horos-parametros-espinopelvicos)
- [SagitalApp para Weasis](https://github.com/bersonzini-glitch/weasis-parametros-espinopelvicos)

Herramienta de apoyo para medición; no es un dispositivo médico.

Dr. Bernardo Sonzini Astudillo — [columna-spine.com](https://www.columna-spine.com)

---

Para mantenerlo: después de publicar una versión, `./bump.sh horos 1.4.0` (o `weasis`), revisar y hacer commit + push.
