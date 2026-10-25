{
  lib,
  stdenv,
  fetchurl,
  copyDesktopItems,
  makeDesktopItem,
  openjdk,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "visual-paradigm-academic";
  version = "17.3";

  src = fetchurl {
    url = "https://www.visual-paradigm.com/downloads/vp17.3/Visual_Paradigm_Linux64_InstallFree.tar.gz";
    hash = "sha256-4OjwfJP0sUZPB/gXigNjrH4Xc3u0yIflhhUnj4rTk28=";
  };

  sourceRoot = "Visual_Paradigm_${finalAttrs.version}";

  nativeBuildInputs = [copyDesktopItems];

  desktopItems = [
    (makeDesktopItem {
      name = "visualparadigm";
      desktopName = "Visual Paradigm Standard";
      exec = "Visual_Paradigm %f";
      icon = "vpuml";
    })
    (makeDesktopItem {
      name = "visualparadigmproductselector";
      desktopName = "Visual Paradigm Product Selector";
      exec = "Visual_Paradigm_Product_Selector";
      icon = "ProductSelector";
    })
    (makeDesktopItem {
      name = "visualparadigmshapeeditor";
      desktopName = "Visual Paradigm Shape Editor";
      exec = "Visual_Paradigm_Shape_Editor";
      icon = "vpuml";
    })
  ];

  installPhase = ''
    runHook preInstall

    install -D Application/resources/vpuml.png $out/share/icons/hicolor/512x512/apps/vpuml.png
    install -D Application/resources/ProductSelector.png $out/share/icons/hicolor/512x512/apps/ProductSelector.png

    mkdir -p $out/{bin,share/visual-paradigm-academic}
    mv {Application,.install4j} $out/share/visual-paradigm-academic/

    for bin in Visual_Paradigm Visual_Paradigm_Product_Selector Visual_Paradigm_Shape_Editor; do
      substituteInPlace $out/share/visual-paradigm-academic/Application/bin/$bin \
        --replace-fail '# INSTALL4J_JAVA_HOME_OVERRIDE=' "INSTALL4J_JAVA_HOME_OVERRIDE=${openjdk}" \
        --replace-fail 'app_home=../../' "app_home=${placeholder "out"}/share/visual-paradigm-academic"
      ln -s $out/share/visual-paradigm-academic/Application/bin/$bin $out/bin/
    done

    runHook postInstall
  '';

  meta = {
    description = "Visual Paradigm Standard for academic license holders";
    homepage = "https://www.visual-paradigm.com/";
    license = lib.licenses.unfree;
    mainProgram = "Visual_Paradigm";
    platforms = lib.platforms.linux;
    sourceProvenance = with lib.sourceTypes; [
      binaryBytecode
      binaryNativeCode
    ];
  };
})
