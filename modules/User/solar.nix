{
  xdg.configFile."solaar/rules.yaml".text = ''
    %YAML 1.3
    ---
    - MouseGesture: Mouse Right
    - Execute: [hyprctl, dispatch, 'hl.dsp.focus({ workspace = "m+1" })']
    ...
    ---
    - MouseGesture: Mouse Left
    - Execute: [hyprctl, dispatch, 'hl.dsp.focus({ workspace = "m-1" })']
    ...
  '';
}
