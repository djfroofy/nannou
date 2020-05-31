{ sources ? import ./nix/sources.nix
, pkgs ? import sources.nixpkgs {}
}:
let
  rust = import ./nix/rust.nix { inherit sources; };
  naersk = pkgs.callPackage sources.naersk {
    rustc = rust.rust;
    cargo = rust.rust;
  };
  filterTarget = path: type: type != "directory" || builtins.baseNameOf path != "target";
in naersk.buildPackage {
  src = with pkgs.lib; cleanSourceWith {
    src = cleanSource ./.;
    filter = filterTarget;
  };
  nativeBuildInputs = with pkgs; [
    pkgconfig
    cmake
  ];
  buildInputs = with pkgs; [
    alsaLib.dev
    xlibsWrapper
    xorg.libxcb.dev
    python3
    openssl
  ];
  remapPathPrefix = true;
}
