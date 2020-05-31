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

  buildInputs = with pkgs; [
    pkgs.pkg-config
    pkgs.alsaLib.dev
    pkgs.xlibsWrapper
    pkgs.xorg.libxcb.dev
    pkgs.python3
    pkgs.cmake
    pkgs.openssl
    # Rust, Cargo from nightly channel
    rust-nightly-channel.rust
    rust-nightly-channel.cargo
  ];
}
