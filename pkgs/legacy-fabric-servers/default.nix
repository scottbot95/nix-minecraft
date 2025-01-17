{ callPackage
, lib
, vanillaServers
}:

let
  versions = lib.importJSON ./locks.json;

  inherit (lib.our) escapeVersion removeVanilla;
  latestVersion = escapeVersion (lib.our.latestVersion versions);

  packages =
    builtins.foldl' (x: y: x // y) { }
      (lib.mapAttrsToList
        (lversion: gversions:
          lib.mapAttrs'
            (gversion: lock:
              lib.nameValuePair
                "legacy-fabric-${escapeVersion gversion}-${escapeVersion lversion}"
                (callPackage ./server.nix { inherit lock; minecraft-server = vanillaServers."vanilla-${escapeVersion gversion}"; }))
            gversions)
        versions);
in
lib.recurseIntoAttrs (
  packages
  // (
    (lib.mapAttrs'
      (n: v: lib.nameValuePair "legacy-fabric-${lib.removePrefix "vanilla-" n}" v)
      (lib.genAttrs
        (builtins.filter
          (n: (lib.hasPrefix "vanilla-" n) && (builtins.hasAttr "legacy-fabric-${removeVanilla n}-${latestVersion}" packages))
          (builtins.attrNames vanillaServers))
        (gversion: builtins.getAttr "legacy-fabric-${removeVanilla gversion}-${latestVersion}" packages)))
  )
)
