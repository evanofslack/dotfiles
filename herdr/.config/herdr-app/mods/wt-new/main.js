// wt-new: a key (mod.open:wt-new) for the shipped worktree mod's "New worktree" dialog,
// for the focused space and folder. Opens as an invisible popup, hands off, closes.
import { View, div } from "gpui-kit";
import { closeOverlay, focused, openOverlay, props } from "herdr";

const EXTRA = {};

export default class WtNew extends View {
  init(_props, cx) {
    cx.spawn(async () => {
      const { overlay } = props() ?? {};
      const f = focused();
      closeOverlay(overlay);
      openOverlay({ mod: "worktree", kind: "dialog", width: 460, height: 280,
        props: { space: f?.space, folder: f?.cwd ?? undefined, action: "new", ...EXTRA } });
    });
  }
  render() { return div(); }
}
