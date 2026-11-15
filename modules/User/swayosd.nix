{ pkgs, ... }:
let c = import ./colorthemes.nix; in
{
  services.swayosd = {
    enable = true;
    topMargin = 0.9;   # vertical position: 0 = top, 1 = bottom

    stylePath = pkgs.writeText "swayosd.css" ''
      window#osd {
        border-radius: 6px;                       /* small corners instead of a pill */
        border: 1px solid #${c.accent};
        background: alpha(#${c.base}, 0.95);
      }
      window#osd #container {
        margin: 6px 10px;                         /* inner padding: 6px top/bottom, 10px left/right */
      }
      window#osd image {
        -gtk-icon-size: 16px;                     /* smaller speaker icon */
        color: #${c.text};
      }
      window#osd label {
        font-size: 11px;
        color: #${c.text};
      }
      window#osd progressbar {
        min-width: 140px;                         /* length of the bar */
      }
      window#osd progressbar,
      window#osd trough,
      window#osd progress {
        min-height: 4px;                          /* thinner bar */
        border-radius: 1px;
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
