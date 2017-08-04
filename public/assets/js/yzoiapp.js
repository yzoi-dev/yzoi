/**
 * Created by Administrator on 2015-10-09.
 */
function FastClick(a) {
    "use strict";
    var b, c = this;
    if (this.trackingClick = !1, this.trackingClickStart = 0, this.targetElement = null, this.touchStartX = 0, this.touchStartY = 0, this.lastTouchIdentifier = 0, this.touchBoundary = 10, this.layer = a, !a || !a.nodeType) throw new TypeError("Layer must be a document node");
    this.onClick = function() {
        return FastClick.prototype.onClick.apply(c, arguments)
    }, this.onMouse = function() {
        return FastClick.prototype.onMouse.apply(c, arguments)
    }, this.onTouchStart = function() {
        return FastClick.prototype.onTouchStart.apply(c, arguments)
    }, this.onTouchMove = function() {
        return FastClick.prototype.onTouchMove.apply(c, arguments)
    }, this.onTouchEnd = function() {
        return FastClick.prototype.onTouchEnd.apply(c, arguments)
    }, this.onTouchCancel = function() {
        return FastClick.prototype.onTouchCancel.apply(c, arguments)
    }, FastClick.notNeeded(a) || (this.deviceIsAndroid && (a.addEventListener("mouseover", this.onMouse, !0), a.addEventListener("mousedown", this.onMouse, !0), a.addEventListener("mouseup", this.onMouse, !0)), a.addEventListener("click", this.onClick, !0), a.addEventListener("touchstart", this.onTouchStart, !1), a.addEventListener("touchmove", this.onTouchMove, !1), a.addEventListener("touchend", this.onTouchEnd, !1), a.addEventListener("touchcancel", this.onTouchCancel, !1), Event.prototype.stopImmediatePropagation || (a.removeEventListener = function(b, c, d) {
        var e = Node.prototype.removeEventListener;
        "click" === b ? e.call(a, b, c.hijacked || c, d) : e.call(a, b, c, d)
    }, a.addEventListener = function(b, c, d) {
        var e = Node.prototype.addEventListener;
        "click" === b ? e.call(a, b, c.hijacked || (c.hijacked = function(a) {
                a.propagationStopped || c(a)
            }), d) : e.call(a, b, c, d)
    }), "function" == typeof a.onclick && (b = a.onclick, a.addEventListener("click", function(a) {
        b(a)
    }, !1), a.onclick = null))
}

function Emitter(a) {
    return a ? mixin(a) : void 0
}

function mixin(a) {
    for (var b in Emitter.prototype) a[b] = Emitter.prototype[b];
    return a
}(function() {
    String.prototype.endsWith || (String.prototype.endsWith = function(a) {
        return -1 !== this.indexOf(a, this.length - a.length)
    }), String.prototype.trim || (String.prototype.trim = function() {
        return this.replace(/^\s+|\s+$/g, "")
    }), Array.prototype.indexOf || (Array.prototype.indexOf = function(a, b) {
        var c, d, e;
        if (void 0 === this || null === this) throw new TypeError('"this" is null or not defined');
        for (d = this.length >>> 0, b = +b || 0, 1 / 0 === Math.abs(b) && (b = 0), 0 > b && (b += d, 0 > b && (b = 0)), c = e = b; d >= b ? d > e : e > d; c = d >= b ? ++e : --e)
            if (this[c] === a) return c;
        return -1
    }), Function.prototype.bind || (Function.prototype.bind = function(a) {
        var b, c, d, e;
        if ("function" != typeof this) throw new TypeError("Function.prototype.bind - what is trying to be bound is not callable");
        return b = Array.prototype.slice.call(arguments, 1), e = this, d = function() {}, c = function() {
            return e.apply(this instanceof d && a ? this : a, b.concat(Array.prototype.slice.call(arguments)))
        }, d.prototype = this.prototype, c.prototype = new d, c
    }), Object.keys || (Object.keys = function() {
        "use strict";
        var a, b, c;
        return c = Object.prototype.hasOwnProperty, b = {
            toString: null
        }.propertyIsEnumerable("toString") ? !1 : !0, a = ["toString", "toLocaleString", "valueOf", "hasOwnProperty", "isPrototypeOf", "propertyIsEnumerable", "constructor"],
            function(d) {
                var e, f, g, h, i, j, k;
                if ("object" != typeof d && ("function" != typeof d || null === d)) throw new TypeError("Object.keys called on non-object");
                for (g = [], h = 0, j = d.length; j > h; h++) f = d[h], c.call(d, f) && g.push(f);
                if (b)
                    for (i = 0, k = a.length; k > i; i++) e = a[i], c.call(d, e) && g.push(e);
                return g
            }
    }.call(this)), window.getScreenSize = function(a, b) {
        return a.is(":visible") ? "small" : b.is(":visible") ? "tablet" : "desktop"
    }
}).call(this),
    function() {
        var a, b;
        b = {
            is_mobile: !1,
            resize_delay: 400,
            stored_values_prefix: "pa_",
            main_menu: {
                accordion: !0,
                animation_speed: 250,
                store_state: !0,
                store_state_key: "mmstate"
            },
            consts: {
                COLORS: ["#71c73e", "#77b7c5", "#d54848", "#6c42e5", "#e8e64e", "#dd56e6", "#ecad3f", "#618b9d", "#b68b68", "#36a766", "#3156be", "#00b3ff", "#646464", "#a946e8", "#9d9d9d"]
            }
        }, a = function() {
            return this.init = [], this.plugins = {}, this.settings = {}, this.localStorageSupported = "undefined" != typeof window.Storage ? !0 : !1, this
        }, a.prototype.start = function(a, c) {
            return null == a && (a = []), null == c && (c = {}), window.onload = function(d) {
                return function() {
                    var e, f, g, h;
                    for ($("html").addClass("pxajs"), a.length > 0 && $.merge(d.init, a), d.settings = $.extend(!0, {}, b, c || {}), d.settings.is_mobile = /iphone|ipad|ipod|android|blackberry|mini|windows\sce|palm/i.test(navigator.userAgent.toLowerCase()), d.settings.is_mobile && FastClick && FastClick.attach(document.body), h = d.init, f = 0, g = h.length; g > f; f++) e = h[f], $.proxy(e, d)();
                    return $(window).trigger("pa.loaded"), $(window).resize()
                }
            }(this), this
        }, a.prototype.addInitializer = function(a) {
            return this.init.push(a)
        }, a.prototype.initPlugin = function(a, b) {
            return this.plugins[a] = b, b.init ? b.init() : void 0
        }, a.prototype.storeValue = function(a, b, c) {
            var d;
            if (null == c && (c = !1), this.localStorageSupported && !c) try {
                return void window.localStorage.setItem(this.settings.stored_values_prefix + a, b)
            } catch (e) {
                d = e
            }
            return document.cookie = this.settings.stored_values_prefix + a + "=" + escape(b)
        }, a.prototype.storeValues = function(a, b) {
            var c, d, e, f;
            if (null == b && (b = !1), this.localStorageSupported && !b) try {
                for (d in a) e = a[d], window.localStorage.setItem(this.settings.stored_values_prefix + d, e);
                return
            } catch (g) {
                c = g
            }
            f = [];
            for (d in a) e = a[d], f.push(document.cookie = this.settings.stored_values_prefix + d + "=" + escape(e));
            return f
        }, a.prototype.getStoredValue = function(a, b, c) {
            var d, e, f, g, h, i, j, k, l;
            if (null == b && (b = !1), null == c && (c = null), this.localStorageSupported && !b) try {
                return i = window.localStorage.getItem(this.settings.stored_values_prefix + a), i ? i : c
            } catch (m) {
                f = m
            }
            for (e = document.cookie.split(";"), k = 0, l = e.length; l > k; k++)
                if (d = e[k], h = d.indexOf("="), g = d.substr(0, h).replace(/^\s+|\s+$/g, ""), j = d.substr(h + 1).replace(/^\s+|\s+$/g, ""), g === this.settings.stored_values_prefix + a) return j;
            return c
        }, a.prototype.getStoredValues = function(a, b, c) {
            var d, e, f, g, h, i, j, k, l, m, n, o, p, q, r;
            for (null == b && (b = !1), null == c && (c = null), k = {}, m = 0, p = a.length; p > m; m++) h = a[m], k[h] = c;
            if (this.localStorageSupported && !b) try {
                for (n = 0, q = a.length; q > n; n++) h = a[n], j = window.localStorage.getItem(this.settings.stored_values_prefix + h), j && (k[h] = j);
                return k
            } catch (s) {
                f = s
            }
            for (e = document.cookie.split(";"), o = 0, r = e.length; r > o; o++) d = e[o], i = d.indexOf("="), g = d.substr(0, i).replace(/^\s+|\s+$/g, ""), l = d.substr(i + 1).replace(/^\s+|\s+$/g, ""), g === this.settings.stored_values_prefix + h && (k[h] = l);
            return k
        }, a.Constructor = a, window.LanderApp = new a
    }.call(this),
    function() {
        var a;
        a = function(a) {
            var b;
            return b = null,
                function() {
                    return b && clearTimeout(b), b = setTimeout(function() {
                        return b = null, a.call(this)
                    }, LanderApp.settings.resize_delay)
                }
        }, LanderApp.addInitializer(function() {
            var b, c, d, e;
            return e = null, d = $(window), b = $('<div id="small-screen-width-point" style="position:absolute;top:-10000px;width:10px;height:10px;background:#fff;"></div>'), c = $('<div id="tablet-screen-width-point" style="position:absolute;top:-10000px;width:10px;height:10px;background:#fff;"></div>'), $("body").append(b).append(c), d.on("resize", a(function() {
                return d.trigger("pa.resize"), b.is(":visible") ? ("small" !== e && d.trigger("pa.screen.small"), e = "small") : c.is(":visible") ? ("tablet" !== e && d.trigger("pa.screen.tablet"), e = "tablet") : ("desktop" !== e && d.trigger("pa.screen.desktop"), e = "desktop")
            }))
        })
    }.call(this), FastClick.prototype.deviceIsAndroid = navigator.userAgent.indexOf("Android") > 0, FastClick.prototype.deviceIsIOS = /iP(ad|hone|od)/.test(navigator.userAgent), FastClick.prototype.deviceIsIOS4 = FastClick.prototype.deviceIsIOS && /OS 4_\d(_\d)?/.test(navigator.userAgent), FastClick.prototype.deviceIsIOSWithBadTarget = FastClick.prototype.deviceIsIOS && /OS ([6-9]|\d{2})_\d/.test(navigator.userAgent), FastClick.prototype.needsClick = function(a) {
    "use strict";
    switch (a.nodeName.toLowerCase()) {
        case "button":
        case "select":
        case "textarea":
            if (a.disabled) return !0;
            break;
        case "input":
            if (this.deviceIsIOS && "file" === a.type || a.disabled) return !0;
            break;
        case "label":
        case "video":
            return !0
    }
    return /\bneedsclick\b/.test(a.className)
}, FastClick.prototype.needsFocus = function(a) {
    "use strict";
    switch (a.nodeName.toLowerCase()) {
        case "textarea":
            return !0;
        case "select":
            return !this.deviceIsAndroid;
        case "input":
            switch (a.type) {
                case "button":
                case "checkbox":
                case "file":
                case "image":
                case "radio":
                case "submit":
                    return !1
            }
            return !a.disabled && !a.readOnly;
        default:
            return /\bneedsfocus\b/.test(a.className)
    }
}, FastClick.prototype.sendClick = function(a, b) {
    "use strict";
    var c, d;
    document.activeElement && document.activeElement !== a && document.activeElement.blur(), d = b.changedTouches[0], c = document.createEvent("MouseEvents"), c.initMouseEvent(this.determineEventType(a), !0, !0, window, 1, d.screenX, d.screenY, d.clientX, d.clientY, !1, !1, !1, !1, 0, null), c.forwardedTouchEvent = !0, a.dispatchEvent(c)
}, FastClick.prototype.determineEventType = function(a) {
    "use strict";
    return this.deviceIsAndroid && "select" === a.tagName.toLowerCase() ? "mousedown" : "click"
}, FastClick.prototype.focus = function(a) {
    "use strict";
    var b;
    this.deviceIsIOS && a.setSelectionRange && 0 !== a.type.indexOf("date") && "time" !== a.type ? (b = a.value.length, a.setSelectionRange(b, b)) : a.focus()
}, FastClick.prototype.updateScrollParent = function(a) {
    "use strict";
    var b, c;
    if (b = a.fastClickScrollParent, !b || !b.contains(a)) {
        c = a;
        do {
            if (c.scrollHeight > c.offsetHeight) {
                b = c, a.fastClickScrollParent = c;
                break
            }
            c = c.parentElement
        } while (c)
    }
    b && (b.fastClickLastScrollTop = b.scrollTop)
}, FastClick.prototype.getTargetElementFromEventTarget = function(a) {
    "use strict";
    return a.nodeType === Node.TEXT_NODE ? a.parentNode : a
}, FastClick.prototype.onTouchStart = function(a) {
    "use strict";
    var b, c, d;
    if (a.targetTouches.length > 1) return !0;
    if (b = this.getTargetElementFromEventTarget(a.target), c = a.targetTouches[0], this.deviceIsIOS) {
        if (d = window.getSelection(), d.rangeCount && !d.isCollapsed) return !0;
        if (!this.deviceIsIOS4) {
            if (c.identifier === this.lastTouchIdentifier) return a.preventDefault(), !1;
            this.lastTouchIdentifier = c.identifier, this.updateScrollParent(b)
        }
    }
    return this.trackingClick = !0, this.trackingClickStart = a.timeStamp, this.targetElement = b, this.touchStartX = c.pageX, this.touchStartY = c.pageY, a.timeStamp - this.lastClickTime < 200 && a.preventDefault(), !0
}, FastClick.prototype.touchHasMoved = function(a) {
    "use strict";
    var b = a.changedTouches[0],
        c = this.touchBoundary;
    return Math.abs(b.pageX - this.touchStartX) > c || Math.abs(b.pageY - this.touchStartY) > c ? !0 : !1
}, FastClick.prototype.onTouchMove = function(a) {
    "use strict";
    return this.trackingClick ? ((this.targetElement !== this.getTargetElementFromEventTarget(a.target) || this.touchHasMoved(a)) && (this.trackingClick = !1, this.targetElement = null), !0) : !0
}, FastClick.prototype.findControl = function(a) {
    "use strict";
    return void 0 !== a.control ? a.control : a.htmlFor ? document.getElementById(a.htmlFor) : a.querySelector("button, input:not([type=hidden]), keygen, meter, output, progress, select, textarea")
}, FastClick.prototype.onTouchEnd = function(a) {
    "use strict";
    var b, c, d, e, f, g = this.targetElement;
    if (!this.trackingClick) return !0;
    if (a.timeStamp - this.lastClickTime < 200) return this.cancelNextClick = !0, !0;
    if (this.cancelNextClick = !1, this.lastClickTime = a.timeStamp, c = this.trackingClickStart, this.trackingClick = !1, this.trackingClickStart = 0, this.deviceIsIOSWithBadTarget && (f = a.changedTouches[0], g = document.elementFromPoint(f.pageX - window.pageXOffset, f.pageY - window.pageYOffset) || g, g.fastClickScrollParent = this.targetElement.fastClickScrollParent), d = g.tagName.toLowerCase(), "label" === d) {
        if (b = this.findControl(g)) {
            if (this.focus(g), this.deviceIsAndroid) return !1;
            g = b
        }
    } else if (this.needsFocus(g)) return a.timeStamp - c > 100 || this.deviceIsIOS && window.top !== window && "input" === d ? (this.targetElement = null, !1) : (this.focus(g), this.deviceIsIOS4 && "select" === d || (this.targetElement = null, a.preventDefault()), !1);
    return this.deviceIsIOS && !this.deviceIsIOS4 && (e = g.fastClickScrollParent, e && e.fastClickLastScrollTop !== e.scrollTop) ? !0 : (this.needsClick(g) || (a.preventDefault(), this.sendClick(g, a)), !1)
}, FastClick.prototype.onTouchCancel = function() {
    "use strict";
    this.trackingClick = !1, this.targetElement = null
}, FastClick.prototype.onMouse = function(a) {
    "use strict";
    return this.targetElement ? a.forwardedTouchEvent ? !0 : a.cancelable && (!this.needsClick(this.targetElement) || this.cancelNextClick) ? (a.stopImmediatePropagation ? a.stopImmediatePropagation() : a.propagationStopped = !0, a.stopPropagation(), a.preventDefault(), !1) : !0 : !0
}, FastClick.prototype.onClick = function(a) {
    "use strict";
    var b;
    return this.trackingClick ? (this.targetElement = null, this.trackingClick = !1, !0) : "submit" === a.target.type && 0 === a.detail ? !0 : (b = this.onMouse(a), b || (this.targetElement = null), b)
}, FastClick.prototype.destroy = function() {
    "use strict";
    var a = this.layer;
    this.deviceIsAndroid && (a.removeEventListener("mouseover", this.onMouse, !0), a.removeEventListener("mousedown", this.onMouse, !0), a.removeEventListener("mouseup", this.onMouse, !0)), a.removeEventListener("click", this.onClick, !0), a.removeEventListener("touchstart", this.onTouchStart, !1), a.removeEventListener("touchmove", this.onTouchMove, !1), a.removeEventListener("touchend", this.onTouchEnd, !1), a.removeEventListener("touchcancel", this.onTouchCancel, !1)
}, FastClick.notNeeded = function(a) {
    "use strict";
    var b, c;
    if ("undefined" == typeof window.ontouchstart) return !0;
    if (c = +(/Chrome\/([0-9]+)/.exec(navigator.userAgent) || [, 0])[1]) {
        if (!FastClick.prototype.deviceIsAndroid) return !0;
        if (b = document.querySelector("meta[name=viewport]")) {
            if (-1 !== b.content.indexOf("user-scalable=no")) return !0;
            if (c > 31 && window.innerWidth <= window.screen.width) return !0
        }
    }
    return "none" === a.style.msTouchAction ? !0 : !1
}, FastClick.attach = function(a) {
    "use strict";
    return new FastClick(a)
}, "undefined" != typeof define && define.amd ? define(function() {
    "use strict";
    return FastClick
}) : "undefined" != typeof module && module.exports ? (module.exports = FastClick.attach, module.exports.FastClick = FastClick) : window.FastClick = FastClick,
    function(a, b, c) {
        function d(a, c) {
            this.wrapper = "string" == typeof a ? b.querySelector(a) : a, this.scroller = this.wrapper.children[0], this.scrollerStyle = this.scroller.style, this.options = {
                resizeScrollbars: !0,
                mouseWheelSpeed: 20,
                snapThreshold: .334,
                startX: 0,
                startY: 0,
                scrollY: !0,
                directionLockThreshold: 5,
                momentum: !0,
                bounce: !0,
                bounceTime: 600,
                bounceEasing: "",
                preventDefault: !0,
                preventDefaultException: {
                    tagName: /^(INPUT|TEXTAREA|BUTTON|SELECT)$/
                },
                HWCompositing: !0,
                useTransition: !0,
                useTransform: !0
            };
            for (var d in c) this.options[d] = c[d];
            this.translateZ = this.options.HWCompositing && h.hasPerspective ? " translateZ(0)" : "", this.options.useTransition = h.hasTransition && this.options.useTransition, this.options.useTransform = h.hasTransform && this.options.useTransform, this.options.eventPassthrough = this.options.eventPassthrough === !0 ? "vertical" : this.options.eventPassthrough, this.options.preventDefault = !this.options.eventPassthrough && this.options.preventDefault, this.options.scrollY = "vertical" == this.options.eventPassthrough ? !1 : this.options.scrollY, this.options.scrollX = "horizontal" == this.options.eventPassthrough ? !1 : this.options.scrollX, this.options.freeScroll = this.options.freeScroll && !this.options.eventPassthrough, this.options.directionLockThreshold = this.options.eventPassthrough ? 0 : this.options.directionLockThreshold, this.options.bounceEasing = "string" == typeof this.options.bounceEasing ? h.ease[this.options.bounceEasing] || h.ease.circular : this.options.bounceEasing, this.options.resizePolling = void 0 === this.options.resizePolling ? 60 : this.options.resizePolling, this.options.tap === !0 && (this.options.tap = "tap"), "scale" == this.options.shrinkScrollbars && (this.options.useTransition = !1), this.options.invertWheelDirection = this.options.invertWheelDirection ? -1 : 1, this.x = 0, this.y = 0, this.directionX = 0, this.directionY = 0, this._events = {}, this._init(), this.refresh(), this.scrollTo(this.options.startX, this.options.startY), this.enable()
        }

        function e(a, c, d) {
            var e = b.createElement("div"),
                f = b.createElement("div");
            return d === !0 && (e.style.cssText = "position:absolute;z-index:9999", f.style.cssText = "-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box;position:absolute;background:rgba(0,0,0,0.5);border:1px solid rgba(255,255,255,0.9);border-radius:3px"), f.className = "iScrollIndicator", "h" == a ? (d === !0 && (e.style.cssText += ";height:7px;left:2px;right:2px;bottom:0", f.style.height = "100%"), e.className = "iScrollHorizontalScrollbar") : (d === !0 && (e.style.cssText += ";width:7px;bottom:2px;top:2px;right:1px", f.style.width = "100%"), e.className = "iScrollVerticalScrollbar"), e.style.cssText += ";overflow:hidden", c || (e.style.pointerEvents = "none"), e.appendChild(f), e
        }

        function f(c, d) {
            this.wrapper = "string" == typeof d.el ? b.querySelector(d.el) : d.el, this.wrapperStyle = this.wrapper.style, this.indicator = this.wrapper.children[0], this.indicatorStyle = this.indicator.style, this.scroller = c, this.options = {
                listenX: !0,
                listenY: !0,
                interactive: !1,
                resize: !0,
                defaultScrollbars: !1,
                shrink: !1,
                fade: !1,
                speedRatioX: 0,
                speedRatioY: 0
            };
            for (var e in d) this.options[e] = d[e];
            this.sizeRatioX = 1, this.sizeRatioY = 1, this.maxPosX = 0, this.maxPosY = 0, this.options.interactive && (this.options.disableTouch || (h.addEvent(this.indicator, "touchstart", this), h.addEvent(a, "touchend", this)), this.options.disablePointer || (h.addEvent(this.indicator, "MSPointerDown", this), h.addEvent(a, "MSPointerUp", this)), this.options.disableMouse || (h.addEvent(this.indicator, "mousedown", this), h.addEvent(a, "mouseup", this))), this.options.fade && (this.wrapperStyle[h.style.transform] = this.scroller.translateZ, this.wrapperStyle[h.style.transitionDuration] = h.isBadAndroid ? "0.001s" : "0ms", this.wrapperStyle.opacity = "0")
        }
        var g = a.requestAnimationFrame || a.webkitRequestAnimationFrame || a.mozRequestAnimationFrame || a.oRequestAnimationFrame || a.msRequestAnimationFrame || function(b) {
                    a.setTimeout(b, 1e3 / 60)
                },
            h = function() {
                function d(a) {
                    return g === !1 ? !1 : "" === g ? a : g + a.charAt(0).toUpperCase() + a.substr(1)
                }
                var e = {},
                    f = b.createElement("div").style,
                    g = function() {
                        for (var a, b = ["t", "webkitT", "MozT", "msT", "OT"], c = 0, d = b.length; d > c; c++)
                            if (a = b[c] + "ransform", a in f) return b[c].substr(0, b[c].length - 1);
                        return !1
                    }();
                e.getTime = Date.now || function() {
                        return (new Date).getTime()
                    }, e.extend = function(a, b) {
                    for (var c in b) a[c] = b[c]
                }, e.addEvent = function(a, b, c, d) {
                    a.addEventListener(b, c, !!d)
                }, e.removeEvent = function(a, b, c, d) {
                    a.removeEventListener(b, c, !!d)
                }, e.momentum = function(a, b, d, e, f, g) {
                    var h, i, j = a - b,
                        k = c.abs(j) / d;
                    return g = void 0 === g ? 6e-4 : g, h = a + k * k / (2 * g) * (0 > j ? -1 : 1), i = k / g, e > h ? (h = f ? e - f / 2.5 * (k / 8) : e, j = c.abs(h - a), i = j / k) : h > 0 && (h = f ? f / 2.5 * (k / 8) : 0, j = c.abs(a) + h, i = j / k), {
                        destination: c.round(h),
                        duration: i
                    }
                };
                var h = d("transform");
                return e.extend(e, {
                    hasTransform: h !== !1,
                    hasPerspective: d("perspective") in f,
                    hasTouch: "ontouchstart" in a,
                    hasPointer: navigator.msPointerEnabled,
                    hasTransition: d("transition") in f
                }), e.isBadAndroid = /Android /.test(a.navigator.appVersion) && !/Chrome\/\d/.test(a.navigator.appVersion), e.extend(e.style = {}, {
                    transform: h,
                    transitionTimingFunction: d("transitionTimingFunction"),
                    transitionDuration: d("transitionDuration"),
                    transitionDelay: d("transitionDelay"),
                    transformOrigin: d("transformOrigin")
                }), e.hasClass = function(a, b) {
                    var c = new RegExp("(^|\\s)" + b + "(\\s|$)");
                    return c.test(a.className)
                }, e.addClass = function(a, b) {
                    if (!e.hasClass(a, b)) {
                        var c = a.className.split(" ");
                        c.push(b), a.className = c.join(" ")
                    }
                }, e.removeClass = function(a, b) {
                    if (e.hasClass(a, b)) {
                        var c = new RegExp("(^|\\s)" + b + "(\\s|$)", "g");
                        a.className = a.className.replace(c, " ")
                    }
                }, e.offset = function(a) {
                    for (var b = -a.offsetLeft, c = -a.offsetTop; a = a.offsetParent;) b -= a.offsetLeft, c -= a.offsetTop;
                    return {
                        left: b,
                        top: c
                    }
                }, e.preventDefaultException = function(a, b) {
                    for (var c in b)
                        if (b[c].test(a[c])) return !0;
                    return !1
                }, e.extend(e.eventType = {}, {
                    touchstart: 1,
                    touchmove: 1,
                    touchend: 1,
                    mousedown: 2,
                    mousemove: 2,
                    mouseup: 2,
                    MSPointerDown: 3,
                    MSPointerMove: 3,
                    MSPointerUp: 3
                }), e.extend(e.ease = {}, {
                    quadratic: {
                        style: "cubic-bezier(0.25, 0.46, 0.45, 0.94)",
                        fn: function(a) {
                            return a * (2 - a)
                        }
                    },
                    circular: {
                        style: "cubic-bezier(0.1, 0.57, 0.1, 1)",
                        fn: function(a) {
                            return c.sqrt(1 - --a * a)
                        }
                    },
                    back: {
                        style: "cubic-bezier(0.175, 0.885, 0.32, 1.275)",
                        fn: function(a) {
                            var b = 4;
                            return (a -= 1) * a * ((b + 1) * a + b) + 1
                        }
                    },
                    bounce: {
                        style: "",
                        fn: function(a) {
                            return (a /= 1) < 1 / 2.75 ? 7.5625 * a * a : 2 / 2.75 > a ? 7.5625 * (a -= 1.5 / 2.75) * a + .75 : 2.5 / 2.75 > a ? 7.5625 * (a -= 2.25 / 2.75) * a + .9375 : 7.5625 * (a -= 2.625 / 2.75) * a + .984375
                        }
                    },
                    elastic: {
                        style: "",
                        fn: function(a) {
                            var b = .22,
                                d = .4;
                            return 0 === a ? 0 : 1 == a ? 1 : d * c.pow(2, -10 * a) * c.sin(2 * (a - b / 4) * c.PI / b) + 1
                        }
                    }
                }), e.tap = function(a, c) {
                    var d = b.createEvent("Event");
                    d.initEvent(c, !0, !0), d.pageX = a.pageX, d.pageY = a.pageY, a.target.dispatchEvent(d)
                }, e.click = function(a) {
                    var c, d = a.target;
                    /(SELECT|INPUT|TEXTAREA)/i.test(d.tagName) || (c = b.createEvent("MouseEvents"), c.initMouseEvent("click", !0, !0, a.view, 1, d.screenX, d.screenY, d.clientX, d.clientY, a.ctrlKey, a.altKey, a.shiftKey, a.metaKey, 0, null), c._constructed = !0, d.dispatchEvent(c))
                }, e
            }();
        d.prototype = {
            version: "5.1.1",
            _init: function() {
                this._initEvents(), (this.options.scrollbars || this.options.indicators) && this._initIndicators(), this.options.mouseWheel && this._initWheel(), this.options.snap && this._initSnap(), this.options.keyBindings && this._initKeys()
            },
            destroy: function() {
                this._initEvents(!0), this._execEvent("destroy")
            },
            _transitionEnd: function(a) {
                a.target == this.scroller && this.isInTransition && (this._transitionTime(), this.resetPosition(this.options.bounceTime) || (this.isInTransition = !1, this._execEvent("scrollEnd")))
            },
            _start: function(a) {
                if (!(1 != h.eventType[a.type] && 0 !== a.button || !this.enabled || this.initiated && h.eventType[a.type] !== this.initiated)) {
                    !this.options.preventDefault || h.isBadAndroid || h.preventDefaultException(a.target, this.options.preventDefaultException) || a.preventDefault();
                    var b, d = a.touches ? a.touches[0] : a;
                    this.initiated = h.eventType[a.type], this.moved = !1, this.distX = 0, this.distY = 0, this.directionX = 0, this.directionY = 0, this.directionLocked = 0, this._transitionTime(), this.startTime = h.getTime(), this.options.useTransition && this.isInTransition ? (this.isInTransition = !1, b = this.getComputedPosition(), this._translate(c.round(b.x), c.round(b.y)), this._execEvent("scrollEnd")) : !this.options.useTransition && this.isAnimating && (this.isAnimating = !1, this._execEvent("scrollEnd")), this.startX = this.x, this.startY = this.y, this.absStartX = this.x, this.absStartY = this.y, this.pointX = d.pageX, this.pointY = d.pageY, this._execEvent("beforeScrollStart")
                }
            },
            _move: function(a) {
                if (this.enabled && h.eventType[a.type] === this.initiated) {
                    this.options.preventDefault && a.preventDefault();
                    var b, d, e, f, g = a.touches ? a.touches[0] : a,
                        i = g.pageX - this.pointX,
                        j = g.pageY - this.pointY,
                        k = h.getTime();
                    if (this.pointX = g.pageX, this.pointY = g.pageY, this.distX += i, this.distY += j, e = c.abs(this.distX), f = c.abs(this.distY), !(k - this.endTime > 300 && 10 > e && 10 > f)) {
                        if (this.directionLocked || this.options.freeScroll || (this.directionLocked = e > f + this.options.directionLockThreshold ? "h" : f >= e + this.options.directionLockThreshold ? "v" : "n"), "h" == this.directionLocked) {
                            if ("vertical" == this.options.eventPassthrough) a.preventDefault();
                            else if ("horizontal" == this.options.eventPassthrough) return void(this.initiated = !1);
                            j = 0
                        } else if ("v" == this.directionLocked) {
                            if ("horizontal" == this.options.eventPassthrough) a.preventDefault();
                            else if ("vertical" == this.options.eventPassthrough) return void(this.initiated = !1);
                            i = 0
                        }
                        i = this.hasHorizontalScroll ? i : 0, j = this.hasVerticalScroll ? j : 0, b = this.x + i, d = this.y + j, (b > 0 || b < this.maxScrollX) && (b = this.options.bounce ? this.x + i / 3 : b > 0 ? 0 : this.maxScrollX), (d > 0 || d < this.maxScrollY) && (d = this.options.bounce ? this.y + j / 3 : d > 0 ? 0 : this.maxScrollY), this.directionX = i > 0 ? -1 : 0 > i ? 1 : 0, this.directionY = j > 0 ? -1 : 0 > j ? 1 : 0, this.moved || this._execEvent("scrollStart"), this.moved = !0, this._translate(b, d), k - this.startTime > 300 && (this.startTime = k, this.startX = this.x, this.startY = this.y)
                    }
                }
            },
            _end: function(a) {
                if (this.enabled && h.eventType[a.type] === this.initiated) {
                    this.options.preventDefault && !h.preventDefaultException(a.target, this.options.preventDefaultException) && a.preventDefault();
                    var b, d, e = (a.changedTouches ? a.changedTouches[0] : a, h.getTime() - this.startTime),
                        f = c.round(this.x),
                        g = c.round(this.y),
                        i = c.abs(f - this.startX),
                        j = c.abs(g - this.startY),
                        k = 0,
                        l = "";
                    if (this.isInTransition = 0, this.initiated = 0, this.endTime = h.getTime(), !this.resetPosition(this.options.bounceTime)) {
                        if (this.scrollTo(f, g), !this.moved) return this.options.tap && h.tap(a, this.options.tap), this.options.click && h.click(a), void this._execEvent("scrollCancel");
                        if (this._events.flick && 200 > e && 100 > i && 100 > j) return void this._execEvent("flick");
                        if (this.options.momentum && 300 > e && (b = this.hasHorizontalScroll ? h.momentum(this.x, this.startX, e, this.maxScrollX, this.options.bounce ? this.wrapperWidth : 0, this.options.deceleration) : {
                                destination: f,
                                duration: 0
                            }, d = this.hasVerticalScroll ? h.momentum(this.y, this.startY, e, this.maxScrollY, this.options.bounce ? this.wrapperHeight : 0, this.options.deceleration) : {
                                destination: g,
                                duration: 0
                            }, f = b.destination, g = d.destination, k = c.max(b.duration, d.duration), this.isInTransition = 1), this.options.snap) {
                            var m = this._nearestSnap(f, g);
                            this.currentPage = m, k = this.options.snapSpeed || c.max(c.max(c.min(c.abs(f - m.x), 1e3), c.min(c.abs(g - m.y), 1e3)), 300), f = m.x, g = m.y, this.directionX = 0, this.directionY = 0, l = this.options.bounceEasing
                        }
                        return f != this.x || g != this.y ? ((f > 0 || f < this.maxScrollX || g > 0 || g < this.maxScrollY) && (l = h.ease.quadratic), void this.scrollTo(f, g, k, l)) : void this._execEvent("scrollEnd")
                    }
                }
            },
            _resize: function() {
                var a = this;
                clearTimeout(this.resizeTimeout), this.resizeTimeout = setTimeout(function() {
                    a.refresh()
                }, this.options.resizePolling)
            },
            resetPosition: function(a) {
                var b = this.x,
                    c = this.y;
                return a = a || 0, !this.hasHorizontalScroll || this.x > 0 ? b = 0 : this.x < this.maxScrollX && (b = this.maxScrollX), !this.hasVerticalScroll || this.y > 0 ? c = 0 : this.y < this.maxScrollY && (c = this.maxScrollY), b == this.x && c == this.y ? !1 : (this.scrollTo(b, c, a, this.options.bounceEasing), !0)
            },
            disable: function() {
                this.enabled = !1
            },
            enable: function() {
                this.enabled = !0
            },
            refresh: function() {
                this.wrapper.offsetHeight;
                this.wrapperWidth = this.wrapper.clientWidth, this.wrapperHeight = this.wrapper.clientHeight, this.scrollerWidth = this.scroller.offsetWidth, this.scrollerHeight = this.scroller.offsetHeight, this.maxScrollX = this.wrapperWidth - this.scrollerWidth, this.maxScrollY = this.wrapperHeight - this.scrollerHeight, this.hasHorizontalScroll = this.options.scrollX && this.maxScrollX < 0, this.hasVerticalScroll = this.options.scrollY && this.maxScrollY < 0, this.hasHorizontalScroll || (this.maxScrollX = 0, this.scrollerWidth = this.wrapperWidth), this.hasVerticalScroll || (this.maxScrollY = 0, this.scrollerHeight = this.wrapperHeight), this.endTime = 0, this.directionX = 0, this.directionY = 0, this.wrapperOffset = h.offset(this.wrapper), this._execEvent("refresh"), this.resetPosition()
            },
            on: function(a, b) {
                this._events[a] || (this._events[a] = []), this._events[a].push(b)
            },
            off: function(a, b) {
                if (this._events[a]) {
                    var c = this._events[a].indexOf(b);
                    c > -1 && this._events[a].splice(c, 1)
                }
            },
            _execEvent: function(a) {
                if (this._events[a]) {
                    var b = 0,
                        c = this._events[a].length;
                    if (c)
                        for (; c > b; b++) this._events[a][b].apply(this, [].slice.call(arguments, 1))
                }
            },
            scrollBy: function(a, b, c, d) {
                a = this.x + a, b = this.y + b, c = c || 0, this.scrollTo(a, b, c, d)
            },
            scrollTo: function(a, b, c, d) {
                d = d || h.ease.circular, this.isInTransition = this.options.useTransition && c > 0, !c || this.options.useTransition && d.style ? (this._transitionTimingFunction(d.style), this._transitionTime(c), this._translate(a, b)) : this._animate(a, b, c, d.fn)
            },
            scrollToElement: function(a, b, d, e, f) {
                if (a = a.nodeType ? a : this.scroller.querySelector(a)) {
                    var g = h.offset(a);
                    g.left -= this.wrapperOffset.left, g.top -= this.wrapperOffset.top, d === !0 && (d = c.round(a.offsetWidth / 2 - this.wrapper.offsetWidth / 2)), e === !0 && (e = c.round(a.offsetHeight / 2 - this.wrapper.offsetHeight / 2)), g.left -= d || 0, g.top -= e || 0, g.left = g.left > 0 ? 0 : g.left < this.maxScrollX ? this.maxScrollX : g.left, g.top = g.top > 0 ? 0 : g.top < this.maxScrollY ? this.maxScrollY : g.top, b = void 0 === b || null === b || "auto" === b ? c.max(c.abs(this.x - g.left), c.abs(this.y - g.top)) : b, this.scrollTo(g.left, g.top, b, f)
                }
            },
            _transitionTime: function(a) {
                if (a = a || 0, this.scrollerStyle[h.style.transitionDuration] = a + "ms", !a && h.isBadAndroid && (this.scrollerStyle[h.style.transitionDuration] = "0.001s"), this.indicators)
                    for (var b = this.indicators.length; b--;) this.indicators[b].transitionTime(a)
            },
            _transitionTimingFunction: function(a) {
                if (this.scrollerStyle[h.style.transitionTimingFunction] = a, this.indicators)
                    for (var b = this.indicators.length; b--;) this.indicators[b].transitionTimingFunction(a)
            },
            _translate: function(a, b) {
                if (this.options.useTransform ? this.scrollerStyle[h.style.transform] = "translate(" + a + "px," + b + "px)" + this.translateZ : (a = c.round(a), b = c.round(b), this.scrollerStyle.left = a + "px", this.scrollerStyle.top = b + "px"), this.x = a, this.y = b, this.indicators)
                    for (var d = this.indicators.length; d--;) this.indicators[d].updatePosition()
            },
            _initEvents: function(b) {
                var c = b ? h.removeEvent : h.addEvent,
                    d = this.options.bindToWrapper ? this.wrapper : a;
                c(a, "orientationchange", this), c(a, "resize", this), this.options.click && c(this.wrapper, "click", this, !0), this.options.disableMouse || (c(this.wrapper, "mousedown", this), c(d, "mousemove", this), c(d, "mousecancel", this), c(d, "mouseup", this)), h.hasPointer && !this.options.disablePointer && (c(this.wrapper, "MSPointerDown", this), c(d, "MSPointerMove", this), c(d, "MSPointerCancel", this), c(d, "MSPointerUp", this)), h.hasTouch && !this.options.disableTouch && (c(this.wrapper, "touchstart", this), c(d, "touchmove", this), c(d, "touchcancel", this), c(d, "touchend", this)), c(this.scroller, "transitionend", this), c(this.scroller, "webkitTransitionEnd", this), c(this.scroller, "oTransitionEnd", this), c(this.scroller, "MSTransitionEnd", this)
            },
            getComputedPosition: function() {
                var b, c, d = a.getComputedStyle(this.scroller, null);
                return this.options.useTransform ? (d = d[h.style.transform].split(")")[0].split(", "), b = +(d[12] || d[4]), c = +(d[13] || d[5])) : (b = +d.left.replace(/[^-\d.]/g, ""), c = +d.top.replace(/[^-\d.]/g, "")), {
                    x: b,
                    y: c
                }
            },
            _initIndicators: function() {
                function a(a) {
                    for (var b = h.indicators.length; b--;) a.call(h.indicators[b])
                }
                var b, c = this.options.interactiveScrollbars,
                    d = "string" != typeof this.options.scrollbars,
                    g = [],
                    h = this;
                this.indicators = [], this.options.scrollbars && (this.options.scrollY && (b = {
                    el: e("v", c, this.options.scrollbars),
                    interactive: c,
                    defaultScrollbars: !0,
                    customStyle: d,
                    resize: this.options.resizeScrollbars,
                    shrink: this.options.shrinkScrollbars,
                    fade: this.options.fadeScrollbars,
                    listenX: !1
                }, this.wrapper.appendChild(b.el), g.push(b)), this.options.scrollX && (b = {
                    el: e("h", c, this.options.scrollbars),
                    interactive: c,
                    defaultScrollbars: !0,
                    customStyle: d,
                    resize: this.options.resizeScrollbars,
                    shrink: this.options.shrinkScrollbars,
                    fade: this.options.fadeScrollbars,
                    listenY: !1
                }, this.wrapper.appendChild(b.el), g.push(b))), this.options.indicators && (g = g.concat(this.options.indicators));
                for (var i = g.length; i--;) this.indicators.push(new f(this, g[i]));
                this.options.fadeScrollbars && (this.on("scrollEnd", function() {
                    a(function() {
                        this.fade()
                    })
                }), this.on("scrollCancel", function() {
                    a(function() {
                        this.fade()
                    })
                }), this.on("scrollStart", function() {
                    a(function() {
                        this.fade(1)
                    })
                }), this.on("beforeScrollStart", function() {
                    a(function() {
                        this.fade(1, !0)
                    })
                })), this.on("refresh", function() {
                    a(function() {
                        this.refresh()
                    })
                }), this.on("destroy", function() {
                    a(function() {
                        this.destroy()
                    }), delete this.indicators
                })
            },
            _initWheel: function() {
                h.addEvent(this.wrapper, "wheel", this), h.addEvent(this.wrapper, "mousewheel", this), h.addEvent(this.wrapper, "DOMMouseScroll", this), this.on("destroy", function() {
                    h.removeEvent(this.wrapper, "wheel", this), h.removeEvent(this.wrapper, "mousewheel", this), h.removeEvent(this.wrapper, "DOMMouseScroll", this)
                })
            },
            _wheel: function(a) {
                if (this.enabled) {
                    a.preventDefault(), a.stopPropagation();
                    var b, d, e, f, g = this;
                    if (void 0 === this.wheelTimeout && g._execEvent("scrollStart"), clearTimeout(this.wheelTimeout), this.wheelTimeout = setTimeout(function() {
                            g._execEvent("scrollEnd"), g.wheelTimeout = void 0
                        }, 400), "deltaX" in a) b = -a.deltaX, d = -a.deltaY;
                    else if ("wheelDeltaX" in a) b = a.wheelDeltaX / 120 * this.options.mouseWheelSpeed, d = a.wheelDeltaY / 120 * this.options.mouseWheelSpeed;
                    else if ("wheelDelta" in a) b = d = a.wheelDelta / 120 * this.options.mouseWheelSpeed;
                    else {
                        if (!("detail" in a)) return;
                        b = d = -a.detail / 3 * this.options.mouseWheelSpeed
                    }
                    if (b *= this.options.invertWheelDirection, d *= this.options.invertWheelDirection, this.hasVerticalScroll || (b = d, d = 0), this.options.snap) return e = this.currentPage.pageX, f = this.currentPage.pageY, b > 0 ? e-- : 0 > b && e++, d > 0 ? f-- : 0 > d && f++, void this.goToPage(e, f);
                    e = this.x + c.round(this.hasHorizontalScroll ? b : 0), f = this.y + c.round(this.hasVerticalScroll ? d : 0), e > 0 ? e = 0 : e < this.maxScrollX && (e = this.maxScrollX), f > 0 ? f = 0 : f < this.maxScrollY && (f = this.maxScrollY), this.scrollTo(e, f, 0)
                }
            },
            _initSnap: function() {
                this.currentPage = {}, "string" == typeof this.options.snap && (this.options.snap = this.scroller.querySelectorAll(this.options.snap)), this.on("refresh", function() {
                    var a, b, d, e, f, g, h = 0,
                        i = 0,
                        j = 0,
                        k = this.options.snapStepX || this.wrapperWidth,
                        l = this.options.snapStepY || this.wrapperHeight;
                    if (this.pages = [], this.wrapperWidth && this.wrapperHeight && this.scrollerWidth && this.scrollerHeight) {
                        if (this.options.snap === !0)
                            for (d = c.round(k / 2), e = c.round(l / 2); j > -this.scrollerWidth;) {
                                for (this.pages[h] = [], a = 0, f = 0; f > -this.scrollerHeight;) this.pages[h][a] = {
                                    x: c.max(j, this.maxScrollX),
                                    y: c.max(f, this.maxScrollY),
                                    width: k,
                                    height: l,
                                    cx: j - d,
                                    cy: f - e
                                }, f -= l, a++;
                                j -= k, h++
                            } else
                            for (g = this.options.snap, a = g.length, b = -1; a > h; h++)(0 === h || g[h].offsetLeft <= g[h - 1].offsetLeft) && (i = 0, b++), this.pages[i] || (this.pages[i] = []), j = c.max(-g[h].offsetLeft, this.maxScrollX), f = c.max(-g[h].offsetTop, this.maxScrollY), d = j - c.round(g[h].offsetWidth / 2), e = f - c.round(g[h].offsetHeight / 2), this.pages[i][b] = {
                                x: j,
                                y: f,
                                width: g[h].offsetWidth,
                                height: g[h].offsetHeight,
                                cx: d,
                                cy: e
                            }, j > this.maxScrollX && i++;
                        this.goToPage(this.currentPage.pageX || 0, this.currentPage.pageY || 0, 0), this.options.snapThreshold % 1 === 0 ? (this.snapThresholdX = this.options.snapThreshold, this.snapThresholdY = this.options.snapThreshold) : (this.snapThresholdX = c.round(this.pages[this.currentPage.pageX][this.currentPage.pageY].width * this.options.snapThreshold), this.snapThresholdY = c.round(this.pages[this.currentPage.pageX][this.currentPage.pageY].height * this.options.snapThreshold))
                    }
                }), this.on("flick", function() {
                    var a = this.options.snapSpeed || c.max(c.max(c.min(c.abs(this.x - this.startX), 1e3), c.min(c.abs(this.y - this.startY), 1e3)), 300);
                    this.goToPage(this.currentPage.pageX + this.directionX, this.currentPage.pageY + this.directionY, a)
                })
            },
            _nearestSnap: function(a, b) {
                if (!this.pages.length) return {
                    x: 0,
                    y: 0,
                    pageX: 0,
                    pageY: 0
                };
                var d = 0,
                    e = this.pages.length,
                    f = 0;
                if (c.abs(a - this.absStartX) < this.snapThresholdX && c.abs(b - this.absStartY) < this.snapThresholdY) return this.currentPage;
                for (a > 0 ? a = 0 : a < this.maxScrollX && (a = this.maxScrollX), b > 0 ? b = 0 : b < this.maxScrollY && (b = this.maxScrollY); e > d; d++)
                    if (a >= this.pages[d][0].cx) {
                        a = this.pages[d][0].x;
                        break
                    }
                for (e = this.pages[d].length; e > f; f++)
                    if (b >= this.pages[0][f].cy) {
                        b = this.pages[0][f].y;
                        break
                    }
                return d == this.currentPage.pageX && (d += this.directionX, 0 > d ? d = 0 : d >= this.pages.length && (d = this.pages.length - 1), a = this.pages[d][0].x), f == this.currentPage.pageY && (f += this.directionY, 0 > f ? f = 0 : f >= this.pages[0].length && (f = this.pages[0].length - 1), b = this.pages[0][f].y), {
                    x: a,
                    y: b,
                    pageX: d,
                    pageY: f
                }
            },
            goToPage: function(a, b, d, e) {
                e = e || this.options.bounceEasing, a >= this.pages.length ? a = this.pages.length - 1 : 0 > a && (a = 0), b >= this.pages[a].length ? b = this.pages[a].length - 1 : 0 > b && (b = 0);
                var f = this.pages[a][b].x,
                    g = this.pages[a][b].y;
                d = void 0 === d ? this.options.snapSpeed || c.max(c.max(c.min(c.abs(f - this.x), 1e3), c.min(c.abs(g - this.y), 1e3)), 300) : d, this.currentPage = {
                    x: f,
                    y: g,
                    pageX: a,
                    pageY: b
                }, this.scrollTo(f, g, d, e)
            },
            next: function(a, b) {
                var c = this.currentPage.pageX,
                    d = this.currentPage.pageY;
                c++, c >= this.pages.length && this.hasVerticalScroll && (c = 0, d++), this.goToPage(c, d, a, b)
            },
            prev: function(a, b) {
                var c = this.currentPage.pageX,
                    d = this.currentPage.pageY;
                c--, 0 > c && this.hasVerticalScroll && (c = 0, d--), this.goToPage(c, d, a, b)
            },
            _initKeys: function() {
                var b, c = {
                    pageUp: 33,
                    pageDown: 34,
                    end: 35,
                    home: 36,
                    left: 37,
                    up: 38,
                    right: 39,
                    down: 40
                };
                if ("object" == typeof this.options.keyBindings)
                    for (b in this.options.keyBindings) "string" == typeof this.options.keyBindings[b] && (this.options.keyBindings[b] = this.options.keyBindings[b].toUpperCase().charCodeAt(0));
                else this.options.keyBindings = {};
                for (b in c) this.options.keyBindings[b] = this.options.keyBindings[b] || c[b];
                h.addEvent(a, "keydown", this), this.on("destroy", function() {
                    h.removeEvent(a, "keydown", this)
                })
            },
            _key: function(a) {
                if (this.enabled) {
                    var b, d = this.options.snap,
                        e = d ? this.currentPage.pageX : this.x,
                        f = d ? this.currentPage.pageY : this.y,
                        g = h.getTime(),
                        i = this.keyTime || 0,
                        j = .25;
                    switch (this.options.useTransition && this.isInTransition && (b = this.getComputedPosition(), this._translate(c.round(b.x), c.round(b.y)), this.isInTransition = !1), this.keyAcceleration = 200 > g - i ? c.min(this.keyAcceleration + j, 50) : 0, a.keyCode) {
                        case this.options.keyBindings.pageUp:
                            this.hasHorizontalScroll && !this.hasVerticalScroll ? e += d ? 1 : this.wrapperWidth : f += d ? 1 : this.wrapperHeight;
                            break;
                        case this.options.keyBindings.pageDown:
                            this.hasHorizontalScroll && !this.hasVerticalScroll ? e -= d ? 1 : this.wrapperWidth : f -= d ? 1 : this.wrapperHeight;
                            break;
                        case this.options.keyBindings.end:
                            e = d ? this.pages.length - 1 : this.maxScrollX, f = d ? this.pages[0].length - 1 : this.maxScrollY;
                            break;
                        case this.options.keyBindings.home:
                            e = 0, f = 0;
                            break;
                        case this.options.keyBindings.left:
                            e += d ? -1 : 5 + this.keyAcceleration >> 0;
                            break;
                        case this.options.keyBindings.up:
                            f += d ? 1 : 5 + this.keyAcceleration >> 0;
                            break;
                        case this.options.keyBindings.right:
                            e -= d ? -1 : 5 + this.keyAcceleration >> 0;
                            break;
                        case this.options.keyBindings.down:
                            f -= d ? 1 : 5 + this.keyAcceleration >> 0;
                            break;
                        default:
                            return
                    }
                    if (d) return void this.goToPage(e, f);
                    e > 0 ? (e = 0, this.keyAcceleration = 0) : e < this.maxScrollX && (e = this.maxScrollX, this.keyAcceleration = 0), f > 0 ? (f = 0, this.keyAcceleration = 0) : f < this.maxScrollY && (f = this.maxScrollY, this.keyAcceleration = 0), this.scrollTo(e, f, 0), this.keyTime = g
                }
            },
            _animate: function(a, b, c, d) {
                function e() {
                    var m, n, o, p = h.getTime();
                    return p >= l ? (f.isAnimating = !1, f._translate(a, b), void(f.resetPosition(f.options.bounceTime) || f._execEvent("scrollEnd"))) : (p = (p - k) / c, o = d(p), m = (a - i) * o + i, n = (b - j) * o + j, f._translate(m, n), void(f.isAnimating && g(e)))
                }
                var f = this,
                    i = this.x,
                    j = this.y,
                    k = h.getTime(),
                    l = k + c;
                this.isAnimating = !0, e()
            },
            handleEvent: function(a) {
                switch (a.type) {
                    case "touchstart":
                    case "MSPointerDown":
                    case "mousedown":
                        this._start(a);
                        break;
                    case "touchmove":
                    case "MSPointerMove":
                    case "mousemove":
                        this._move(a);
                        break;
                    case "touchend":
                    case "MSPointerUp":
                    case "mouseup":
                    case "touchcancel":
                    case "MSPointerCancel":
                    case "mousecancel":
                        this._end(a);
                        break;
                    case "orientationchange":
                    case "resize":
                        this._resize();
                        break;
                    case "transitionend":
                    case "webkitTransitionEnd":
                    case "oTransitionEnd":
                    case "MSTransitionEnd":
                        this._transitionEnd(a);
                        break;
                    case "wheel":
                    case "DOMMouseScroll":
                    case "mousewheel":
                        this._wheel(a);
                        break;
                    case "keydown":
                        this._key(a);
                        break;
                    case "click":
                        a._constructed || (a.preventDefault(), a.stopPropagation())
                }
            }
        }, f.prototype = {
            handleEvent: function(a) {
                switch (a.type) {
                    case "touchstart":
                    case "MSPointerDown":
                    case "mousedown":
                        this._start(a);
                        break;
                    case "touchmove":
                    case "MSPointerMove":
                    case "mousemove":
                        this._move(a);
                        break;
                    case "touchend":
                    case "MSPointerUp":
                    case "mouseup":
                    case "touchcancel":
                    case "MSPointerCancel":
                    case "mousecancel":
                        this._end(a)
                }
            },
            destroy: function() {
                this.options.interactive && (h.removeEvent(this.indicator, "touchstart", this), h.removeEvent(this.indicator, "MSPointerDown", this), h.removeEvent(this.indicator, "mousedown", this), h.removeEvent(a, "touchmove", this), h.removeEvent(a, "MSPointerMove", this), h.removeEvent(a, "mousemove", this), h.removeEvent(a, "touchend", this), h.removeEvent(a, "MSPointerUp", this), h.removeEvent(a, "mouseup", this)), this.options.defaultScrollbars && this.wrapper.parentNode.removeChild(this.wrapper)
            },
            _start: function(b) {
                var c = b.touches ? b.touches[0] : b;
                b.preventDefault(), b.stopPropagation(), this.transitionTime(), this.initiated = !0, this.moved = !1, this.lastPointX = c.pageX, this.lastPointY = c.pageY, this.startTime = h.getTime(), this.options.disableTouch || h.addEvent(a, "touchmove", this), this.options.disablePointer || h.addEvent(a, "MSPointerMove", this), this.options.disableMouse || h.addEvent(a, "mousemove", this), this.scroller._execEvent("beforeScrollStart")
            },
            _move: function(a) {
                {
                    var b, c, d, e, f = a.touches ? a.touches[0] : a;
                    h.getTime()
                }
                this.moved || this.scroller._execEvent("scrollStart"), this.moved = !0, b = f.pageX - this.lastPointX, this.lastPointX = f.pageX, c = f.pageY - this.lastPointY, this.lastPointY = f.pageY, d = this.x + b, e = this.y + c, this._pos(d, e), a.preventDefault(), a.stopPropagation()
            },
            _end: function(b) {
                if (this.initiated) {
                    if (this.initiated = !1, b.preventDefault(), b.stopPropagation(), h.removeEvent(a, "touchmove", this), h.removeEvent(a, "MSPointerMove", this), h.removeEvent(a, "mousemove", this), this.scroller.options.snap) {
                        var d = this.scroller._nearestSnap(this.scroller.x, this.scroller.y),
                            e = this.options.snapSpeed || c.max(c.max(c.min(c.abs(this.scroller.x - d.x), 1e3), c.min(c.abs(this.scroller.y - d.y), 1e3)), 300);
                        (this.scroller.x != d.x || this.scroller.y != d.y) && (this.scroller.directionX = 0, this.scroller.directionY = 0, this.scroller.currentPage = d, this.scroller.scrollTo(d.x, d.y, e, this.scroller.options.bounceEasing))
                    }
                    this.moved && this.scroller._execEvent("scrollEnd")
                }
            },
            transitionTime: function(a) {
                a = a || 0, this.indicatorStyle[h.style.transitionDuration] = a + "ms", !a && h.isBadAndroid && (this.indicatorStyle[h.style.transitionDuration] = "0.001s")
            },
            transitionTimingFunction: function(a) {
                this.indicatorStyle[h.style.transitionTimingFunction] = a
            },
            refresh: function() {
                this.transitionTime(), this.indicatorStyle.display = this.options.listenX && !this.options.listenY ? this.scroller.hasHorizontalScroll ? "block" : "none" : this.options.listenY && !this.options.listenX ? this.scroller.hasVerticalScroll ? "block" : "none" : this.scroller.hasHorizontalScroll || this.scroller.hasVerticalScroll ? "block" : "none", this.scroller.hasHorizontalScroll && this.scroller.hasVerticalScroll ? (h.addClass(this.wrapper, "iScrollBothScrollbars"), h.removeClass(this.wrapper, "iScrollLoneScrollbar"), this.options.defaultScrollbars && this.options.customStyle && (this.options.listenX ? this.wrapper.style.right = "8px" : this.wrapper.style.bottom = "8px")) : (h.removeClass(this.wrapper, "iScrollBothScrollbars"), h.addClass(this.wrapper, "iScrollLoneScrollbar"), this.options.defaultScrollbars && this.options.customStyle && (this.options.listenX ? this.wrapper.style.right = "2px" : this.wrapper.style.bottom = "2px"));
                this.wrapper.offsetHeight;
                this.options.listenX && (this.wrapperWidth = this.wrapper.clientWidth, this.options.resize ? (this.indicatorWidth = c.max(c.round(this.wrapperWidth * this.wrapperWidth / (this.scroller.scrollerWidth || this.wrapperWidth || 1)), 8), this.indicatorStyle.width = this.indicatorWidth + "px") : this.indicatorWidth = this.indicator.clientWidth, this.maxPosX = this.wrapperWidth - this.indicatorWidth, "clip" == this.options.shrink ? (this.minBoundaryX = -this.indicatorWidth + 8, this.maxBoundaryX = this.wrapperWidth - 8) : (this.minBoundaryX = 0, this.maxBoundaryX = this.maxPosX), this.sizeRatioX = this.options.speedRatioX || this.scroller.maxScrollX && this.maxPosX / this.scroller.maxScrollX), this.options.listenY && (this.wrapperHeight = this.wrapper.clientHeight, this.options.resize ? (this.indicatorHeight = c.max(c.round(this.wrapperHeight * this.wrapperHeight / (this.scroller.scrollerHeight || this.wrapperHeight || 1)), 8), this.indicatorStyle.height = this.indicatorHeight + "px") : this.indicatorHeight = this.indicator.clientHeight, this.maxPosY = this.wrapperHeight - this.indicatorHeight, "clip" == this.options.shrink ? (this.minBoundaryY = -this.indicatorHeight + 8, this.maxBoundaryY = this.wrapperHeight - 8) : (this.minBoundaryY = 0, this.maxBoundaryY = this.maxPosY), this.maxPosY = this.wrapperHeight - this.indicatorHeight, this.sizeRatioY = this.options.speedRatioY || this.scroller.maxScrollY && this.maxPosY / this.scroller.maxScrollY), this.updatePosition()
            },
            updatePosition: function() {
                var a = this.options.listenX && c.round(this.sizeRatioX * this.scroller.x) || 0,
                    b = this.options.listenY && c.round(this.sizeRatioY * this.scroller.y) || 0;
                this.options.ignoreBoundaries || (a < this.minBoundaryX ? ("scale" == this.options.shrink && (this.width = c.max(this.indicatorWidth + a, 8), this.indicatorStyle.width = this.width + "px"), a = this.minBoundaryX) : a > this.maxBoundaryX ? "scale" == this.options.shrink ? (this.width = c.max(this.indicatorWidth - (a - this.maxPosX), 8), this.indicatorStyle.width = this.width + "px", a = this.maxPosX + this.indicatorWidth - this.width) : a = this.maxBoundaryX : "scale" == this.options.shrink && this.width != this.indicatorWidth && (this.width = this.indicatorWidth, this.indicatorStyle.width = this.width + "px"), b < this.minBoundaryY ? ("scale" == this.options.shrink && (this.height = c.max(this.indicatorHeight + 3 * b, 8), this.indicatorStyle.height = this.height + "px"), b = this.minBoundaryY) : b > this.maxBoundaryY ? "scale" == this.options.shrink ? (this.height = c.max(this.indicatorHeight - 3 * (b - this.maxPosY), 8), this.indicatorStyle.height = this.height + "px", b = this.maxPosY + this.indicatorHeight - this.height) : b = this.maxBoundaryY : "scale" == this.options.shrink && this.height != this.indicatorHeight && (this.height = this.indicatorHeight, this.indicatorStyle.height = this.height + "px")), this.x = a, this.y = b, this.scroller.options.useTransform ? this.indicatorStyle[h.style.transform] = "translate(" + a + "px," + b + "px)" + this.scroller.translateZ : (this.indicatorStyle.left = a + "px", this.indicatorStyle.top = b + "px")
            },
            _pos: function(a, b) {
                0 > a ? a = 0 : a > this.maxPosX && (a = this.maxPosX), 0 > b ? b = 0 : b > this.maxPosY && (b = this.maxPosY), a = this.options.listenX ? c.round(a / this.sizeRatioX) : this.scroller.x, b = this.options.listenY ? c.round(b / this.sizeRatioY) : this.scroller.y, this.scroller.scrollTo(a, b)
            },
            fade: function(a, b) {
                if (!b || this.visible) {
                    clearTimeout(this.fadeTimeout), this.fadeTimeout = null;
                    var c = a ? 250 : 500,
                        d = a ? 0 : 300;
                    a = a ? "1" : "0", this.wrapperStyle[h.style.transitionDuration] = c + "ms", this.fadeTimeout = setTimeout(function(a) {
                        this.wrapperStyle.opacity = a, this.visible = +a
                    }.bind(this, a), d)
                }
            }
        }, d.utils = h, "undefined" != typeof module && module.exports ? module.exports = d : a.IScroll = d
    }(window, document, Math);

(function() {
    LanderApp.MainNavbar = function() {
        return this._scroller = null, this._wheight = null, this
    }, LanderApp.MainNavbar.prototype.init = function() {
        var a;
        return this.$navbar = $("#main-navbar"), this.$header = this.$navbar.find(".navbar-header"), this.$toggle = this.$navbar.find(".navbar-toggle:first"), this.$collapse = $("#main-navbar-collapse"), this.$collapse_div = this.$collapse.find("> div"), a = !1, $(window).on("pa.screen.small pa.screen.tablet", function(b) {
            return function() {
                return null === b._scroller && "fixed" === b.$navbar.css("position") && b._setupScroller(), a = !0
            }
        }(this)).on("pa.screen.desktop", function(b) {
            return function() {
                return null !== b._scroller && b._removeScroller(), a = !1
            }
        }(this)), this.$navbar.on("click", ".nav-icon-btn.dropdown > .dropdown-toggle", function(b) {
            return a ? (b.preventDefault(), b.stopPropagation(), document.location.href = $(this).attr("href"), !1) : void 0
        })
    }, LanderApp.MainNavbar.prototype._setupScroller = function() {
        return null === this._scroller ? ($("html").hasClass("gt-ie8") ? (this._scroller = new IScroll("#" + this.$collapse.attr("id"), {
            scrollbars: !0,
            mouseWheel: !0,
            preventDefault: !1
        }), this.$navbar.on("mousedown.mn_collapse", $.proxy(this._mousedownCallback, this)).on("mousemove.mn_collapse", $.proxy(this._mousemoveCallback, this)).on("mouseup.mn_collapse", $.proxy(this._mouseupCallback, this)).on("touchstart.mn_collapse touchmove.mn_collapse", function(a) {
            return a.preventDefault()
        })) : this._scroller = !0, this.$navbar.on("shown.bs.collapse.mn_collapse", $.proxy(function(a) {
            return function() {
                return a._updateCollapseHeight(), a._watchWindowHeight()
            }
        }(this), this)).on("hidden.bs.collapse.mn_collapse", $.proxy(function(a) {
            return function() {
                return a._wheight = null
            }
        }(this), this)).on("shown.bs.dropdown.mn_collapse", $.proxy(this._updateCollapseHeight, this)).on("hidden.bs.dropdown.mn_collapse", $.proxy(this._updateCollapseHeight, this)), this._updateCollapseHeight()) : void 0
    }, LanderApp.MainNavbar.prototype._removeScroller = function() {
        return null !== this._scroller ? (this._wheight = null, this._scroller !== !0 && (this._scroller.destroy(), this.$navbar.off("mousedown.mn_collapse").off("mousemove.mn_collapse").off("mouseup.mn_collapse").off("touchstart.mn_collapse touchmove.mn_collapse")), this._scroller = null, this.$navbar.off("shown.bs.collapse.mn_collapse").off("hidden.bs.collapse.mn_collapse").off("shown.bs.dropdown.mn_collapse").off("hidden.bs.dropdown.mn_collapse"), this.$collapse.attr("style", "")) : void 0
    }, LanderApp.MainNavbar.prototype._mousedownCallback = function(a) {
        return $(a.target).is("input") ? void 0 : (this._isMousePressed = !0, a.preventDefault())
    }, LanderApp.MainNavbar.prototype._mousemoveCallback = function(a) {
        return this._isMousePressed ? a.preventDefault() : void 0
    }, LanderApp.MainNavbar.prototype._mouseupCallback = function(a) {
        return this._isMousePressed ? (this._isMousePressed = !1, a.preventDefault()) : void 0
    }, LanderApp.MainNavbar.prototype._updateCollapseHeight = function() {
        var a, b;
        if (null !== this._scroller) return b = $(window).innerHeight(), a = this.$header.outerHeight(), a + this.$collapse_div.outerHeight() > b ? (this.$collapse.css("height", b - a), this._scroller !== !0 ? this._scroller.refresh() : this.$collapse.css("overflow", "scroll")) : (this.$collapse.attr("style", ""), this._scroller !== !0 ? this._scroller.refresh() : void 0)
    }, LanderApp.MainNavbar.prototype._watchWindowHeight = function() {
        var a;
        return this._wheight = $(window).innerHeight(), a = function(b) {
            return function() {
                return null !== b._wheight ? (b._wheight !== $(window).innerHeight() && b._updateCollapseHeight(), b._wheight = $(window).innerHeight(), setTimeout(a, 100)) : void 0
            }
        }(this), window.setTimeout(a, 100)
    }, LanderApp.MainNavbar.Constructor = LanderApp.MainNavbar, LanderApp.addInitializer(function() {
        return LanderApp.initPlugin("main_navbar", new LanderApp.MainNavbar)
    })
}).call(this);
(function() {
        LanderApp.MainMenu = function() {
            return this._scroller = null, this._screen = null, this._last_screen = null, this._$dropdown = null, this
        }, LanderApp.MainMenu.prototype.init = function() {
            var a, b, c, d;
            return this.$window = $(window), this.$body = $("body"), this.$menu = $("#main-menu"), this.$animation_timer = null, this.$menu.length ? (LanderApp.settings.main_menu.store_state && (d = this._getMenuState(), null !== d && ("collapsed" === d ? (this.$body.addClass("mm-no-transition").addClass("mmc"), setTimeout(function(a) {
                return function() {
                    return a.$body.removeClass("mm-no-transition")
                }
            }(this), 20)) : (this.$body.addClass("mm-no-transition").removeClass("mmc"), setTimeout(function(a) {
                return function() {
                    return a.$body.removeClass("mm-no-transition")
                }
            }(this), 20)))), a = $("#small-screen-width-point"), b = $("#tablet-screen-width-point"), c = this, this._screen = getScreenSize(a, b), this._last_screen = this._screen, this.turnOnAnimation(!0), this.$window.on("pa.loaded", function() {
                return function() {
                    return $("#main-menu .navigation > li > a > .mm-text").removeClass("no-animation"), $("#main-menu .navigation > .mm-dropdown > ul").removeClass("no-animation"), $("#main-menu .menu-content").removeClass("no-animation")
                }
            }(this)), this.$window.on("resize.pa.mm", function(c) {
                return function() {
                    return c._last_screen = c._screen, c._screen = getScreenSize(a, b), c.closeCurrentDropdown(!0), "small" === c._screen && c._last_screen !== c._screen || "tablet" === c._screen && "small" === c._last_screen ? (c.$body.addClass("mm-no-transition"), setTimeout(function() {
                        return c.$body.removeClass("mm-no-transition")
                    }, 20)) : void 0
                }
            }(this)), this.animation_end = function(a) {
                return function() {
                    return a.$animation_timer && (window.clearTimeout(a.$animation_timer), a.$animation_timer = null), a.$animation_timer = window.setTimeout(function() {
                        return a.$menu.off("transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd"), $(window).trigger("resize")
                    }, 200)
                }
            }(this), this.$window.on("click.pa.mm", function(a) {
                return function() {
                    return a.closeCurrentDropdown(!0)
                }
            }(this)), $(window).on("pa.screen.small", function(a) {
                return function() {
                    return null === a._scroller ? a._setupScroller() : void 0
                }
            }(this)).on("pa.screen.tablet pa.screen.desktop", function(a) {
                return function() {
                    if ("fixed" === a.$menu.css("position")) {
                        if (null === a._scroller) return a._setupScroller()
                    } else if (null !== a._scroller) return a._removeScroller()
                }
            }(this)), this.$menu.find(".navigation > .mm-dropdown").addClass("mm-dropdown-root"), this.$menu.on("click.pa.mm-dropdown", ".mm-dropdown > a", function() {
                var a;
                return a = $(this).parent(".mm-dropdown"), a.hasClass("mm-dropdown-root") && c._collapsed() ? a.hasClass("mmc-dropdown-open") ? a.hasClass("freeze") ? c.closeCurrentDropdown(!0) : c.freezeDropdown(a) : c.openDropdown(a, !0) : a.hasClass("open") ? c.collapseSubmenu(a, !0) : (LanderApp.settings.main_menu.accordion && c.collapseAllSubmenus(a), c.expandSubmenu(a, !0)), !1
            }), this.$menu.find(".navigation").on("mouseenter.pa.mm-dropdown", ".mm-dropdown-root", function() {
                return !c._collapsed() || c._$dropdown && c._$dropdown.hasClass("freeze") ? void 0 : c.openDropdown($(this))
            }).on("mouseleave.pa.mm-dropdown", ".mm-dropdown-root", function() {
                return c.closeCurrentDropdown()
            }), $("#main-menu-toggle").on("click.pa.mm_toggle", function(c) {
                return function() {
                    return c._screen = getScreenSize(a, b), "small" === c._screen || "tablet" === c._screen ? ($("#main-navbar-collapse").removeClass("in").removeClass("collapsing").stop().addClass("collapse").css("height", "0px"), $("#main-navbar .navbar-toggle").addClass("collapsed"), c.$body.removeClass("mm-no-transition").toggleClass("mme")) : (c.$body.toggleClass("mmc"), LanderApp.settings.main_menu.store_state && c._storeMenuState(c.$body.hasClass("mmc")), $.support.transition ? c.$menu.on("transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd", $.proxy(c.animation_end, c)) : $(window).trigger("resize")), c._scroller ? setTimeout($.proxy(c._updateScroller, c), 100) : void 0
                }
            }(this))) : void 0
        }, LanderApp.MainMenu.prototype._collapsed = function() {
            return "tablet" === this._screen && !this.$body.hasClass("mme") || "desktop" === this._screen && this.$body.hasClass("mmc")
        }, LanderApp.MainMenu.prototype._setupScroller = function() {
            return null === this._scroller ? ($("html").hasClass("gt-ie8") ? (this._scroller = new IScroll("#" + this.$menu.attr("id"), {
                mouseWheel: !0
            }), this._scroller.on("scrollStart", function(a) {
                return function() {
                    return a.closeCurrentDropdown(!0)
                }
            }(this))) : this._scroller = !0, $(window).on("pa.resize.mm", $.proxy(this._updateScroller, this)), this._updateScroller()) : void 0
        }, LanderApp.MainMenu.prototype._removeScroller = function() {
            return null !== this._scroller ? (this._scroller !== !0 && this._scroller.destroy(), this._scroller = null, $(window).off("pa.resize.mm"), this.$menu.attr("style", "")) : void 0
        }, LanderApp.MainMenu.prototype._updateScroller = function() {
            return null !== this._scroller ? this._scroller !== !0 ? this._scroller.refresh() : this.$menu.find("> div").outerHeight() > this.$menu.outerHeight() ? this.$menu.css({
                "overflow-y": "scroll",
                "overflow-y": "scroll",
                "-ms-overflow-x": "hidden",
                "overflow-x": "hidden"
            }) : this.$menu.attr("style", "") : void 0
        }, LanderApp.MainMenu.prototype._updateDropdownScroller = function(a) {
            var b, c;
            return b = a.parents(".mmc-dropdown-open"), b.length && (c = b.data("scroller"), c && c !== !0) ? c.refresh() : void 0
        }, LanderApp.MainMenu.prototype._getSubmenuHeight = function(a) {
            var b;
            return a.parent(".mm-dropdown").hasClass("open") ? b = a.height() : (b = a.addClass("get-height").height(), a.removeClass("get-height")), b
        }, LanderApp.MainMenu.prototype.collapseSubmenu = function(a, b) {
            var c;
            return c = $("> ul", a), c.animate({
                height: 0
            }, LanderApp.settings.main_menu.animation_speed, function(d) {
                return function() {
                    return a.removeClass("open"), c.css({
                        display: "none",
                        height: "auto"
                    }), $(".mm-dropdown.open", a).removeClass("open").find("> ul").css({
                        display: "none",
                        height: "auto"
                    }), b && d._updateScroller(), d._updateDropdownScroller(a)
                }
            }(this))
        }, LanderApp.MainMenu.prototype.collapseAllSubmenus = function(a, b) {
            var c;
            return null == b && (b = !1), c = this, a.parent().find("> .mm-dropdown.open").each(function() {
                return b && $(this).is(a) ? void 0 : c.collapseSubmenu($(this))
            })
        }, LanderApp.MainMenu.prototype.expandSubmenu = function(a, b) {
            var c, d;
            return d = $("> ul", a), c = this._getSubmenuHeight(d), d.css({
                display: "block",
                height: 0
            }), a.addClass("open"), d.animate({
                height: c
            }, LanderApp.settings.main_menu.animation_speed, function(c) {
                return function() {
                    return d.attr("style", ""), b && c._updateScroller(), c._updateDropdownScroller(a)
                }
            }(this))
        }, LanderApp.MainMenu.prototype.openDropdown = function(a, b) {
            var c, d, e, f, g, h, i, j;
            return null == b && (b = !1), this._$dropdown && this.closeCurrentDropdown(b), this._$dropdown = a, d = $("> ul", a), c = d.find("> .mmc-title"), 0 === c.length && (c = $('<div class="mmc-title"></div>').text($("> a > .mm-text", a).text()), d.prepend(c)), a.addClass("mmc-dropdown-open"), h = function(b) {
                return function(c) {
                    var d;
                    return $("html").hasClass("gt-ie8") ? (d = new IScroll("#mmc-wrapper", {
                        mouseWheel: !0
                    }), b._scroller && null !== b._scroller && (d.on("beforeScrollStart", function() {
                        return b._scroller.disable()
                    }), d.on("scrollEnd", function() {
                        return b._scroller.enable()
                    }))) : (d = !0, c.css({
                        "overflow-y": "scroll",
                        "overflow-y": "scroll",
                        "-ms-overflow-x": "hidden",
                        "overflow-x": "hidden"
                    })), a.data("scroller", d)
                }
            }(this), this.$body.hasClass("main-menu-fixed") && (j = this.$window.innerHeight(), i = a.position().top, g = d.find("> .mmc-title").outerHeight() + 3 * d.find("> li").first().outerHeight(), i + g > j ? (f = i - $("#main-navbar").outerHeight(), a.addClass("top")) : f = j - i - a.outerHeight(), e = $('<div id="mmc-wrapper" style="overflow:hidden;position:relative;max-height:' + f + 'px;"></div>'), e.append($("<div></div>").append(d.find("> li"))).appendTo(d), h(e), a.hasClass("top") && d.append(c)), b ? this.freezeDropdown(a) : void 0
        }, LanderApp.MainMenu.prototype.closeCurrentDropdown = function(a) {
            var b, c;
            return null == a && (a = !1), !this._$dropdown || this._$dropdown.hasClass("freeze") && !a ? void 0 : (b = this._$dropdown.find("> ul"), c = this._$dropdown.data("scroller"), c && (c !== !0 && c.destroy(), this._$dropdown.data("scroller", null), b.append($("#mmc-wrapper > div > li")), $("#mmc-wrapper").remove()), this._scroller && this._scroller !== !0 && this._scroller.enable(), this._$dropdown.removeClass("mmc-dropdown-open freeze top"), this._$dropdown = null)
        }, LanderApp.MainMenu.prototype.freezeDropdown = function(a) {
            return a.addClass("freeze")
        }, LanderApp.MainMenu.prototype.turnOnAnimation = function(a) {
            return null == a && (a = !1), $("#main-menu .navigation > li > a > .mm-text").addClass("mmc-dropdown-delay"), $("#main-menu .navigation > .mm-dropdown > ul").addClass("mmc-dropdown-delay")
        }, LanderApp.MainMenu.prototype._getMenuState = function() {
            return LanderApp.getStoredValue(LanderApp.settings.main_menu.store_state_key, null)
        }, LanderApp.MainMenu.prototype._storeMenuState = function(a) {
            return LanderApp.settings.main_menu.store_state ? LanderApp.storeValue(LanderApp.settings.main_menu.store_state_key, a ? "collapsed" : "expanded") : void 0
        }, LanderApp.MainMenu.Constructor = LanderApp.MainMenu, LanderApp.addInitializer(function() {
            return LanderApp.initPlugin("main_menu", new LanderApp.MainMenu)
        })
}).call(this);

(function() {
    var a;
    a = function(b, c) {
        var d;
        return null == c && (c = {}), this.options = $.extend({}, a.DEFAULTS, c), this.$checkbox = null, this.$box = null, b.is('input[type="checkbox"]') ? (d = b.attr("data-class"), this.$checkbox = b, this.$box = $('<div class="switcher"><div class="switcher-toggler"></div><div class="switcher-inner"><div class="switcher-state-on">' + this.options.on_state_content + '</div><div class="switcher-state-off">' + this.options.off_state_content + "</div></div></div>"), this.options.theme && this.$box.addClass("switcher-theme-" + this.options.theme), d && this.$box.addClass(d), this.$box.insertAfter(this.$checkbox).prepend(this.$checkbox)) : (this.$box = b, this.$checkbox = $('input[type="checkbox"]', this.$box)), this.$checkbox.prop("disabled") && this.$box.addClass("disabled"), this.$checkbox.is(":checked") && this.$box.addClass("checked"), this.$checkbox.on("click", function(a) {
            return a.stopPropagation()
        }), this.$box.on("click", $.proxy(this.toggle, this)), this
    }, a.prototype.enable = function() {
        return this.$checkbox.prop("disabled", !1), this.$box.removeClass("disabled")
    }, a.prototype.disable = function() {
        return this.$checkbox.prop("disabled", !0), this.$box.addClass("disabled")
    }, a.prototype.on = function() {
        return this.$checkbox.is(":checked") ? void 0 : (this.$checkbox.click(), this.$box.addClass("checked"))
    }, a.prototype.off = function() {
        return this.$checkbox.is(":checked") ? (this.$checkbox.click(), this.$box.removeClass("checked")) : void 0
    }, a.prototype.toggle = function() {
        //return this.$checkbox.click().is(":checked") ? this.$box.addClass("checked") : this.$box.removeClass("checked")
        if (this.$checkbox.click().is(":checked")) {
            this.$box.addClass("checked");
            $("#problemlist").removeClass("col-sm-12").addClass("col-sm-10");
            $("#taglist").removeClass("collapse").addClass("col-sm-2");
        } else {
            this.$box.removeClass("checked");
            $("#problemlist").removeClass("col-sm-10").addClass("col-sm-12");
            $("#taglist").removeClass("col-sm-2").addClass("collapse");
        }
    }, a.DEFAULTS = {
        theme: null,
        on_state_content: "ON",
        off_state_content: "OFF"
    }, $.fn.switcher = function(b) {
        return $(this).each(function() {
            var c, d;
            return c = $(this), d = $.data(this, "Switcher"), d ? "enable" === b ? d.enable() : "disable" === b ? d.disable() : "on" === b ? d.on() : "off" === b ? d.off() : "toggle" === b ? d.toggle() : void 0 : $.data(this, "Switcher", new a(c, b))
        })
    }, $.fn.switcher.Constructor = a
}).call(this);

(function(){
    if ($.validator) {
        $.validator.setDefaults({
            highlight: function(a) {
                return $(a).closest(".form-group").addClass("has-error")
            },
            unhighlight: function(a) {
                return $(a).closest(".form-group").removeClass("has-error").find("help-block-hidden").removeClass("help-block-hidden").addClass("help-block").show()
            },
            errorClass: "jquery-validate-error",
            errorPlacement: function(a, b) {
                var c, d, e;
                e = b.is('input[type="checkbox"]') || b.is('input[type="radio"]');
                return ( b.closest(".form-group").find(".help-block").removeClass("help-block").addClass("help-block-hidden").hide(), a.addClass("help-block"), e ? b.closest('.form-group').append(a) : (c = b.parent(), c.is(".input-group") ? c.parent().append(a) : c.append(a)))
            }
        });
    }
    if (screen.width <= 1024) {
        $('body').addClass('mmc');
    }
}).call(this);

$.extend({
    votetips: function (options) {
        options = $.extend({
            obj: null,  //jq对象，要在那个html标签上显示
            str: "+1",  //字符串，要显示的内容;也可以传一段html，如: "<b style='font-family:Microsoft YaHei;'>+1</b>"
            startSize: "14px",  //动画开始的文字大小
            endSize: "32px",    //动画结束的文字大小
            interval: 600,  //动画时间间隔
            color: "red",    //文字颜色
            callback: function () { }    //回调函数
        }, options);
        var $thebox = $("<span class='text-bold'><i class='fa fa-thumbs-o-up'></i> " + options.str + "</span>");
        $thebox.appendTo($('body'));
        var left = options.obj.offset().left + options.obj.width() / 2;
        var top = options.obj.offset().top - options.obj.height();
        $thebox.css({
            "position": "absolute",
            "left": left + "px",
            "top": top + "px",
            "z-index": 9999,
            "font-size": options.startSize,
            "line-height": options.endSize,
            "color": options.color
        });
        $thebox.animate({
            "font-size": options.endSize,
            "opacity": "0",
            "top": top - parseInt(options.endSize) + "px"
        }, options.interval, function () {
            $thebox.remove();
            options.callback();
        });
    }
});

function enableBackToTop () {
    var backToTop = $('<a>', { id: 'back-to-top', href: '#top', class: 'btn btn-warning btn-outline' });
    var icon = $('<i>', { class: 'fa fa-chevron-up' });

    backToTop.appendTo ('#back-to-top-container');
    icon.appendTo (backToTop);

    backToTop.hide();

    $(window).scroll(function () {
        if ($(this).scrollTop() > 150) {
            backToTop.fadeIn ();
        } else {
            backToTop.fadeOut ();
        }
    });

    backToTop.click (function (e) {
        e.preventDefault ();

        $('body, html').animate({
            scrollTop: 0
        }, 600);
    });
}

$(document).ready(function() {
    enableBackToTop ();

    $('#user-sider-menu .close').click(function () {
        var $p = $(this).parents('.menu-content');
        $p.addClass('fadeOut');
        setTimeout(function () {
            $p.css({ height: $p.outerHeight(), overflow: 'hidden' }).animate({'padding-top': 0, height: $('#main-navbar').outerHeight()}, 500, function () {
                $p.remove();
            });
        }, 300);
        return false;
    });

    $("[data-toggle='tooltip']").tooltip();

    $('li.active.pleaseopenparent').parent().parent('li').addClass('open');

    function goto_problem(pid) {
        if (pid>999 && pid <9999)
            window.location.href = "/yzoix/problems/show/" + pid;
        else
            alert("Problem ID Error!");
    };
    $("#goto_pid").keydown(function(e) {
        if (e.which == 13){
            e.preventDefault();
            var pid = $("#goto_pid").val();
            goto_problem(pid);
        }
    });
    $("#goto_btn").on("click", function() {
        var pid = $("#goto_pid").val();
        goto_problem(pid);
    });

});



