{
  sources ? import ./nix/sources.nix,
  pkgs ? import sources.nixpkgs {},
  rust-nightly-channel ? import ./nix/rust.nix {}
}:
let
  rust = rust-nightly-channel.rust;
  cargo = rust-nightly-channel.cargo;
in
pkgs.mkShell {

  RUST_SRC_PATH = "${rust}/lib/rustlib/rust/src";
  CARGO_INSTALL_ROOT = "${toString ./.}/.cargo";
  RUST_BACKTRACE = "full";

  buildInputs = [
    pkgs.pkg-config
    pkgs.alsaLib.dev
    pkgs.xlibsWrapper
    pkgs.python3
    pkgs.cmake
    pkgs.openssl

    #pkgs.vulkan-tools
    #pkgs.vulkan-headers
    #pkgs.vulkan-loader
    #pkgs.vulkan-validation-layers

    pkgs.xorg.libxcb
    pkgs.xorg.libXcursor
    pkgs.xorg.libXi
    pkgs.xorg.libXrandr

    # Rust, Cargo from nightly channel
    rust
    cargo
  ];
}
