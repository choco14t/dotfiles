import { View, div } from "gpui-kit";
import { closeOverlay, focused, openOverlay, panes, props, run, theme } from "herdr";

const commands = {
  "?": ["app.help"],
  "shift-/": ["app.help"],
  s: ["app.settings"],
  q: ["window.close"],
  w: ["mod.open", { name: "picker" }],
  g: ["mod.open", { name: "picker" }],
  "shift-w": ["mod.open", { name: "picker" }],
  "shift-n": ["space.new"],
  "shift-d": ["space.close"],
  c: ["tab.new"],
  "shift-t": ["tab.rename"],
  p: ["tab.prev"],
  n: ["tab.next"],
  "shift-x": ["tab.close"],
  h: ["pane.go", { direction: "left" }],
  j: ["pane.go", { direction: "down" }],
  k: ["pane.go", { direction: "up" }],
  l: ["pane.go", { direction: "right" }],
  v: ["pane.split", { direction: "right" }],
  "-": ["pane.split", { direction: "down" }],
  x: ["pane.close"],
  z: ["pane.zoom"],
  b: ["layout.toggle", { id: "sidebar" }],
  "shift-b": ["layout.toggle", { id: "panel" }],
  "alt-g": ["terminal.open", { argv: ["lazygit"], place: "right" }],
};

export default class Prefix extends View {
  init(_props, cx) {
    this.handle = cx.focus_handle();
    this.handle.focus();
  }

  key(event, cx) {
    cx.stop_propagation();
    closeOverlay(props().overlay);
    const key = event.keystroke;
    if (key === "shift-g") {
      openOverlay({ mod: "worktree", kind: "dialog", width: 640,
        props: { space: focused()?.space, action: "new" } });
    } else if (key === "tab" || key === "shift-tab") {
      const focus = focused();
      const list = panes().filter(p => p.tab === focus?.tab);
      const at = list.findIndex(p => p.pane === focus?.pane);
      if (at < 0) return;
      const step = key === "tab" ? 1 : -1;
      run("pane.focus", { pane: list[(at + step + list.length) % list.length].pane });
    } else if (/^[1-9]$/.test(key)) {
      run("tab.select", { index: Number(key) });
    } else {
      const action = commands[key] ?? commands[event.key_char];
      if (action) run(...action);
    }
  }

  render() {
    const t = theme();
    return div().id("prefix").p(18).bg(t.surface).text_color(t.foreground)
      .track_focus(this.handle).on_key_down((event, cx) => this.key(event, cx))
      .children([
        div().text_color(t.accent).child("Ctrl+K · Prefix"),
        div().mt(10).child("h j k l: Focus pane   ·   v / −: Split   ·   x: Close"),
        div().mt(8).child("c: New tab   ·   p / n / 1–9: Switch tab   ·   z: Zoom"),
        div().mt(8).child("w / W: Picker   ·   N: New space   ·   D: Close space"),
        div().mt(8).child("Alt+g: Lazygit   ·   b: Left   ·   B: Right   ·   s: Settings"),
        div().mt(8).text_color(t.muted).child("Esc: Cancel   ·   ?: Help   ·   q: Close window"),
      ]);
  }
}
