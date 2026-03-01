/**
 * Score Runtime — client-side reactive engine.
 *
 * Thin layer over the TC39 Signal polyfill that provides the primitives
 * used by compiler-emitted component scripts.
 *
 * The polyfill (signal-polyfill) must be loaded before this module. In
 * development builds Score serves it from /_score/signal-polyfill.js; in
 * production it is bundled by the asset pipeline.
 */
;(function (global) {
  "use strict";

  var Signal = global.Signal;
  if (!Signal) {
    throw new Error(
      "[Score] Signal polyfill not found. Ensure signal-polyfill is loaded before score-runtime.js"
    );
  }

  var needsEnqueue = true;
  var watcher = new Signal.subtle.Watcher(function () {
    if (needsEnqueue) {
      needsEnqueue = false;
      queueMicrotask(processPending);
    }
  });

  function processPending() {
    needsEnqueue = true;
    for (var s of watcher.getPending()) {
      s.get();
    }
  }

  /**
   * Creates a reactive state signal with the given initial value.
   *
   * @param {*} initial - The initial value.
   * @returns {Signal.State} A mutable signal.
   */
  function state(initial) {
    return new Signal.State(initial);
  }

  /**
   * Creates a computed signal that derives its value from the given function.
   *
   * @param {Function} fn - A function that reads other signals.
   * @returns {Signal.Computed} A read-only derived signal.
   */
  function computed(fn) {
    return new Signal.Computed(fn);
  }

  /**
   * Creates an auto-tracking effect that re-runs whenever any signal it
   * reads changes. Uses the Watcher API with microtask batching.
   *
   * @param {Function} fn - The effect function.
   * @returns {Function} A dispose function that stops the effect.
   */
  function effect(fn) {
    var c = new Signal.Computed(function () {
      fn();
    });
    watcher.watch(c);
    c.get();
    return function dispose() {
      watcher.unwatch(c);
    };
  }

  /**
   * Batches multiple signal writes so that effects run only once after
   * all writes complete.
   *
   * @param {Function} fn - A function that performs multiple .set() calls.
   */
  function batch(fn) {
    Signal.subtle.untrack(fn);
  }

  global.Score = {
    state: state,
    computed: computed,
    effect: effect,
    batch: batch,
  };
})(globalThis);
