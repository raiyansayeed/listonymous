import { Controller } from 'stimulus'
import StimulusReflex from 'stimulus_reflex'

/* This is your ApplicationController.
 * All StimulusReflex controllers should inherit from this class.
 *
 * Example:
 *
 *   import ApplicationController from './application_controller'
 *
 *   export default class extends ApplicationController { ... }
 *
 * Learn more at: https://docs.stimulusreflex.com
 */
export default class extends Controller {

  counter

  connect () {
    StimulusReflex.register(this)
    this.counter = 1;
  }

  search() {
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.stimulate("ListSearch#search");
    }, 200);
  }

  beforeSearch() {
    this.listsList.animate(
      this.fadeIn,
      this.fadeInTiming
    )
  }
  
  get fadeIn() {
    return [
      { opacity: 0 },
      { opacity: 1 }
    ]
  }
  
  get fadeInTiming() {
    return { duration: 300 }
  }
  
  get listsList() {
    return document.getElementById('list-search-results')
  }

  /* Application-wide lifecycle methods
   *
   * Use these methods to handle lifecycle concerns for the entire application.
   * Using the lifecycle is optional, so feel free to delete these stubs if you don't need them.
   *
   * Arguments:
   *
   *   element - the element that triggered the reflex
   *             may be different than the Stimulus controller's this.element
   *
   *   reflex - the name of the reflex e.g. "Example#demo"
   *
   *   error/noop - the error message (for reflexError), otherwise null
   *
   *   reflexId - a UUID4 or developer-provided unique identifier for each Reflex
   */

  beforeReflex (element, reflex, noop, reflexId) {
    if (this.counter) {
      
      this.counter = document.querySelector("#num-viewers").innerText;
    }
  }

  reflexSuccess (element, reflex, noop, reflexId) {
    // show success message
  }

  reflexError (element, reflex, error, reflexId) {
    // show error message
  }

  reflexHalted (element, reflex, error, reflexId) {
    // handle aborted Reflex action
  }

  afterReflex (element, reflex, noop, reflexId) {
    // document.body.classList.remove('wait')
  }

  finalizeReflex (element, reflex, noop, reflexId) {
    // all operations have completed, animation etc is now safe
    document.querySelector("#num-viewers").innerText = this.counter;
  }
}
