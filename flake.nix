{
  description = ''Provides access to the rdrand and rdseed instructions. Based on Intel's DRNG Library (libdrng)'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."drng-main".dir   = "main";
  inputs."drng-main".owner = "nim-nix-pkgs";
  inputs."drng-main".ref   = "master";
  inputs."drng-main".repo  = "drng";
  inputs."drng-main".type  = "github";
  inputs."drng-main".inputs.nixpkgs.follows = "nixpkgs";
  inputs."drng-main".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}