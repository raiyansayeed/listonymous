import { Controller } from 'stimulus'

export default class extends Controller {
    static targets = ["entries", "pagination"]

    connect() {
        console.log("hi infinite scroll")
    }

    scroll() {
        var body = document.body, html = document.documentElement

        var height = Math.max(body.scrollHeight, body.offsetHeight, html.clientHeight, html.scrollHeight, html.offsetHeight);

        if (window.scrollY >= height - window.innerHeight) {
            console.log("bottom")
        }
    }
}