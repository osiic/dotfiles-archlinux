import QtQuick
import Quickshell
import qs.Services

Item {
    id: root

    property var pluginService: null
    property string trigger: ""

    signal itemsChanged()

    function getItems(query) {
        if (!query || query.trim().length === 0) {
            return [];
        }

        const trimmed = query.trim();
        const results = [];

        // 1. Run in Terminal (if starts with >, $, or raw command)
        let cmd = "";
        if (trimmed.startsWith(">") || trimmed.startsWith("$")) {
            cmd = trimmed.substring(1).trim();
        }

        if (cmd.length > 0) {
            results.push({
                name: "Run in Terminal: " + cmd,
                icon: "material:terminal",
                comment: "Execute command in Ghostty",
                action: "exec:" + cmd,
                categories: ["QuickLauncher"]
            });
        }

        // 2. Calculator
        try {
            if (/^[0-9+\-*/().\s^%]+$/.test(trimmed) && /[0-9]/.test(trimmed) && /[+\-*/^%]/.test(trimmed)) {
                let sanitized = trimmed.replace(/\^/g, "**");
                let calcResult = Function('"use strict"; return (' + sanitized + ')')();
                if (calcResult !== undefined && !isNaN(calcResult)) {
                    results.push({
                        name: String(calcResult),
                        icon: "material:calculate",
                        comment: "= " + sanitized + " (Copy to clipboard)",
                        action: "copy:" + String(calcResult),
                        categories: ["QuickLauncher"]
                    });
                }
            }
        } catch (e) {}

        // 3. Option to run whatever typed as command if not prefixed
        if (!cmd && trimmed.length > 0) {
            results.push({
                name: "Run Command: " + trimmed,
                icon: "material:terminal",
                comment: "Execute in Ghostty terminal",
                action: "exec:" + trimmed,
                categories: ["QuickLauncher"]
            });
        }

        // 4. Web Search Edge
        results.push({
            name: "Search Edge: \"" + trimmed + "\"",
            icon: "material:travel_explore",
            comment: "Search with Microsoft Edge",
            action: "search:" + trimmed,
            categories: ["QuickLauncher"]
        });

        return results;
    }

    function executeItem(item) {
        const parts = item.action.split(":");
        const actionType = parts[0];
        const actionData = parts.slice(1).join(":");

        if (actionType === "copy") {
            Quickshell.execDetached(["dms", "cl", "copy", actionData]);
            if (typeof ToastService !== "undefined") {
                ToastService.showInfo("Calculator", "Copied " + actionData + " to clipboard");
            }
        } else if (actionType === "search") {
            const url = "https://www.bing.com/search?q=" + encodeURIComponent(actionData);
            Quickshell.execDetached(["microsoft-edge-stable", url]);
        } else if (actionType === "exec") {
            Quickshell.execDetached(["ghostty", "-e", "zsh", "-ic", actionData + "; exec zsh"]);
        }
    }

    Component.onCompleted: {
        if (pluginService) {
            trigger = pluginService.loadPluginData("quickLauncher", "trigger", "");
        }
    }
}
