"use strict";
var UserInput;
(function (UserInput) {
    UserInput[UserInput["Left"] = 0] = "Left";
    UserInput[UserInput["Right"] = 1] = "Right";
    UserInput[UserInput["Up"] = 2] = "Up";
    UserInput[UserInput["Down"] = 3] = "Down";
    UserInput[UserInput["ShiftLeft"] = 4] = "ShiftLeft";
    UserInput[UserInput["ShiftRight"] = 5] = "ShiftRight";
    UserInput[UserInput["ShiftUp"] = 6] = "ShiftUp";
    UserInput[UserInput["ShiftDown"] = 7] = "ShiftDown";
    UserInput[UserInput["Increase"] = 8] = "Increase";
    UserInput[UserInput["Decrease"] = 9] = "Decrease";
    UserInput[UserInput["Float"] = 10] = "Float";
    UserInput[UserInput["SetMaster"] = 11] = "SetMaster";
    UserInput[UserInput["CycleLayout"] = 12] = "CycleLayout";
    UserInput[UserInput["SetLayout"] = 13] = "SetLayout";
})(UserInput || (UserInput = {}));
var WindowState;
(function (WindowState) {
    WindowState[WindowState["Tile"] = 0] = "Tile";
    WindowState[WindowState["FreeTile"] = 1] = "FreeTile";
    WindowState[WindowState["Float"] = 2] = "Float";
    WindowState[WindowState["FullScreen"] = 3] = "FullScreen";
    WindowState[WindowState["Unmanaged"] = 4] = "Unmanaged";
})(WindowState || (WindowState = {}));
var CONFIG;
var KWinConfig = (function () {
    function KWinConfig() {
        function commaSeparate(str) {
            if (!str || typeof str !== "string")
                return [];
            return str.split(",").map(function (part) { return part.trim(); });
        }
        DEBUG.enabled = DEBUG.enabled || KWin.readConfig("debug", false);
        this.enableMonocleLayout = KWin.readConfig("enableMonocleLayout", true);
        this.enableQuarterLayout = KWin.readConfig("enableQuarterLayout", false);
        this.enableSpreadLayout = KWin.readConfig("enableSpreadLayout", true);
        this.enableStairLayout = KWin.readConfig("enableStairLayout", true);
        this.enableTileLayout = KWin.readConfig("enableTileLayout", true);
        this.maximizeSoleTile = KWin.readConfig("maximizeSoleTile", false);
        this.monocleMaximize = KWin.readConfig("monocleMaximize", true);
        this.adjustLayout = KWin.readConfig("adjustLayout", true);
        this.adjustLayoutLive = KWin.readConfig("adjustLayoutLive", true);
        this.noTileBorder = KWin.readConfig("noTileBorder", false);
        this.screenGapBottom = KWin.readConfig("screenGapBottom", 0);
        this.screenGapLeft = KWin.readConfig("screenGapLeft", 0);
        this.screenGapRight = KWin.readConfig("screenGapRight", 0);
        this.screenGapTop = KWin.readConfig("screenGapTop", 0);
        this.tileLayoutGap = KWin.readConfig("tileLayoutGap", 0);
        this.layoutPerActivity = KWin.readConfig("layoutPerActivity", false);
        this.layoutPerDesktop = KWin.readConfig("layoutPerDesktop", false);
        this.floatUtility = KWin.readConfig("floatUtility", true);
        this.preventMinimize = KWin.readConfig("preventMinimize", false);
        this.floatingClass = commaSeparate(KWin.readConfig("floatingClass", ""));
        this.floatingTitle = commaSeparate(KWin.readConfig("floatingTitle", ""));
        this.ignoreActivity = commaSeparate(KWin.readConfig("ignoreActivity", ""));
        this.ignoreClass = commaSeparate(KWin.readConfig("ignoreClass", "krunner,yakuake,spectacle,kded5"));
        this.ignoreScreen = commaSeparate(KWin.readConfig("ignoreScreen", ""))
            .map(function (str) { return parseInt(str, 10); });
        this.ignoreTitle = commaSeparate(KWin.readConfig("ignoreTitle", ""));
    }
    KWinConfig.prototype.toString = function () {
        return "Config(" + JSON.stringify(this, undefined, 2) + ")";
    };
    return KWinConfig;
}());
var KWINCONFIG;
var KWinContext = (function () {
    function KWinContext(screen, activity, desktop) {
        this.screen = screen;
        this.activity = activity;
        this.desktop = desktop;
        this._path = null;
    }
    Object.defineProperty(KWinContext.prototype, "id", {
        get: function () {
            if (!this._path) {
                this._path = String(this.screen);
                if (KWINCONFIG.layoutPerActivity)
                    this._path += "@" + this.activity;
                if (KWINCONFIG.layoutPerDesktop)
                    this._path += "#" + this.desktop;
            }
            return this._path;
        },
        enumerable: true,
        configurable: true
    });
    Object.defineProperty(KWinContext.prototype, "ignore", {
        get: function () {
            var activityName = activityInfo.activityName(this.activity);
            return ((KWINCONFIG.ignoreActivity.indexOf(activityName) >= 0)
                || (KWINCONFIG.ignoreScreen.indexOf(this.screen) >= 0));
        },
        enumerable: true,
        configurable: true
    });
    KWinContext.prototype.toString = function () {
        return "KWinCtx(" + [this.screen, activityInfo.activityName(this.activity), this.desktop].join(", ") + ")";
    };
    return KWinContext;
}());
var KWinDriver = (function () {
    function KWinDriver() {
        this.engine = new TilingEngine(this);
        this.control = new TilingController(this.engine);
        this.windowMap = {};
        this.timerPool = Array();
    }
    KWinDriver.prototype.main = function () {
        CONFIG = KWINCONFIG = new KWinConfig();
        debug(function () { return "Config: " + KWINCONFIG; });
        this.bindEvents();
        this.bindShortcut();
        var clients = workspace.clientList();
        for (var i = 0; i < clients.length; i++) {
            var window = this.registerWindow(clients[i]);
            this.engine.manage(window);
            if (window.state !== WindowState.Unmanaged)
                this.bindWindowEvents(window, clients[i]);
            else
                this.unregisterWindow(window);
        }
        this.engine.arrange();
    };
    KWinDriver.prototype.forEachScreen = function (func) {
        for (var screen = 0; screen < workspace.numScreens; screen++)
            func(new KWinContext(screen, workspace.currentActivity, workspace.currentDesktop));
    };
    KWinDriver.prototype.getCurrentContext = function () {
        return new KWinContext((workspace.activeClient) ? workspace.activeClient.screen : 0, workspace.currentActivity, workspace.currentDesktop);
    };
    KWinDriver.prototype.getCurrentWindow = function () {
        var client = workspace.activeClient;
        if (!client)
            return null;
        return this.queryWindow(client);
    };
    KWinDriver.prototype.getWorkingArea = function (ctx) {
        var kctx = ctx;
        return toRect(workspace.clientArea(KWin.PlacementArea, kctx.screen, workspace.currentDesktop));
    };
    KWinDriver.prototype.setCurrentWindow = function (window) {
        var kwindow = window.window;
        workspace.activeClient = kwindow.client;
    };
    KWinDriver.prototype.bindShortcut = function () {
        var _this = this;
        if (!KWin.registerShortcut)
            return;
        var bind = function (seq, title, input) {
            title = "Krohnkite: " + title;
            seq = "Meta+" + seq;
            var cb = function () { _this.engine.handleUserInput(input); };
            KWin.registerShortcut(title, "", seq, cb);
        };
        bind("J", "Down/Next", UserInput.Down);
        bind("K", "Up/Prev", UserInput.Up);
        bind("H", "Left", UserInput.Left);
        bind("L", "Right", UserInput.Right);
        bind("Shift+J", "Move Down/Next", UserInput.ShiftDown);
        bind("Shift+K", "Move Up/Prev", UserInput.ShiftUp);
        bind("Shift+H", "Move Left", UserInput.ShiftLeft);
        bind("Shift+L", "Move Right", UserInput.ShiftRight);
        bind("I", "Increase", UserInput.Increase);
        bind("D", "Decrease", UserInput.Decrease);
        bind("F", "Float", UserInput.Float);
        bind("\\", "Cycle Layout", UserInput.CycleLayout);
        bind("Return", "Set master", UserInput.SetMaster);
        KWin.registerShortcut("Krohnkite: Tile Layout", "", "Meta+T", function () {
            _this.engine.handleUserInput(UserInput.SetLayout, TileLayout);
        });
        KWin.registerShortcut("Krohnkite: Monocle Layout", "", "Meta+M", function () {
            _this.engine.handleUserInput(UserInput.SetLayout, MonocleLayout);
        });
        KWin.registerShortcut("Krohnkite: Spread Layout", "", "", function () {
            _this.engine.handleUserInput(UserInput.SetLayout, SpreadLayout);
        });
        KWin.registerShortcut("Krohnkite: Stair Layout", "", "", function () {
            _this.engine.handleUserInput(UserInput.SetLayout, StairLayout);
        });
    };
    KWinDriver.prototype.connect = function (signal, handler) {
        var _this = this;
        var wrapper = function () {
            var args = [];
            for (var _i = 0; _i < arguments.length; _i++) {
                args[_i] = arguments[_i];
            }
            var enabled = false;
            try {
                enabled = !!workspace;
            }
            catch (e) { }
            if (enabled)
                handler.apply(_this, args);
            else
                signal.disconnect(wrapper);
        };
        signal.connect(wrapper);
    };
    KWinDriver.prototype.registerWindow = function (client) {
        var window = new Window(new KWinWindow(client));
        var key = window.id;
        debugObj(function () { return ["registerWindow", { key: key, client: client }]; });
        return (this.windowMap[key] = window);
    };
    KWinDriver.prototype.queryWindow = function (client) {
        var key = KWinWindow.generateID(client);
        return this.windowMap[key] || null;
    };
    KWinDriver.prototype.unregisterWindow = function (window) {
        var key = window.id;
        debugObj(function () { return ["removeTile", { key: key }]; });
        delete this.windowMap[key];
    };
    KWinDriver.prototype.bindEvents = function () {
        var _this = this;
        this.connect(workspace.numberScreensChanged, function (count) {
            return _this.control.onScreenCountChanged(count);
        });
        this.connect(workspace.screenResized, function (screen) {
            return _this.control.onScreenResized(new KWinContext(screen, workspace.currentActivity, workspace.currentDesktop));
        });
        this.connect(workspace.currentActivityChanged, function (activity) {
            return _this.control.onCurrentContextChanged(_this.getCurrentContext());
        });
        this.connect(workspace.currentDesktopChanged, function (desktop, client) {
            return _this.control.onCurrentContextChanged(_this.getCurrentContext());
        });
        this.connect(workspace.clientAdded, function (client) {
            var handler = function () {
                var window = _this.registerWindow(client);
                _this.control.onWindowAdded(window);
                if (window.state !== WindowState.Unmanaged)
                    _this.bindWindowEvents(window, client);
                else
                    _this.unregisterWindow(window);
                client.windowShown.disconnect(handler);
            };
            client.windowShown.connect(handler);
        });
        this.connect(workspace.clientRemoved, function (client) {
            var window = _this.queryWindow(client);
            if (window) {
                _this.control.onWindowRemoved(window);
                _this.unregisterWindow(window);
            }
        });
        this.connect(workspace.clientFullScreenSet, function (client, fullScreen, user) {
            return _this.control.onWindowChanged(_this.queryWindow(client), "fullscreen=" + fullScreen + " user=" + user);
        });
        this.connect(workspace.clientMinimized, function (client) {
            if (KWINCONFIG.preventMinimize) {
                client.minimized = false;
                workspace.activeClient = client;
            }
            else
                _this.control.onWindowChanged(_this.queryWindow(client), "minimized");
        });
        this.connect(workspace.clientUnminimized, function (client) {
            return _this.control.onWindowChanged(_this.queryWindow(client), "unminimized");
        });
    };
    KWinDriver.prototype.bindWindowEvents = function (window, client) {
        var _this = this;
        var moving = false;
        var resizing = false;
        this.connect(client.moveResizedChanged, function () {
            debugObj(function () { return ["moveResizedChanged", { window: window, move: client.move, resize: client.resize }]; });
            if (moving !== client.move) {
                moving = client.move;
                if (moving)
                    _this.control.onWindowMoveStart(window);
                else
                    _this.control.onWindowMoveOver(window);
            }
            if (resizing !== client.resize) {
                resizing = client.resize;
                if (resizing)
                    _this.control.onWindowResizeStart(window);
                else
                    _this.control.onWindowResizeOver(window);
            }
        });
        this.connect(client.geometryChanged, function () {
            if (moving)
                _this.control.onWindowMove(window);
            else if (resizing)
                _this.control.onWindowResize(window);
            else {
                if (!window.actualGeometry.equals(window.geometry))
                    _this.control.onWindowGeometryChanged(window);
            }
        });
        this.connect(client.screenChanged, function () {
            return _this.control.onWindowChanged(window, "screen=" + client.screen);
        });
        this.connect(client.activitiesChanged, function () {
            return _this.control.onWindowChanged(window, "activity=" + client.activities.join(","));
        });
        this.connect(client.desktopChanged, function () {
            return _this.control.onWindowChanged(window, "desktop=" + client.desktop);
        });
    };
    return KWinDriver;
}());
var KWinTimerPool = (function () {
    function KWinTimerPool() {
        this.timers = [];
    }
    KWinTimerPool.prototype.setTimeout = function (func, timeout) {
        var _this = this;
        var timer = this.timers.pop() ||
            Qt.createQmlObject("import QtQuick 2.0; Timer {}", scriptRoot);
        var callback = function () {
            try {
                timer.triggered.disconnect(callback);
            }
            catch (e) { }
            try {
                func();
            }
            catch (e) { }
            _this.timers.push(timer);
            debugObj(function () { return ["setTimeout/callback", { poolSize: _this.timers.length }]; });
        };
        timer.interval = timeout;
        timer.repeat = false;
        timer.triggered.connect(callback);
        timer.start();
    };
    KWinTimerPool.instance = new KWinTimerPool();
    return KWinTimerPool;
}());
function KWinSetTimeout(func, timeout) {
    KWinTimerPool.instance.setTimeout(func, timeout);
}
var KWinWindow = (function () {
    function KWinWindow(client) {
        this.client = client;
        this.id = KWinWindow.generateID(client);
        this._bakNoBorder = client.noBorder;
    }
    KWinWindow.generateID = function (client) {
        return String(client) + "/" + client.windowId;
    };
    Object.defineProperty(KWinWindow.prototype, "context", {
        get: function () {
            var activity;
            if (this.client.activities.length === 0)
                activity = workspace.currentActivity;
            else if (this.client.activities.indexOf(workspace.currentActivity) >= 0)
                activity = workspace.currentActivity;
            else
                activity = this.client.activities[0];
            var desktop = (this.client.desktop >= 0)
                ? this.client.desktop
                : workspace.currentDesktop;
            return new KWinContext(this.client.screen, activity, desktop);
        },
        enumerable: true,
        configurable: true
    });
    Object.defineProperty(KWinWindow.prototype, "fullScreen", {
        get: function () {
            return this.client.fullScreen;
        },
        enumerable: true,
        configurable: true
    });
    Object.defineProperty(KWinWindow.prototype, "geometry", {
        get: function () {
            return toRect(this.client.geometry);
        },
        enumerable: true,
        configurable: true
    });
    KWinWindow.prototype.commit = function (geometry, noBorder, keepBelow) {
        if (this.client.move || this.client.resize)
            return;
        if (noBorder !== undefined)
            this.client.noBorder = noBorder || this._bakNoBorder;
        if (keepBelow !== undefined)
            this.client.keepBelow = keepBelow;
        if (geometry !== undefined)
            this.client.geometry = toQRect(this.adjustGeometry(geometry));
    };
    KWinWindow.prototype.shouldIgnore = function () {
        var resourceClass = String(this.client.resourceClass);
        return (this.client.specialWindow
            || resourceClass === "plasmashell"
            || (KWINCONFIG.ignoreClass.indexOf(resourceClass) >= 0)
            || (matchWords(this.client.caption, KWINCONFIG.ignoreTitle) >= 0));
    };
    KWinWindow.prototype.shouldFloat = function () {
        var resourceClass = String(this.client.resourceClass);
        return (this.client.modal
            || (!this.client.resizeable)
            || (KWINCONFIG.floatUtility
                && (this.client.dialog || this.client.splash || this.client.utility))
            || (KWINCONFIG.floatingClass.indexOf(resourceClass) >= 0)
            || (matchWords(this.client.caption, KWINCONFIG.floatingTitle) >= 0));
    };
    KWinWindow.prototype.toString = function () {
        return "KWin(" + this.client.windowId.toString(16) + "." + this.client.resourceClass + ")";
    };
    KWinWindow.prototype.visible = function (ctx) {
        var kctx = ctx;
        return ((!this.client.minimized)
            && (this.client.desktop === kctx.desktop
                || this.client.desktop === -1)
            && (this.client.activities.length === 0
                || this.client.activities.indexOf(kctx.activity) !== -1)
            && (this.client.screen === kctx.screen));
    };
    KWinWindow.prototype.adjustGeometry = function (geometry) {
        var _a;
        var width = geometry.width;
        var height = geometry.height;
        if (!this.client.resizeable) {
            width = this.client.geometry.width;
            height = this.client.geometry.height;
        }
        else {
            if (!(this.client.basicUnit.width === 1 && this.client.basicUnit.height === 1))
                _a = this.applyResizeIncrement(geometry), width = _a[0], height = _a[1];
            width = clip(width, this.client.minSize.width, this.client.maxSize.width);
            height = clip(height, this.client.minSize.height, this.client.maxSize.height);
        }
        return new Rect(geometry.x, geometry.y, width, height);
    };
    KWinWindow.prototype.applyResizeIncrement = function (geom) {
        var unit = this.client.basicUnit;
        var base = this.client.minSize;
        var padWidth = this.client.geometry.width - this.client.clientSize.width;
        var padHeight = this.client.geometry.height - this.client.clientSize.height;
        var quotWidth = Math.floor((geom.width - base.width - padWidth) / unit.width);
        var quotHeight = Math.floor((geom.height - base.height - padHeight) / unit.height);
        var newWidth = base.width + unit.width * quotWidth + padWidth;
        var newHeight = base.height + unit.height * quotHeight + padHeight;
        debugObj(function () { return ["applyResizeIncrement", {
                unit: unit, base: base, geom: geom,
                pad: [padWidth, padHeight].join("x"),
                size: [newWidth, newHeight].join("x"),
            }]; });
        return [newWidth, newHeight];
    };
    return KWinWindow;
}());
var TilingController = (function () {
    function TilingController(engine) {
        this.engine = engine;
    }
    TilingController.prototype.onScreenCountChanged = function (count) {
        debugObj(function () { return ["onScreenCountChanged", { count: count }]; });
        this.engine.arrange();
    };
    TilingController.prototype.onScreenResized = function (ctx) {
        debugObj(function () { return ["onScreenResized", { ctx: ctx }]; });
        this.engine.arrangeScreen(ctx);
    };
    TilingController.prototype.onCurrentContextChanged = function (ctx) {
        debugObj(function () { return ["onCurrentContextChanged", { ctx: ctx }]; });
        this.engine.arrange();
    };
    TilingController.prototype.onWindowAdded = function (window) {
        debugObj(function () { return ["onWindowAdded", { window: window }]; });
        this.engine.manage(window);
        this.engine.arrange();
    };
    TilingController.prototype.onWindowRemoved = function (window) {
        debugObj(function () { return ["onWindowRemoved", { window: window }]; });
        this.engine.unmanage(window);
        this.engine.arrange();
    };
    TilingController.prototype.onWindowMoveStart = function (window) {
    };
    TilingController.prototype.onWindowMove = function (window) {
    };
    TilingController.prototype.onWindowMoveOver = function (window) {
        debugObj(function () { return ["onWindowMoveOver", { window: window }]; });
        if (window.state === WindowState.Tile) {
            var diff = window.actualGeometry.subtract(window.geometry);
            var distance = Math.sqrt(Math.pow(diff.x, 2) + Math.pow(diff.y, 2));
            if (distance > 30) {
                window.floatGeometry = window.actualGeometry;
                window.state = WindowState.Float;
                this.engine.arrange();
            }
            else
                window.commit();
        }
    };
    TilingController.prototype.onWindowResizeStart = function (window) {
    };
    TilingController.prototype.onWindowResize = function (window) {
        debugObj(function () { return ["onWindowResizeOver", { window: window }]; });
        if (CONFIG.adjustLayout && CONFIG.adjustLayoutLive) {
            if (window.state === WindowState.Tile) {
                this.engine.adjustLayout(window);
                this.engine.arrange();
            }
        }
    };
    TilingController.prototype.onWindowResizeOver = function (window) {
        debugObj(function () { return ["onWindowResizeOver", { window: window }]; });
        if (CONFIG.adjustLayout && window.state === WindowState.Tile) {
            this.engine.adjustLayout(window);
            this.engine.arrange();
        }
        else if (!CONFIG.adjustLayout)
            this.engine.enforceSize(window);
    };
    TilingController.prototype.onWindowGeometryChanged = function (window) {
        debugObj(function () { return ["onWindowGeometryChanged", { window: window }]; });
        this.engine.enforceSize(window);
    };
    TilingController.prototype.onWindowChanged = function (window, comment) {
        if (window) {
            debugObj(function () { return ["onWindowChanged", { window: window, comment: comment }]; });
            this.engine.arrange();
        }
    };
    return TilingController;
}());
var TilingEngine = (function () {
    function TilingEngine(driver) {
        this.driver = driver;
        this.layouts = new LayoutStore();
        this.windows = Array();
    }
    TilingEngine.prototype.adjustLayout = function (basis) {
        var ctx = basis.context;
        var layout = this.layouts.getCurrentLayout(ctx);
        if (layout.adjust) {
            var fullArea = this.driver.getWorkingArea(ctx);
            var area = new Rect(fullArea.x + CONFIG.screenGapLeft, fullArea.y + CONFIG.screenGapTop, fullArea.width - (CONFIG.screenGapLeft + CONFIG.screenGapRight), fullArea.height - (CONFIG.screenGapTop + CONFIG.screenGapBottom));
            var tiles = this.windows.filter(function (win) {
                return (win.state === WindowState.Tile) && win.visible(ctx);
            });
            layout.adjust(area, tiles, basis);
        }
    };
    TilingEngine.prototype.arrange = function () {
        var _this = this;
        debug(function () { return "arrange"; });
        this.driver.forEachScreen(function (ctx) {
            _this.arrangeScreen(ctx);
        });
    };
    TilingEngine.prototype.arrangeScreen = function (ctx) {
        var layout = this.layouts.getCurrentLayout(ctx);
        var fullArea = this.driver.getWorkingArea(ctx);
        var workingArea = new Rect(fullArea.x + CONFIG.screenGapLeft, fullArea.y + CONFIG.screenGapTop, fullArea.width - (CONFIG.screenGapLeft + CONFIG.screenGapRight), fullArea.height - (CONFIG.screenGapTop + CONFIG.screenGapBottom));
        var visibles = this.windows.filter(function (win) { return win.visible(ctx); });
        var tiles = visibles.filter(function (win) { return win.tileable; });
        debugObj(function () { return ["arrangeScreen", {
                ctx: ctx, layout: layout,
                tiles: tiles.length,
                visibles: visibles.length,
            }]; });
        visibles.forEach(function (window) {
            if (window.state === WindowState.FreeTile)
                window.state = WindowState.Tile;
            if (window.state === WindowState.Tile)
                window.noBorder = CONFIG.noTileBorder;
        });
        if (CONFIG.maximizeSoleTile && tiles.length === 1) {
            tiles[0].noBorder = true;
            tiles[0].geometry = fullArea;
        }
        else if (tiles.length > 0)
            layout.apply(tiles, workingArea, fullArea);
        visibles.forEach(function (window) { return window.commit(); });
    };
    TilingEngine.prototype.enforceSize = function (window) {
        if (window.state === WindowState.Tile && !window.actualGeometry.equals(window.geometry))
            KWinSetTimeout(function () {
                if (window.state === WindowState.Tile)
                    window.commit();
            }, 10);
    };
    TilingEngine.prototype.manage = function (window) {
        if (!window.shouldIgnore) {
            window.state = (window.shouldFloat) ? WindowState.Float : WindowState.Tile;
            this.windows.push(window);
        }
    };
    TilingEngine.prototype.unmanage = function (window) {
        var idx = this.windows.indexOf(window);
        if (idx >= 0)
            this.windows.splice(idx, 1);
    };
    TilingEngine.prototype.handleUserInput = function (input, data) {
        debugObj(function () { return ["handleUserInput", { input: UserInput[input], data: data }]; });
        var ctx = this.driver.getCurrentContext();
        var layout = this.layouts.getCurrentLayout(ctx);
        if (layout.handleUserInput) {
            var overriden = layout.handleUserInput(input, data);
            if (overriden) {
                this.arrange();
                return;
            }
        }
        var window;
        switch (input) {
            case UserInput.Up:
                this.moveFocus(-1);
                break;
            case UserInput.Down:
                this.moveFocus(+1);
                break;
            case UserInput.ShiftUp:
                this.moveTile(-1);
                break;
            case UserInput.ShiftDown:
                this.moveTile(+1);
                break;
            case UserInput.SetMaster:
                if ((window = this.driver.getCurrentWindow()))
                    this.setMaster(window);
                break;
            case UserInput.Float:
                if ((window = this.driver.getCurrentWindow()))
                    window.state = (window.state === WindowState.Float) ? WindowState.Tile : WindowState.Float;
                break;
            case UserInput.CycleLayout:
                this.cycleLayout();
                break;
            case UserInput.SetLayout:
                this.layouts.setLayout(this.driver.getCurrentContext(), data);
                break;
        }
        this.arrange();
    };
    TilingEngine.prototype.moveFocus = function (step) {
        if (step === 0)
            return;
        var window = this.driver.getCurrentWindow();
        var ctx = (window) ? window.context : this.driver.getCurrentContext();
        var visibles = this.windows.filter(function (win) { return win.visible(ctx); });
        if (visibles.length === 0)
            return;
        var idx = (window) ? visibles.indexOf(window) : -1;
        if (!window || idx < 0) {
            this.driver.setCurrentWindow(visibles[0]);
            return;
        }
        var num = visibles.length;
        var newIndex = (idx + (step % num) + num) % num;
        debugObj(function () { return ["moveFocus", { from: window, to: visibles[newIndex] }]; });
        this.driver.setCurrentWindow(visibles[newIndex]);
    };
    TilingEngine.prototype.moveTile = function (step) {
        if (step === 0)
            return;
        var srcWin = this.driver.getCurrentWindow();
        if (!srcWin)
            return;
        var ctx = srcWin.context;
        var visibles = this.windows.filter(function (win) { return win.visible(ctx); });
        if (visibles.length < 2)
            return;
        var num = visibles.length;
        var srcIdx = visibles.indexOf(srcWin);
        var destIdx = (srcIdx + (step % num) + num) % num;
        debugObj(function () { return ["moveTile", { num: num, srcIdx: srcIdx, step: step, destIdx: destIdx }]; });
        if (srcIdx === destIdx)
            return;
        var destWin = visibles[destIdx];
        debugObj(function () { return ["moveTile", { srcWin: srcWin, destWin: destWin }]; });
        var srcListIdx = this.windows.indexOf(srcWin);
        var destListIdx = this.windows.indexOf(destWin);
        this.windows[destListIdx] = srcWin;
        this.windows[srcListIdx] = destWin;
    };
    TilingEngine.prototype.setMaster = function (window) {
        if (this.windows[0] === window)
            return;
        var idx = this.windows.indexOf(window);
        if (idx < 0)
            return;
        debugObj(function () { return ["setMaster", { to: window }]; });
        this.windows.splice(idx, 1);
        this.windows.unshift(window);
    };
    TilingEngine.prototype.cycleLayout = function () {
        this.layouts.cycleLayout(this.driver.getCurrentContext());
    };
    return TilingEngine;
}());
var LayoutStoreEntry = (function () {
    function LayoutStoreEntry() {
        this.layouts = [
            new TileLayout(),
            new MonocleLayout(),
            new SpreadLayout(),
            new StairLayout(),
            new QuarterLayout(),
        ];
    }
    Object.defineProperty(LayoutStoreEntry.prototype, "currentLayout", {
        get: function () {
            if (this.layouts[0].enabled)
                return this.layouts[0];
            this.cycleLayout();
            if (this.layouts[0].enabled)
                return this.layouts[0];
            return FloatingLayout.instance;
        },
        enumerable: true,
        configurable: true
    });
    LayoutStoreEntry.prototype.cycleLayout = function () {
        var start = this.layouts[0];
        for (;;) {
            this.layouts.push(this.layouts.shift());
            if (this.layouts[0].enabled)
                break;
            if (this.layouts[0] === start)
                break;
        }
    };
    LayoutStoreEntry.prototype.setLayout = function (cls) {
        var result = this.layouts.filter(function (lo) {
            return lo.enabled && (lo instanceof cls);
        });
        if (result.length === 0)
            return;
        var layout = result[0];
        while (this.layouts[0] !== layout)
            this.layouts.push(this.layouts.shift());
    };
    return LayoutStoreEntry;
}());
var LayoutStore = (function () {
    function LayoutStore() {
        this.store = {};
    }
    LayoutStore.prototype.getCurrentLayout = function (ctx) {
        return (ctx.ignore)
            ? FloatingLayout.instance
            : this.getEntry(ctx.id).currentLayout;
    };
    LayoutStore.prototype.cycleLayout = function (ctx) {
        if (ctx.ignore)
            return;
        this.getEntry(ctx.id).cycleLayout();
    };
    LayoutStore.prototype.setLayout = function (ctx, cls) {
        if (ctx.ignore)
            return;
        this.getEntry(ctx.id).setLayout(cls);
    };
    LayoutStore.prototype.getEntry = function (key) {
        if (!this.store[key])
            this.store[key] = new LayoutStoreEntry();
        return this.store[key];
    };
    return LayoutStore;
}());
var WindowResizeDelta = (function () {
    function WindowResizeDelta(window) {
        this.diff = window.actualGeometry.subtract(window.geometry);
        this.east = this.diff.width + this.diff.x;
        this.west = -this.diff.x;
        this.south = this.diff.height + this.diff.y;
        this.north = -this.diff.y;
    }
    WindowResizeDelta.prototype.toString = function () {
        return "WindowResizeDelta(" + [
            "diff=" + this.diff,
            "east=" + this.east,
            "west=" + this.west,
            "north=" + this.north,
            "south=" + this.south,
        ].join(" ") + ")";
    };
    return WindowResizeDelta;
}());
var Window = (function () {
    function Window(window) {
        this.id = window.id;
        this.floatGeometry = window.geometry;
        this.geometry = window.geometry;
        this.noBorder = false;
        this.window = window;
        this._state = WindowState.Unmanaged;
    }
    Object.defineProperty(Window.prototype, "actualGeometry", {
        get: function () { return this.window.geometry; },
        enumerable: true,
        configurable: true
    });
    Object.defineProperty(Window.prototype, "context", {
        get: function () { return this.window.context; },
        enumerable: true,
        configurable: true
    });
    Object.defineProperty(Window.prototype, "shouldFloat", {
        get: function () { return this.window.shouldFloat(); },
        enumerable: true,
        configurable: true
    });
    Object.defineProperty(Window.prototype, "shouldIgnore", {
        get: function () { return this.window.shouldIgnore(); },
        enumerable: true,
        configurable: true
    });
    Object.defineProperty(Window.prototype, "tileable", {
        get: function () {
            return (this.state === WindowState.Tile) || (this.state === WindowState.FreeTile);
        },
        enumerable: true,
        configurable: true
    });
    Object.defineProperty(Window.prototype, "state", {
        get: function () {
            if (this.window.fullScreen)
                return WindowState.FullScreen;
            return this._state;
        },
        set: function (value) {
            if (value === WindowState.FullScreen)
                return;
            var state = this.state;
            if (state === value) {
                return;
            }
            else if (state === WindowState.Unmanaged) {
            }
            else if (state === WindowState.FullScreen) {
            }
            else if (state === WindowState.Tile && value === WindowState.Float) {
                this.window.commit(this.floatGeometry, false, false);
            }
            else if (state === WindowState.Tile && value === WindowState.FreeTile) {
                this.window.commit(this.floatGeometry, false, false);
            }
            else if (state === WindowState.Float && value === WindowState.Tile) {
                this.floatGeometry = this.actualGeometry;
            }
            else if (state === WindowState.Float && value === WindowState.FreeTile) {
            }
            else if (state === WindowState.FreeTile && value === WindowState.Tile) {
                this.floatGeometry = this.actualGeometry;
            }
            else if (state === WindowState.FreeTile && value === WindowState.Float) {
            }
            else {
                debugObj(function () { return ["Window.state/ignored", { from: state, to: value }]; });
                return;
            }
            this._state = value;
        },
        enumerable: true,
        configurable: true
    });
    Window.prototype.commit = function () {
        if (this.state === WindowState.Tile)
            this.window.commit(this.geometry, this.noBorder, true);
        else if (this.state === WindowState.FullScreen)
            this.window.commit(undefined, undefined, false);
    };
    Window.prototype.visible = function (ctx) {
        return this.window.visible(ctx);
    };
    Window.prototype.toString = function () {
        return "Window(" + String(this.window) + ")";
    };
    return Window;
}());
var FloatingLayout = (function () {
    function FloatingLayout() {
        this.apply = function (tiles, area, workingArea) {
            tiles.forEach(function (tile) {
                return tile.state = WindowState.FreeTile;
            });
        };
    }
    Object.defineProperty(FloatingLayout.prototype, "enabled", {
        get: function () {
            return true;
        },
        enumerable: true,
        configurable: true
    });
    FloatingLayout.prototype.toString = function () {
        return "FloatingLayout()";
    };
    FloatingLayout.instance = new FloatingLayout();
    return FloatingLayout;
}());
var MonocleLayout = (function () {
    function MonocleLayout() {
        this.apply = function (tiles, area, workingArea) {
            if (CONFIG.monocleMaximize) {
                area = workingArea || area;
                tiles.forEach(function (window) { return window.noBorder = true; });
            }
            tiles.forEach(function (window) { return (window.geometry = area); });
        };
    }
    Object.defineProperty(MonocleLayout.prototype, "enabled", {
        get: function () {
            return CONFIG.enableMonocleLayout;
        },
        enumerable: true,
        configurable: true
    });
    MonocleLayout.prototype.toString = function () {
        return "MonocleLayout()";
    };
    return MonocleLayout;
}());
var QuarterLayout = (function () {
    function QuarterLayout() {
        this.lhsplit = 0.5;
        this.rhsplit = 0.5;
        this.vsplit = 0.5;
    }
    Object.defineProperty(QuarterLayout.prototype, "enabled", {
        get: function () {
            return CONFIG.enableQuarterLayout;
        },
        enumerable: true,
        configurable: true
    });
    QuarterLayout.prototype.adjust = function (area, tiles, basis) {
        if (tiles.length <= 1 || tiles.length > 4)
            return;
        var idx = tiles.indexOf(basis);
        if (idx < 0)
            return;
        var delta = new WindowResizeDelta(basis);
        if ((idx === 0 || idx === 3) && delta.east !== 0)
            this.vsplit = (Math.floor(area.width * this.vsplit) + delta.east) / area.width;
        else if ((idx === 1 || idx === 2) && delta.west !== 0)
            this.vsplit = (Math.floor(area.width * this.vsplit) - delta.west) / area.width;
        if (tiles.length === 4) {
            if (idx === 0 && delta.south !== 0)
                this.lhsplit = (Math.floor(area.height * this.lhsplit) + delta.south) / area.height;
            if (idx === 3 && delta.north !== 0)
                this.lhsplit = (Math.floor(area.height * this.lhsplit) - delta.north) / area.height;
        }
        if (tiles.length >= 3) {
            if (idx === 1 && delta.south !== 0)
                this.rhsplit = (Math.floor(area.height * this.rhsplit) + delta.south) / area.height;
            if (idx === 2 && delta.north !== 0)
                this.rhsplit = (Math.floor(area.height * this.rhsplit) - delta.north) / area.height;
        }
        this.vsplit = clip(this.vsplit, 1 - QuarterLayout.MAX_PROPORTION, QuarterLayout.MAX_PROPORTION);
        this.lhsplit = clip(this.lhsplit, 1 - QuarterLayout.MAX_PROPORTION, QuarterLayout.MAX_PROPORTION);
        this.rhsplit = clip(this.rhsplit, 1 - QuarterLayout.MAX_PROPORTION, QuarterLayout.MAX_PROPORTION);
    };
    QuarterLayout.prototype.apply = function (tiles, area) {
        if (tiles.length === 1) {
            tiles[0].geometry = area;
            return;
        }
        var gap1 = Math.floor(CONFIG.tileLayoutGap / 2);
        var gap2 = CONFIG.tileLayoutGap - gap1;
        var leftWidth = Math.floor(area.width * this.vsplit);
        var rightWidth = area.width - leftWidth;
        var rightX = area.x + leftWidth;
        if (tiles.length === 2) {
            tiles[0].geometry = new Rect(area.x, area.y, leftWidth, area.height).gap(0, gap1, 0, 0);
            tiles[1].geometry = new Rect(rightX, area.y, rightWidth, area.height).gap(gap2, 0, 0, 0);
            return;
        }
        var rightTopHeight = Math.floor(area.height * this.rhsplit);
        var rightBottomHeight = area.height - rightTopHeight;
        var rightBottomY = area.y + rightTopHeight;
        if (tiles.length === 3) {
            tiles[0].geometry = new Rect(area.x, area.y, leftWidth, area.height).gap(0, gap1, 0, 0);
            tiles[1].geometry = new Rect(rightX, area.y, rightWidth, rightTopHeight).gap(gap2, 0, 0, gap1);
            tiles[2].geometry = new Rect(rightX, rightBottomY, rightWidth, rightBottomHeight).gap(gap2, 0, gap2, 0);
            return;
        }
        var leftTopHeight = Math.floor(area.height * this.lhsplit);
        var leftBottomHeight = area.height - leftTopHeight;
        var leftBottomY = area.y + leftTopHeight;
        if (tiles.length >= 4) {
            tiles[0].geometry = new Rect(area.x, area.y, leftWidth, leftTopHeight).gap(0, gap1, 0, gap1);
            tiles[1].geometry = new Rect(rightX, area.y, rightWidth, rightTopHeight).gap(gap2, 0, 0, gap1);
            tiles[2].geometry = new Rect(rightX, rightBottomY, rightWidth, rightBottomHeight).gap(gap2, 0, gap2, 0);
            tiles[3].geometry = new Rect(area.x, leftBottomY, leftWidth, leftBottomHeight).gap(0, gap2, gap2, 0);
        }
        if (tiles.length > 4)
            tiles.slice(4).forEach(function (tile) { return tile.state = WindowState.FreeTile; });
    };
    QuarterLayout.prototype.toString = function () {
        return "QuarterLayout()";
    };
    QuarterLayout.MAX_PROPORTION = 0.8;
    return QuarterLayout;
}());
var SpreadLayout = (function () {
    function SpreadLayout() {
        var _this = this;
        this.apply = function (tiles, area) {
            var numTiles = tiles.length;
            var spaceWidth = Math.floor(area.width * _this.space);
            var cardWidth = area.width - (spaceWidth * (numTiles - 1));
            var miniumCardWidth = area.width * 0.40;
            while (cardWidth < miniumCardWidth) {
                cardWidth += spaceWidth;
                numTiles -= 1;
            }
            for (var i = 0; i < tiles.length; i++)
                tiles[i].geometry = new Rect(area.x + ((i < numTiles) ? spaceWidth * (numTiles - i - 1) : 0), area.y, cardWidth, area.height);
        };
        this.space = 0.07;
    }
    Object.defineProperty(SpreadLayout.prototype, "enabled", {
        get: function () {
            return CONFIG.enableSpreadLayout;
        },
        enumerable: true,
        configurable: true
    });
    SpreadLayout.prototype.handleUserInput = function (input) {
        switch (input) {
            case UserInput.Decrease:
                this.space = Math.max(0.04, this.space - 0.01);
                break;
            case UserInput.Increase:
                this.space = Math.min(0.10, this.space + 0.01);
                break;
            default:
                return false;
        }
        return true;
    };
    SpreadLayout.prototype.toString = function () {
        return "SpreadLayout(" + this.space + ")";
    };
    return SpreadLayout;
}());
var StairLayout = (function () {
    function StairLayout() {
        var _this = this;
        this.apply = function (tiles, area) {
            var len = tiles.length;
            var space = _this.space;
            for (var i = 0; i < len; i++) {
                var dx = space * (len - i - 1);
                var dy = space * i;
                tiles[i].geometry = new Rect(area.x + dx, area.y + dy, area.width - dx, area.height - dy);
            }
        };
        this.space = 24;
    }
    Object.defineProperty(StairLayout.prototype, "enabled", {
        get: function () {
            return CONFIG.enableStairLayout;
        },
        enumerable: true,
        configurable: true
    });
    StairLayout.prototype.handleUserInput = function (input) {
        switch (input) {
            case UserInput.Decrease:
                this.space = Math.max(16, this.space - 8);
                break;
            case UserInput.Increase:
                this.space = Math.min(160, this.space + 8);
                break;
            default:
                return false;
        }
        return true;
    };
    StairLayout.prototype.toString = function () {
        return "StairLayout(" + this.space + ")";
    };
    return StairLayout;
}());
function stackTiles(tiles, x, y, width, height, gap) {
    if (gap === void 0) { gap = 0; }
    if (tiles.length === 1) {
        tiles[0].geometry = new Rect(x, y, width, height);
        return;
    }
    var count = tiles.length;
    var tileHeight = Math.floor((height - (count - 1) * gap) / count);
    tiles.forEach(function (window, i) {
        window.geometry = new Rect(x, y + (tileHeight + gap) * i, width, tileHeight);
    });
}
var TileLayout = (function () {
    function TileLayout() {
        var _this = this;
        this.apply = function (tiles, area) {
            var gap = CONFIG.tileLayoutGap;
            if (tiles.length <= _this.numMaster)
                stackTiles(tiles, area.x, area.y, area.width, area.height, gap);
            else if (_this.numMaster === 0)
                stackTiles(tiles, area.x, area.y, area.width, area.height, gap);
            else {
                var mgap = Math.ceil(gap / 2);
                var sgap = gap - mgap;
                var masterFullWidth = Math.floor(area.width * _this.masterRatio);
                var masterWidth = masterFullWidth - mgap;
                var stackWidth = area.width - masterFullWidth - sgap;
                var stackX = area.x + masterFullWidth + sgap;
                stackTiles(tiles.slice(0, _this.numMaster), area.x, area.y, masterWidth, area.height, gap);
                stackTiles(tiles.slice(_this.numMaster), stackX, area.y, stackWidth, area.height, gap);
            }
        };
        this.numMaster = 1;
        this.masterRatio = 0.55;
    }
    Object.defineProperty(TileLayout.prototype, "enabled", {
        get: function () {
            return CONFIG.enableTileLayout;
        },
        enumerable: true,
        configurable: true
    });
    TileLayout.prototype.adjust = function (area, tiles, basis) {
        if (tiles.length <= this.numMaster)
            return;
        var idx = tiles.indexOf(basis);
        if (idx < 0)
            return;
        var diff = basis.actualGeometry.subtract(basis.geometry);
        if (idx < this.numMaster) {
            if (diff.x === 0) {
                var newMasterWidth = Math.floor(area.width * this.masterRatio) + diff.width;
                this.masterRatio = newMasterWidth / area.width;
            }
        }
        else {
            if (diff.x !== 0) {
                var newStackWidth = (area.width - Math.floor(area.width * this.masterRatio)) + diff.width;
                this.masterRatio = (area.width - newStackWidth) / area.width;
            }
        }
        this.masterRatio = clip(this.masterRatio, TileLayout.MIN_MASTER_RATIO, TileLayout.MAX_MASTER_RATIO);
    };
    TileLayout.prototype.handleUserInput = function (input) {
        switch (input) {
            case UserInput.Left:
                this.masterRatio = clip(slide(this.masterRatio, -0.05), TileLayout.MIN_MASTER_RATIO, TileLayout.MAX_MASTER_RATIO);
                break;
            case UserInput.Right:
                this.masterRatio = clip(slide(this.masterRatio, +0.05), TileLayout.MIN_MASTER_RATIO, TileLayout.MAX_MASTER_RATIO);
                break;
            case UserInput.Increase:
                if (this.numMaster < 10)
                    this.numMaster += 1;
                break;
            case UserInput.Decrease:
                if (this.numMaster > 0)
                    this.numMaster -= 1;
                break;
            default:
                return false;
        }
        return true;
    };
    TileLayout.prototype.toString = function () {
        return "TileLayout(nmaster=" + this.numMaster + ", ratio=" + this.masterRatio + ")";
    };
    TileLayout.MIN_MASTER_RATIO = 0.2;
    TileLayout.MAX_MASTER_RATIO = 0.8;
    return TileLayout;
}());
var DEBUG = {
    enabled: false,
    started: new Date().getTime(),
};
function debug(f) {
    if (DEBUG.enabled) {
        var timestamp = (new Date().getTime() - DEBUG.started) / 1000;
        console.log("[" + timestamp + "]", f());
    }
}
function debugObj(f) {
    if (DEBUG.enabled) {
        var timestamp = (new Date().getTime() - DEBUG.started) / 1000;
        var _a = f(), name = _a[0], obj = _a[1];
        var buf = [];
        for (var i in obj)
            buf.push(i + "=" + obj[i]);
        console.log("[" + timestamp + "]", name + ": " + buf.join(" "));
    }
}
function clip(value, min, max) {
    if (value < min)
        return min;
    if (value > max)
        return max;
    return value;
}
function slide(value, step) {
    if (step === 0)
        return value;
    return Math.floor(value / step + 1.000001) * step;
}
function matchWords(str, words) {
    for (var i = 0; i < words.length; i++) {
        if (str.indexOf(words[i]) >= 0)
            return i;
    }
    return -1;
}
function toQRect(rect) {
    return Qt.rect(rect.x, rect.y, rect.width, rect.height);
}
function toRect(qrect) {
    return new Rect(qrect.x, qrect.y, qrect.width, qrect.height);
}
var Rect = (function () {
    function Rect(x, y, w, h) {
        this.height = h;
        this.width = w;
        this.x = x;
        this.y = y;
    }
    Rect.prototype.equals = function (other) {
        return (this.x === other.x &&
            this.y === other.y &&
            this.width === other.width &&
            this.height === other.height);
    };
    Rect.prototype.gap = function (left, right, top, bottom) {
        return new Rect(this.x + left, this.y + top, this.width - (left + right), this.height - (top + bottom));
    };
    Rect.prototype.subtract = function (other) {
        return new Rect(this.x - other.x, this.y - other.y, this.width - other.width, this.height - other.height);
    };
    Rect.prototype.toString = function () {
        return "Rect(" + [this.x, this.y, this.width, this.height].join(", ") + ")";
    };
    return Rect;
}());
