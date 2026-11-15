{ pkgs, ... }:
let c = import ./colorthemes.nix; in
{
  services.swayosd = {
    enable = true;
    topMargin = 0.9;   # vertical position: 0 = top, 1 = bottom

    stylePath = pkgs.writeText "swayosd.css" ''
      window#osd {
        border-radius: 999px;
        border: 2px solid #${c.accent};
        background: alpha(#${c.base}, 0.9);
      }
      window#osd #container {
        margin: 16px;
      }
      window#osd image,
      window#osd label {
        color: #${c.text};
      }
      window#osd progressbar,
      window#osd trough,
      window#osd progress {
        min-height: 6px;
        border-radius: 999px;
        border: none;
      }
      window#osd trough {
        background: #${c.surface};
      }
      window#osd progress {
        background: #${c.accent};
      }
    '';
  };
}
