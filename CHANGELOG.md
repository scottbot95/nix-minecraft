# CHANGELOG

Documentation of major changes, newest first.

## 2023-05-13: Removal of attrsets from `packages`.

As per the previous deprecation notice, all of the attrsets in `packages` have been removed, and are instead available under `legacyPackages`.

## 2023-04-05: Deprecation/Move of attrsets from `packages` to `legacyPackages`

The Nix flake CLI does not support attrsets of packages in the `packages` flake output.
Everything under `packages` is now exposed under `legacyPackages` with no changes.
They are still available under `packages` for now, for a deprecation period.

## 2023-04-05: Removal of `fetchModrinthMod` and `nix-prefetch-modrinth`

As per the previous deprecation notice, `fetchModrinthMod` and `nix-prefetch-modrinth` have been removed.

## 2023-02-27: Deprecation of `fetchModrinthMod` and `nix-prefetch-modrinth`

`fetchModrinthMod` and `nix-prefetch-modrinth` have been kinda just... bad from the beginning.
The ergonomics were good, however in terms of nix evaluation, it was highly inefficient, requiring extra fetches to the Modrinth API before ending up doing nothing since the file was already there.

In order to fill the gap, I've added a new tool titled `nix-modrinth-prefetch` (in order to make it name-distinct from `nix-prefetch-modrinth` while it is deprecated).
`nix-modrinth-prefetch` takes in a version ID from Modrinth and outputs the `fetchurl` invocation required to download the primary file.
