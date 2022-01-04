import { Controller } from 'stimulus'

export default class extends Controller {
    static targets = ["entries", "pagination"]

    connect() {
        // console.log("infinite scroll")
    }

    scroll() {
        var body = document.body, html = document.documentElement

        var height = Math.max(body.scrollHeight, body.offsetHeight, html.clientHeight, html.scrollHeight, html.offsetHeight);

        if (window.scrollY >= height - window.innerHeight) {
            console.log(this);
            let next_page = this.paginationTarget.querySelector("a[rel='next']")
            if (next_page == null) {
                return;
            }
            let url = next_page.href
            console.log("bottom")
            this.loadMore(url);
        }
    }

    loadMore(url) {
        // fetch({
        //     type: "GET",
        //     url: url,
        //     dataType: "json",
        //     success: (data) => {
        //         console.log(data);
        //     }
        // })

        fetch(url, {
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                // 'Content-Type': 'application/x-www-form-urlencoded',
              },
            //   body: JSON.stringify(data) // body data type must match "Content-Type" header
        })
        .then(response => response.json())
        .then(data => {
            this.entriesTarget.insertAdjacentHTML('beforeend', data?.entries)
            this.paginationTarget.innerHTML = data?.pagination
        })

    }
}