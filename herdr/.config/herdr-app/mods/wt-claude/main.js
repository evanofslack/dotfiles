// wt-claude: like wt-new, but the new worktree space opens with a tab running Claude
// (the worktree mod passes tab/argv to space.new).
import { View, div } from "gpui-kit";
import { closeOverlay, focused, openOverlay, props } from "herdr";

const EXTRA = { tab: "claude", argv: ["claude"] };

export default class WtClaude extends View {
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
